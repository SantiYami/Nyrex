// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) => AuthSession(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthSessionToJson(AuthSession instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };
