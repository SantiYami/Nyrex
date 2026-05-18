// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:nyrex/core/crypto/vault_crypto_service.dart';
import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/vault/domain/repositories/vault_repository.dart';

class UnlockVaultParams {
  final String password;
  const UnlockVaultParams(this.password);
}

class UnlockVaultResult {
  final SecretKey masterKey;
  final int lockDurationSeconds;

  UnlockVaultResult({
    required this.masterKey,
    required this.lockDurationSeconds,
  });
}

class UnlockVaultUseCase
    implements UseCase<UnlockVaultResult, UnlockVaultParams> {
  final VaultRepository _repository;

  UnlockVaultUseCase(this._repository);

  @override
  FutureOr<UnlockVaultResult> call(UnlockVaultParams params) async {
    var metadata = await _repository.getMetadata();
    metadata ??= await _repository.initializeMetadata();

    final key = await VaultCryptoService.deriveKey(
      params.password,
      metadata.salt,
    );

    return UnlockVaultResult(
      masterKey: key,
      lockDurationSeconds: metadata.lockDurationSeconds,
    );
  }
}
