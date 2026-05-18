// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';
import 'package:nyrex/core/crypto/vault_crypto_service.dart';
import 'package:nyrex/core/database/app_database.dart';
import 'package:nyrex/modules/vault/domain/repositories/vault_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vault_repository_impl.g.dart';

class VaultRepositoryImpl implements VaultRepository {
  final AppDatabase _db;

  VaultRepositoryImpl(this._db);

  @override
  Future<VaultMetadataData?> getMetadata() async {
    return await _db.getMetadata();
  }

  @override
  Future<VaultMetadataData> initializeMetadata() async {
    final salt = Uint8List.fromList(
      List.generate(16, (_) => Random().nextInt(256)),
    );
    await _db.setMetadata(
      VaultMetadataCompanion.insert(salt: salt, derivationStrategy: 'shared'),
    );
    return (await _db.getMetadata())!;
  }

  @override
  Future<void> saveVaultEntry({
    required int noteId,
    required String fileName,
    required Uint8List fileBytes,
    required String mimeType,
    required SecretKey masterKey,
  }) async {
    final cipherText = await VaultCryptoService.encryptBytes(
      fileBytes,
      masterKey,
    );
    final nonce = cipherText.sublist(0, 12);

    await _db.insertVaultEntry(
      VaultEntriesCompanion.insert(
        noteId: noteId,
        fileCipher: cipherText,
        nonce: nonce,
        mimeType: Value(mimeType),
        fileSize: fileBytes.length,
      ),
    );
  }

  @override
  Future<List<VaultEntry>> getVaultEntriesForNote(int noteId) async {
    return (_db.select(
      _db.vaultEntries,
    )..where((t) => t.noteId.equals(noteId))).get();
  }
}

@riverpod
VaultRepository vaultRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return VaultRepositoryImpl(db);
}
