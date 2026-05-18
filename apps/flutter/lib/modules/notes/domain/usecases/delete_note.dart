// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';

import 'package:nyrex/core/usecases/usecase.dart';
import 'package:nyrex/modules/notes/domain/repositories/notes_repository.dart';

class DeleteNoteParams {
  final int id;
  const DeleteNoteParams(this.id);
}

class DeleteNoteUseCase implements UseCase<void, DeleteNoteParams> {
  final NotesRepository _repository;

  DeleteNoteUseCase(this._repository);

  @override
  FutureOr<void> call(DeleteNoteParams params) {
    return _repository.deleteNote(params.id);
  }
}
