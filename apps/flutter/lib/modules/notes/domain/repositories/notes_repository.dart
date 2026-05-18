// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:cryptography/cryptography.dart';
import 'package:nyrex/modules/notes/data/models/note_model.dart';

abstract class NotesRepository {
  Future<List<NoteModel>> getAllDecryptedNotes(SecretKey masterKey);
  Future<void> saveNote({
    required String title,
    required String content,
    required SecretKey masterKey,
  });
  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
    required SecretKey masterKey,
    int? currentVersion,
  });
  Future<void> deleteNote(int id);
}
