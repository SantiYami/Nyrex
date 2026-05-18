// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'dart:async';
import 'dart:typed_data';

import 'package:nyrex/modules/notes/data/datasources/sync_service.dart';
import 'package:nyrex/modules/notes/data/models/note_model.dart';
import 'package:nyrex/modules/notes/data/repositories/notes_repository_impl.dart';
import 'package:nyrex/modules/notes/domain/usecases/delete_note.dart';
import 'package:nyrex/modules/notes/domain/usecases/save_note.dart';
import 'package:nyrex/modules/notes/domain/usecases/update_note.dart';
import 'package:nyrex/modules/vault/domain/usecases/save_vault_entry.dart';
import 'package:nyrex/modules/vault/presentation/providers/vault_auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notes_provider.g.dart';

@riverpod
SaveNoteUseCase saveNoteUseCase(Ref ref) {
  final repo = ref.watch(notesRepositoryProvider);
  return SaveNoteUseCase(repo);
}

@riverpod
UpdateNoteUseCase updateNoteUseCase(Ref ref) {
  final repo = ref.watch(notesRepositoryProvider);
  return UpdateNoteUseCase(repo);
}

@riverpod
DeleteNoteUseCase deleteNoteUseCase(Ref ref) {
  final repo = ref.watch(notesRepositoryProvider);
  return DeleteNoteUseCase(repo);
}

@Riverpod(keepAlive: true)
class NotesState extends _$NotesState {
  @override
  FutureOr<List<NoteModel>> build() async {
    final masterKey = ref.watch(vaultAuthStateProvider);

    if (masterKey != null) {
      final repo = ref.read(notesRepositoryProvider);
      return repo.getAllDecryptedNotes(masterKey);
    }
    return [];
  }

  Future<void> addNote(String title, String content) async {
    final masterKey = ref.read(vaultAuthStateProvider);
    if (masterKey == null) return;
    ref.read(vaultAuthStateProvider.notifier).poke();

    final usecase = ref.read(saveNoteUseCaseProvider);
    await usecase(
      SaveNoteParams(title: title, content: content, masterKey: masterKey),
    );

    ref.invalidateSelf();
    unawaited(ref.read(syncServiceProvider).syncNotes());
  }

  Future<void> updateNote(int id, String title, String content) async {
    final masterKey = ref.read(vaultAuthStateProvider);
    if (masterKey == null) return;
    ref.read(vaultAuthStateProvider.notifier).poke();

    final notes = state.value ?? [];
    final currentNote = notes.firstWhere((n) => n.id == id);

    final usecase = ref.read(updateNoteUseCaseProvider);
    await usecase(
      UpdateNoteParams(
        id: id,
        title: title,
        content: content,
        masterKey: masterKey,
        currentVersion: currentNote.version,
      ),
    );

    ref.invalidateSelf();
    unawaited(ref.read(syncServiceProvider).syncNotes());
  }

  Future<void> deleteNote(int id) async {
    final masterKey = ref.read(vaultAuthStateProvider);
    if (masterKey == null) return;
    ref.read(vaultAuthStateProvider.notifier).poke();

    final usecase = ref.read(deleteNoteUseCaseProvider);
    await usecase(DeleteNoteParams(id));

    ref.invalidateSelf();
  }

  Future<void> addVaultEntry({
    required int noteId,
    required String fileName,
    required Uint8List fileBytes,
    required String mimeType,
  }) async {
    final masterKey = ref.read(vaultAuthStateProvider);
    if (masterKey == null) return;
    ref.read(vaultAuthStateProvider.notifier).poke();

    final usecase = ref.read(saveVaultEntryUseCaseProvider);
    await usecase(
      SaveVaultEntryParams(
        noteId: noteId,
        fileName: fileName,
        fileBytes: fileBytes,
        mimeType: mimeType,
        masterKey: masterKey,
      ),
    );

    unawaited(ref.read(syncServiceProvider).syncNotes());
  }
}
