// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/auth/domain/repositories/auth_repository.dart';

class LogoutUserUseCase implements UseCase<void, NoParams> {
  final AuthRepository _repository;

  LogoutUserUseCase(this._repository);

  @override
  FutureOr<void> call(NoParams params) {
    return _repository.logout();
  }
}
