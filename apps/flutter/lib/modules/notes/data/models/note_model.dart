// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

class NoteModel {
  final int id;
  final String? serverId;
  final String title;
  final String content;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({
    required this.id,
    this.serverId,
    required this.title,
    required this.content,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  NoteModel copyWith({
    String? serverId,
    String? title,
    String? content,
    int? version,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id,
      serverId: serverId ?? this.serverId,
      title: title ?? this.title,
      content: content ?? this.content,
      version: version ?? this.version,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
