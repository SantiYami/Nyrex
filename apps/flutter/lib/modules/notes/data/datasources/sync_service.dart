// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:nyrex/core/database/app_database.dart';
import 'package:nyrex/core/logger/app_logger.dart';
import 'package:nyrex/core/logger/logger_provider.dart';
import 'package:nyrex/core/network/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_service.g.dart';

/// Service responsible for orchestrating the optimistic sync between
/// the local Drift database and the Rust Sync Hub.
class SyncService {
  final ApiClient _api;
  final AppDatabase _db;
  final AppLogger _logger;

  SyncService(this._api, this._db, this._logger);

  /// Performs a full synchronization of pending notes.
  Future<void> syncNotes() async {
    // 1. Fetch local notes that need syncing (isSynced = false)
    final pendingNotes = await (_db.select(
      _db.noteEntries,
    )..where((t) => t.isSynced.equals(false))).get();

    if (pendingNotes.isEmpty) return;

    // 2. Map to Backend models
    final payload = pendingNotes
        .map(
          (n) => {
            'id': n.serverId ?? _generateTempUuid(), // Using UUIDs for sync
            'user_id':
                '00000000-0000-0000-0000-000000000000', // Server extracts this from JWT
            'title_cipher': base64Encode(n.titleCipher),
            'content_cipher': base64Encode(n.contentCipher),
            'nonce': base64Encode(n.nonce),
            'version': n.version,
            'created_at': n.createdAt.toUtc().toIso8601String(),
            'updated_at': n.updatedAt.toUtc().toIso8601String(),
          },
        )
        .toList();

    try {
      final response = await _api.dio.post('/api/v1/sync/notes', data: payload);
      final results = response.data as List<dynamic>;

      for (var i = 0; i < results.length; i++) {
        final result = results[i];
        final localNote = pendingNotes[i];

        if (result['Success'] != null) {
          final serverNote = result['Success'];
          // Mark as synced and update serverId if it was new
          await (_db.update(
            _db.noteEntries,
          )..where((t) => t.id.equals(localNote.id))).write(
            NoteEntriesCompanion(
              isSynced: const Value(true),
              serverId: Value(serverNote['id']),
              version: Value(serverNote['version']),
            ),
          );
        } else if (result['Conflict'] != null) {
          final serverNote = result['Conflict']['server_version'];
          await (_db.update(
            _db.noteEntries,
          )..where((t) => t.id.equals(localNote.id))).write(
            NoteEntriesCompanion(
              // Using List<int>.from because serde standard JSON serializes Vec<u8> as array of ints
              titleCipher: Value(
                Uint8List.fromList(List<int>.from(serverNote['title_cipher'])),
              ),
              contentCipher: Value(
                Uint8List.fromList(
                  List<int>.from(serverNote['content_cipher']),
                ),
              ),
              nonce: Value(
                Uint8List.fromList(List<int>.from(serverNote['nonce'])),
              ),
              version: Value(serverNote['version']),
              isSynced: const Value(true),
              serverId: Value(serverNote['id']),
            ),
          );
          _logger.warning(
            'Conflict auto-resolved: Local note ${localNote.id} overwritten by server version ${serverNote['version']}',
          );
        }
      }

      // 3. Sync Attachments
      final pendingVaultEntries = await (_db.select(
        _db.vaultEntries,
      )..where((t) => t.serverId.isNull())).get();

      for (final entry in pendingVaultEntries) {
        final vaultEntryPayload = {
          'id': entry.serverId ?? _generateTempUuid(),
          'note_id': '00000000-0000-0000-0000-000000000000',
          'user_id': '00000000-0000-0000-0000-000000000000',
          'file_cipher': base64Encode(entry.fileCipher),
          'nonce': base64Encode(entry.nonce),
          'mime_type': entry.mimeType,
          'file_size': entry.fileSize,
          'created_at': entry.createdAt.toUtc().toIso8601String(),
        };

        final entryResponse = await _api.dio.post(
          '/api/v1/sync/vault_entries',
          data: vaultEntryPayload,
        );
        if (entryResponse.data['Success'] != null) {
          final sId = entryResponse.data['Success'];
          await (_db.update(_db.vaultEntries)
                ..where((t) => t.id.equals(entry.id)))
              .write(VaultEntriesCompanion(serverId: Value(sId)));
        }
      }
    } catch (e, stackTrace) {
      _logger.error('Sync failed: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  String _generateTempUuid() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}

@riverpod
SyncService syncService(Ref ref) {
  final api = ref.read(apiClientProvider);
  final db = ref.read(appDatabaseProvider);
  final logger = ref.read(loggerProvider);
  return SyncService(api, db, logger);
}
