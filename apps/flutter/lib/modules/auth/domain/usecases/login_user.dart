// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/auth/data/models/auth_session.dart';
import 'package:nyrex/modules/auth/domain/repositories/auth_repository.dart';

class LoginUserParams {
  final String email;
  final String password;
  const LoginUserParams(this.email, this.password);
}

class LoginUserUseCase implements UseCase<AuthSession, LoginUserParams> {
  final AuthRepository _repository;

  LoginUserUseCase(this._repository);

  @override
  FutureOr<AuthSession> call(LoginUserParams params) {
    return _repository.login(params.email, params.password);
  }
}
