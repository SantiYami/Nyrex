// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/auth/data/models/auth_session.dart';
import 'package:nyrex/modules/auth/domain/repositories/auth_repository.dart';

class GetSessionUseCase implements UseCase<AuthSession?, NoParams> {
  final AuthRepository _repository;

  GetSessionUseCase(this._repository);

  @override
  FutureOr<AuthSession?> call(NoParams params) {
    return _repository.getSession();
  }
}
