// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:nyrex/modules/vault/data/repositories/vault_repository_impl.dart';
import 'package:nyrex/modules/vault/domain/usecases/save_vault_entry.dart';
import 'package:nyrex/modules/vault/domain/usecases/unlock_vault.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vault_auth_provider.g.dart';

@riverpod
UnlockVaultUseCase unlockVaultUseCase(Ref ref) {
  final repo = ref.watch(vaultRepositoryProvider);
  return UnlockVaultUseCase(repo);
}

@riverpod
SaveVaultEntryUseCase saveVaultEntryUseCase(Ref ref) {
  final repo = ref.watch(vaultRepositoryProvider);
  return SaveVaultEntryUseCase(repo);
}

@Riverpod(keepAlive: true)
class VaultAuthState extends _$VaultAuthState {
  SecretKey? _masterKey;
  Timer? _lockTimer;
  int _lockDurationSeconds = 600; // Default 10 minutes

  @override
  SecretKey? build() {
    return _masterKey;
  }

  bool get isLocked => _masterKey == null;
  SecretKey? get masterKey => _masterKey;

  Future<void> unlock(String password) async {
    try {
      final usecase = ref.read(unlockVaultUseCaseProvider);
      final result = await usecase(UnlockVaultParams(password));

      _masterKey = result.masterKey;
      _lockDurationSeconds = result.lockDurationSeconds;
      _resetLockTimer();
      state = _masterKey;
    } catch (e) {
      _masterKey = null;
      state = null;
      rethrow;
    }
  }

  void lock() {
    _masterKey = null;
    _lockTimer?.cancel();
    state = null;
  }

  void poke() {
    if (!isLocked) {
      _resetLockTimer();
    }
  }

  void _resetLockTimer() {
    _lockTimer?.cancel();
    _lockTimer = Timer(Duration(seconds: _lockDurationSeconds), lock);
  }
}
