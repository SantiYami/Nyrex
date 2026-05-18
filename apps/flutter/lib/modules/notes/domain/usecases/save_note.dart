// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/notes/domain/repositories/notes_repository.dart';

class SaveNoteParams {
  final String title;
  final String content;
  final SecretKey masterKey;
  const SaveNoteParams({
    required this.title,
    required this.content,
    required this.masterKey,
  });
}

class SaveNoteUseCase implements UseCase<void, SaveNoteParams> {
  final NotesRepository _repository;

  SaveNoteUseCase(this._repository);

  @override
  FutureOr<void> call(SaveNoteParams params) {
    return _repository.saveNote(
      title: params.title,
      content: params.content,
      masterKey: params.masterKey,
    );
  }
}
