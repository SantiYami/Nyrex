// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:nyrex/core/database/app_database.dart';

abstract class VaultRepository {
  Future<VaultMetadataData?> getMetadata();
  Future<VaultMetadataData> initializeMetadata();
  Future<void> saveVaultEntry({
    required int noteId,
    required String fileName,
    required Uint8List fileBytes,
    required String mimeType,
    required SecretKey masterKey,
  });
  Future<List<VaultEntry>> getVaultEntriesForNote(int noteId);
}
