// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

/// Table storing encrypted notes.
/// All text fields are stored as [Uint8List] because they are encrypted blobs.
class NoteEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().nullable()(); // UUID from backend
  BlobColumn get titleCipher => blob()();
  BlobColumn get contentCipher => blob()();
  BlobColumn get nonce => blob()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  // To handle multi-device sync
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

/// Table storing encrypted file attachments locally.
class VaultEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get serverId => text().nullable()();
  IntColumn get noteId => integer().references(NoteEntries, #id)();
  BlobColumn get fileCipher => blob()();
  BlobColumn get nonce => blob()();
  TextColumn get mimeType => text().nullable()();
  IntColumn get fileSize => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Table storing vault configuration and crypto salt.
class VaultMetadata extends Table {
  IntColumn get id => integer().autoIncrement()();
  BlobColumn get salt => blob()(); // Random salt for Argon2
  TextColumn get derivationStrategy => text()(); // 'shared' or 'separate'
  IntColumn get lockDurationSeconds =>
      integer().withDefault(const Constant(600))(); // default 10min
}

@DriftDatabase(tables: [NoteEntries, VaultEntries, VaultMetadata])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Simple CRUD for Notes
  Future<List<NoteEntry>> getAllNotes() => select(noteEntries).get();
  Future<int> insertNote(NoteEntriesCompanion entry) =>
      into(noteEntries).insert(entry);
  Future<bool> updateNote(NoteEntriesCompanion entry) =>
      update(noteEntries).replace(entry);
  Future<int> deleteNote(NoteEntry entry) => delete(noteEntries).delete(entry);

  // Attachment CRUD
  Future<int> insertVaultEntry(VaultEntriesCompanion entry) =>
      into(vaultEntries).insert(entry);

  // Metadata access
  Future<VaultMetadataData?> getMetadata() =>
      select(vaultMetadata).getSingleOrNull();
  Future<int> setMetadata(VaultMetadataCompanion entry) =>
      into(vaultMetadata).insert(entry);
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'nyrex_vault',
    native: DriftNativeOptions(
      databaseDirectory: getApplicationSupportDirectory,
    ),
  );
}

@riverpod
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}
