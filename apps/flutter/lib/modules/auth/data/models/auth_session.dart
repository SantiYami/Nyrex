// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'auth_session.g.dart';

@JsonSerializable()
class AuthSession {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSessionToJson(this);
}
