// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:nyrex/modules/auth/data/models/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession?> getSession();
  Future<AuthSession> login(String email, String password);
  Future<AuthSession> register(String email, String username, String password);
  Future<void> logout();
}
