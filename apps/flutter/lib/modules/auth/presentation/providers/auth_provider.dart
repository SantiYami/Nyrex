// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/auth/data/models/auth_session.dart';
import 'package:nyrex/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:nyrex/modules/auth/domain/usecases/get_session.dart';
import 'package:nyrex/modules/auth/domain/usecases/login_user.dart';
import 'package:nyrex/modules/auth/domain/usecases/logout_user.dart';
import 'package:nyrex/modules/auth/domain/usecases/register_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
Future<GetSessionUseCase> getSessionUseCase(Ref ref) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return GetSessionUseCase(repo);
}

@riverpod
Future<LoginUserUseCase> loginUserUseCase(Ref ref) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return LoginUserUseCase(repo);
}

@riverpod
Future<RegisterUserUseCase> registerUserUseCase(Ref ref) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return RegisterUserUseCase(repo);
}

@riverpod
Future<LogoutUserUseCase> logoutUserUseCase(Ref ref) async {
  final repo = await ref.watch(authRepositoryProvider.future);
  return LogoutUserUseCase(repo);
}

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  FutureOr<AuthSession?> build() async {
    final usecase = await ref.read(getSessionUseCaseProvider.future);
    return usecase(const NoParams());
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final usecase = await ref.read(loginUserUseCaseProvider.future);
      return usecase(LoginUserParams(email, password));
    });
  }

  Future<void> register(String email, String username, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final usecase = await ref.read(registerUserUseCaseProvider.future);
      return usecase(RegisterUserParams(email, username, password));
    });
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final usecase = await ref.read(logoutUserUseCaseProvider.future);
    await usecase(const NoParams());
    state = const AsyncValue.data(null);
  }
}
