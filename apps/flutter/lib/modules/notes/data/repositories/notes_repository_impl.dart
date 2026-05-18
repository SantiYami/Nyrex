// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';
import 'package:nyrex/core/crypto/vault_crypto_service.dart';
import 'package:nyrex/core/database/app_database.dart';
import 'package:nyrex/modules/notes/data/models/note_model.dart';
import 'package:nyrex/modules/notes/domain/repositories/notes_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notes_repository_impl.g.dart';

class NotesRepositoryImpl implements NotesRepository {
  final AppDatabase _db;

  NotesRepositoryImpl(this._db);

  /// Loads all notes and decrypts them using the provided [masterKey].
  @override
  Future<List<NoteModel>> getAllDecryptedNotes(SecretKey masterKey) async {
    final entries = await _db.getAllNotes();
    final List<NoteModel> notes = [];

    for (final entry in entries) {
      try {
        final title = await VaultCryptoService.decrypt(
          entry.titleCipher,
          masterKey,
        );
        final content = await VaultCryptoService.decrypt(
          entry.contentCipher,
          masterKey,
        );

        notes.add(
          NoteModel(
            id: entry.id,
            serverId: entry.serverId,
            title: title,
            content: content,
            version: entry.version,
            createdAt: entry.createdAt,
            updatedAt: entry.updatedAt,
          ),
        );
      } catch (e) {
        continue;
      }
    }

    notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return notes;
  }

  /// Encrypts and saves a new note.
  @override
  Future<void> saveNote({
    required String title,
    required String content,
    required SecretKey masterKey,
  }) async {
    final titleCipher = await VaultCryptoService.encrypt(title, masterKey);
    final contentCipher = await VaultCryptoService.encrypt(content, masterKey);

    await _db.insertNote(
      NoteEntriesCompanion.insert(
        titleCipher: titleCipher,
        contentCipher: contentCipher,
        nonce: titleCipher.sublist(
          0,
          12,
        ), // Storing a copy of nonce for DB-level access if needed
        version: const Value(1),
        isSynced: const Value(false),
      ),
    );
  }

  /// Updates an existing note.
  @override
  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
    required SecretKey masterKey,
    int? currentVersion,
  }) async {
    final titleCipher = await VaultCryptoService.encrypt(title, masterKey);
    final contentCipher = await VaultCryptoService.encrypt(content, masterKey);

    await _db.updateNote(
      NoteEntriesCompanion(
        id: Value(id),
        titleCipher: Value(titleCipher),
        contentCipher: Value(contentCipher),
        nonce: Value(titleCipher.sublist(0, 12)),
        version: Value((currentVersion ?? 1) + 1),
        isSynced: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Deletes a note.
  @override
  Future<void> deleteNote(int id) async {
    // We only need the ID to delete, no key required for deletion.
    await _db.deleteNote(
      NoteEntry(
        id: id,
        titleCipher: Uint8List(0),
        contentCipher: Uint8List(0),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isSynced: false,
        nonce: Uint8List(0),
        version: 1,
      ),
    );
  }
}

@riverpod
NotesRepository notesRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return NotesRepositoryImpl(db);
}
