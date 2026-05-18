// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/auth/data/models/auth_session.dart';
import 'package:nyrex/modules/auth/domain/repositories/auth_repository.dart';

class RegisterUserParams {
  final String email;
  final String username;
  final String password;
  const RegisterUserParams(this.email, this.username, this.password);
}

class RegisterUserUseCase implements UseCase<AuthSession, RegisterUserParams> {
  final AuthRepository _repository;

  RegisterUserUseCase(this._repository);

  @override
  FutureOr<AuthSession> call(RegisterUserParams params) {
    return _repository.register(params.email, params.username, params.password);
  }
}
