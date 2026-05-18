// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String username;

  UserModel({required this.id, required this.email, required this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
