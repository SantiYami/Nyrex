// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/vault/domain/repositories/vault_repository.dart';

class SaveVaultEntryParams {
  final int noteId;
  final String fileName;
  final Uint8List fileBytes;
  final String mimeType;
  final SecretKey masterKey;

  const SaveVaultEntryParams({
    required this.noteId,
    required this.fileName,
    required this.fileBytes,
    required this.mimeType,
    required this.masterKey,
  });
}

class SaveVaultEntryUseCase implements UseCase<void, SaveVaultEntryParams> {
  final VaultRepository _repository;

  SaveVaultEntryUseCase(this._repository);

  @override
  FutureOr<void> call(SaveVaultEntryParams params) {
    return _repository.saveVaultEntry(
      noteId: params.noteId,
      fileName: params.fileName,
      fileBytes: params.fileBytes,
      mimeType: params.mimeType,
      masterKey: params.masterKey,
    );
  }
}
