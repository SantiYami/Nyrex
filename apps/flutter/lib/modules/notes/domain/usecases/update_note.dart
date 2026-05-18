// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/notes/domain/repositories/notes_repository.dart';

class UpdateNoteParams {
  final int id;
  final String title;
  final String content;
  final SecretKey masterKey;
  final int? currentVersion;

  const UpdateNoteParams({
    required this.id,
    required this.title,
    required this.content,
    required this.masterKey,
    this.currentVersion,
  });
}

class UpdateNoteUseCase implements UseCase<void, UpdateNoteParams> {
  final NotesRepository _repository;

  UpdateNoteUseCase(this._repository);

  @override
  FutureOr<void> call(UpdateNoteParams params) {
    return _repository.updateNote(
      id: params.id,
      title: params.title,
      content: params.content,
      masterKey: params.masterKey,
      currentVersion: params.currentVersion,
    );
  }
}
