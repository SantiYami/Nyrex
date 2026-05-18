// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nyrex/core/network/api_client.dart';
import 'package:nyrex/modules/auth/data/models/auth_session.dart';
import 'package:nyrex/modules/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository_impl.g.dart';

const _kSessionKey = 'nyrex_auth_session';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _client;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._client, this._prefs);

  @override
  Future<AuthSession?> getSession() async {
    final rawSession = _prefs.getString(_kSessionKey);
    if (rawSession != null) {
      try {
        return AuthSession.fromJson(jsonDecode(rawSession));
      } catch (_) {
        await _prefs.remove(_kSessionKey);
      }
    }
    return null;
  }

  @override
  Future<AuthSession> login(String email, String password) async {
    final response = await _client.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final session = AuthSession.fromJson(response.data);
    await _prefs.setString(_kSessionKey, jsonEncode(session.toJson()));
    return session;
  }

  @override
  Future<AuthSession> register(
    String email,
    String username,
    String password,
  ) async {
    final response = await _client.post(
      '/auth/register',
      data: {'email': email, 'username': username, 'password': password},
    );
    final session = AuthSession.fromJson(response.data);
    await _prefs.setString(_kSessionKey, jsonEncode(session.toJson()));
    return session;
  }

  @override
  Future<void> logout() async {
    await _prefs.remove(_kSessionKey);
  }
}

@riverpod
Future<AuthRepository> authRepository(Ref ref) async {
  final client = ref.watch(dioClientProvider);
  final prefs = await SharedPreferences.getInstance();
  return AuthRepositoryImpl(client, prefs);
}
