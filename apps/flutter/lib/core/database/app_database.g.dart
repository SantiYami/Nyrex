// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NoteEntriesTable extends NoteEntries
    with TableInfo<$NoteEntriesTable, NoteEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleCipherMeta = const VerificationMeta(
    'titleCipher',
  );
  @override
  late final GeneratedColumn<Uint8List> titleCipher =
      GeneratedColumn<Uint8List>(
        'title_cipher',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _contentCipherMeta = const VerificationMeta(
    'contentCipher',
  );
  @override
  late final GeneratedColumn<Uint8List> contentCipher =
      GeneratedColumn<Uint8List>(
        'content_cipher',
        aliasedName,
        false,
        type: DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _nonceMeta = const VerificationMeta('nonce');
  @override
  late final GeneratedColumn<Uint8List> nonce = GeneratedColumn<Uint8List>(
    'nonce',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    titleCipher,
    contentCipher,
    nonce,
    version,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'note_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<NoteEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('title_cipher')) {
      context.handle(
        _titleCipherMeta,
        titleCipher.isAcceptableOrUnknown(
          data['title_cipher']!,
          _titleCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_titleCipherMeta);
    }
    if (data.containsKey('content_cipher')) {
      context.handle(
        _contentCipherMeta,
        contentCipher.isAcceptableOrUnknown(
          data['content_cipher']!,
          _contentCipherMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentCipherMeta);
    }
    if (data.containsKey('nonce')) {
      context.handle(
        _nonceMeta,
        nonce.isAcceptableOrUnknown(data['nonce']!, _nonceMeta),
      );
    } else if (isInserting) {
      context.missing(_nonceMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      titleCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}title_cipher'],
      )!,
      contentCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}content_cipher'],
      )!,
      nonce: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}nonce'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $NoteEntriesTable createAlias(String alias) {
    return $NoteEntriesTable(attachedDatabase, alias);
  }
}

class NoteEntry extends DataClass implements Insertable<NoteEntry> {
  final int id;
  final String? serverId;
  final Uint8List titleCipher;
  final Uint8List contentCipher;
  final Uint8List nonce;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const NoteEntry({
    required this.id,
    this.serverId,
    required this.titleCipher,
    required this.contentCipher,
    required this.nonce,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['title_cipher'] = Variable<Uint8List>(titleCipher);
    map['content_cipher'] = Variable<Uint8List>(contentCipher);
    map['nonce'] = Variable<Uint8List>(nonce);
    map['version'] = Variable<int>(version);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  NoteEntriesCompanion toCompanion(bool nullToAbsent) {
    return NoteEntriesCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      titleCipher: Value(titleCipher),
      contentCipher: Value(contentCipher),
      nonce: Value(nonce),
      version: Value(version),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory NoteEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteEntry(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      titleCipher: serializer.fromJson<Uint8List>(json['titleCipher']),
      contentCipher: serializer.fromJson<Uint8List>(json['contentCipher']),
      nonce: serializer.fromJson<Uint8List>(json['nonce']),
      version: serializer.fromJson<int>(json['version']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'titleCipher': serializer.toJson<Uint8List>(titleCipher),
      'contentCipher': serializer.toJson<Uint8List>(contentCipher),
      'nonce': serializer.toJson<Uint8List>(nonce),
      'version': serializer.toJson<int>(version),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  NoteEntry copyWith({
    int? id,
    Value<String?> serverId = const Value.absent(),
    Uint8List? titleCipher,
    Uint8List? contentCipher,
    Uint8List? nonce,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => NoteEntry(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    titleCipher: titleCipher ?? this.titleCipher,
    contentCipher: contentCipher ?? this.contentCipher,
    nonce: nonce ?? this.nonce,
    version: version ?? this.version,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  NoteEntry copyWithCompanion(NoteEntriesCompanion data) {
    return NoteEntry(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      titleCipher: data.titleCipher.present
          ? data.titleCipher.value
          : this.titleCipher,
      contentCipher: data.contentCipher.present
          ? data.contentCipher.value
          : this.contentCipher,
      nonce: data.nonce.present ? data.nonce.value : this.nonce,
      version: data.version.present ? data.version.value : this.version,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NoteEntry(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('titleCipher: $titleCipher, ')
          ..write('contentCipher: $contentCipher, ')
          ..write('nonce: $nonce, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    $driftBlobEquality.hash(titleCipher),
    $driftBlobEquality.hash(contentCipher),
    $driftBlobEquality.hash(nonce),
    version,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteEntry &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          $driftBlobEquality.equals(other.titleCipher, this.titleCipher) &&
          $driftBlobEquality.equals(other.contentCipher, this.contentCipher) &&
          $driftBlobEquality.equals(other.nonce, this.nonce) &&
          other.version == this.version &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class NoteEntriesCompanion extends UpdateCompanion<NoteEntry> {
  final Value<int> id;
  final Value<String?> serverId;
  final Value<Uint8List> titleCipher;
  final Value<Uint8List> contentCipher;
  final Value<Uint8List> nonce;
  final Value<int> version;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  const NoteEntriesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.titleCipher = const Value.absent(),
    this.contentCipher = const Value.absent(),
    this.nonce = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  });
  NoteEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    required Uint8List titleCipher,
    required Uint8List contentCipher,
    required Uint8List nonce,
    this.version = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
  }) : titleCipher = Value(titleCipher),
       contentCipher = Value(contentCipher),
       nonce = Value(nonce);
  static Insertable<NoteEntry> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<Uint8List>? titleCipher,
    Expression<Uint8List>? contentCipher,
    Expression<Uint8List>? nonce,
    Expression<int>? version,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (titleCipher != null) 'title_cipher': titleCipher,
      if (contentCipher != null) 'content_cipher': contentCipher,
      if (nonce != null) 'nonce': nonce,
      if (version != null) 'version': version,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
    });
  }

  NoteEntriesCompanion copyWith({
    Value<int>? id,
    Value<String?>? serverId,
    Value<Uint8List>? titleCipher,
    Value<Uint8List>? contentCipher,
    Value<Uint8List>? nonce,
    Value<int>? version,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
  }) {
    return NoteEntriesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      titleCipher: titleCipher ?? this.titleCipher,
      contentCipher: contentCipher ?? this.contentCipher,
      nonce: nonce ?? this.nonce,
      version: version ?? this.version,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (titleCipher.present) {
      map['title_cipher'] = Variable<Uint8List>(titleCipher.value);
    }
    if (contentCipher.present) {
      map['content_cipher'] = Variable<Uint8List>(contentCipher.value);
    }
    if (nonce.present) {
      map['nonce'] = Variable<Uint8List>(nonce.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteEntriesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('titleCipher: $titleCipher, ')
          ..write('contentCipher: $contentCipher, ')
          ..write('nonce: $nonce, ')
          ..write('version: $version, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }
}

class $VaultEntriesTable extends VaultEntries
    with TableInfo<$VaultEntriesTable, VaultEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
    'note_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES note_entries (id)',
    ),
  );
  static const VerificationMeta _fileCipherMeta = const VerificationMeta(
    'fileCipher',
  );
  @override
  late final GeneratedColumn<Uint8List> fileCipher = GeneratedColumn<Uint8List>(
    'file_cipher',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nonceMeta = const VerificationMeta('nonce');
  @override
  late final GeneratedColumn<Uint8List> nonce = GeneratedColumn<Uint8List>(
    'nonce',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    noteId,
    fileCipher,
    nonce,
    mimeType,
    fileSize,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vault_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<VaultEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('note_id')) {
      context.handle(
        _noteIdMeta,
        noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('file_cipher')) {
      context.handle(
        _fileCipherMeta,
        fileCipher.isAcceptableOrUnknown(data['file_cipher']!, _fileCipherMeta),
      );
    } else if (isInserting) {
      context.missing(_fileCipherMeta);
    }
    if (data.containsKey('nonce')) {
      context.handle(
        _nonceMeta,
        nonce.isAcceptableOrUnknown(data['nonce']!, _nonceMeta),
      );
    } else if (isInserting) {
      context.missing(_nonceMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaultEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      noteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}note_id'],
      )!,
      fileCipher: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}file_cipher'],
      )!,
      nonce: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}nonce'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VaultEntriesTable createAlias(String alias) {
    return $VaultEntriesTable(attachedDatabase, alias);
  }
}

class VaultEntry extends DataClass implements Insertable<VaultEntry> {
  final int id;
  final String? serverId;
  final int noteId;
  final Uint8List fileCipher;
  final Uint8List nonce;
  final String? mimeType;
  final int fileSize;
  final DateTime createdAt;
  const VaultEntry({
    required this.id,
    this.serverId,
    required this.noteId,
    required this.fileCipher,
    required this.nonce,
    this.mimeType,
    required this.fileSize,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['note_id'] = Variable<int>(noteId);
    map['file_cipher'] = Variable<Uint8List>(fileCipher);
    map['nonce'] = Variable<Uint8List>(nonce);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    map['file_size'] = Variable<int>(fileSize);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VaultEntriesCompanion toCompanion(bool nullToAbsent) {
    return VaultEntriesCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      noteId: Value(noteId),
      fileCipher: Value(fileCipher),
      nonce: Value(nonce),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      fileSize: Value(fileSize),
      createdAt: Value(createdAt),
    );
  }

  factory VaultEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultEntry(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      noteId: serializer.fromJson<int>(json['noteId']),
      fileCipher: serializer.fromJson<Uint8List>(json['fileCipher']),
      nonce: serializer.fromJson<Uint8List>(json['nonce']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'noteId': serializer.toJson<int>(noteId),
      'fileCipher': serializer.toJson<Uint8List>(fileCipher),
      'nonce': serializer.toJson<Uint8List>(nonce),
      'mimeType': serializer.toJson<String?>(mimeType),
      'fileSize': serializer.toJson<int>(fileSize),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VaultEntry copyWith({
    int? id,
    Value<String?> serverId = const Value.absent(),
    int? noteId,
    Uint8List? fileCipher,
    Uint8List? nonce,
    Value<String?> mimeType = const Value.absent(),
    int? fileSize,
    DateTime? createdAt,
  }) => VaultEntry(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    noteId: noteId ?? this.noteId,
    fileCipher: fileCipher ?? this.fileCipher,
    nonce: nonce ?? this.nonce,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    fileSize: fileSize ?? this.fileSize,
    createdAt: createdAt ?? this.createdAt,
  );
  VaultEntry copyWithCompanion(VaultEntriesCompanion data) {
    return VaultEntry(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      noteId: data.noteId.present ? data.noteId.value : this.noteId,
      fileCipher: data.fileCipher.present
          ? data.fileCipher.value
          : this.fileCipher,
      nonce: data.nonce.present ? data.nonce.value : this.nonce,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultEntry(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('noteId: $noteId, ')
          ..write('fileCipher: $fileCipher, ')
          ..write('nonce: $nonce, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSize: $fileSize, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    noteId,
    $driftBlobEquality.hash(fileCipher),
    $driftBlobEquality.hash(nonce),
    mimeType,
    fileSize,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultEntry &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.noteId == this.noteId &&
          $driftBlobEquality.equals(other.fileCipher, this.fileCipher) &&
          $driftBlobEquality.equals(other.nonce, this.nonce) &&
          other.mimeType == this.mimeType &&
          other.fileSize == this.fileSize &&
          other.createdAt == this.createdAt);
}

class VaultEntriesCompanion extends UpdateCompanion<VaultEntry> {
  final Value<int> id;
  final Value<String?> serverId;
  final Value<int> noteId;
  final Value<Uint8List> fileCipher;
  final Value<Uint8List> nonce;
  final Value<String?> mimeType;
  final Value<int> fileSize;
  final Value<DateTime> createdAt;
  const VaultEntriesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.fileCipher = const Value.absent(),
    this.nonce = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VaultEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    required int noteId,
    required Uint8List fileCipher,
    required Uint8List nonce,
    this.mimeType = const Value.absent(),
    required int fileSize,
    this.createdAt = const Value.absent(),
  }) : noteId = Value(noteId),
       fileCipher = Value(fileCipher),
       nonce = Value(nonce),
       fileSize = Value(fileSize);
  static Insertable<VaultEntry> custom({
    Expression<int>? id,
    Expression<String>? serverId,
    Expression<int>? noteId,
    Expression<Uint8List>? fileCipher,
    Expression<Uint8List>? nonce,
    Expression<String>? mimeType,
    Expression<int>? fileSize,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (noteId != null) 'note_id': noteId,
      if (fileCipher != null) 'file_cipher': fileCipher,
      if (nonce != null) 'nonce': nonce,
      if (mimeType != null) 'mime_type': mimeType,
      if (fileSize != null) 'file_size': fileSize,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VaultEntriesCompanion copyWith({
    Value<int>? id,
    Value<String?>? serverId,
    Value<int>? noteId,
    Value<Uint8List>? fileCipher,
    Value<Uint8List>? nonce,
    Value<String?>? mimeType,
    Value<int>? fileSize,
    Value<DateTime>? createdAt,
  }) {
    return VaultEntriesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      noteId: noteId ?? this.noteId,
      fileCipher: fileCipher ?? this.fileCipher,
      nonce: nonce ?? this.nonce,
      mimeType: mimeType ?? this.mimeType,
      fileSize: fileSize ?? this.fileSize,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
    }
    if (fileCipher.present) {
      map['file_cipher'] = Variable<Uint8List>(fileCipher.value);
    }
    if (nonce.present) {
      map['nonce'] = Variable<Uint8List>(nonce.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultEntriesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('noteId: $noteId, ')
          ..write('fileCipher: $fileCipher, ')
          ..write('nonce: $nonce, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileSize: $fileSize, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $VaultMetadataTable extends VaultMetadata
    with TableInfo<$VaultMetadataTable, VaultMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<Uint8List> salt = GeneratedColumn<Uint8List>(
    'salt',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _derivationStrategyMeta =
      const VerificationMeta('derivationStrategy');
  @override
  late final GeneratedColumn<String> derivationStrategy =
      GeneratedColumn<String>(
        'derivation_strategy',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lockDurationSecondsMeta =
      const VerificationMeta('lockDurationSeconds');
  @override
  late final GeneratedColumn<int> lockDurationSeconds = GeneratedColumn<int>(
    'lock_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(600),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    salt,
    derivationStrategy,
    lockDurationSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vault_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<VaultMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('salt')) {
      context.handle(
        _saltMeta,
        salt.isAcceptableOrUnknown(data['salt']!, _saltMeta),
      );
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    if (data.containsKey('derivation_strategy')) {
      context.handle(
        _derivationStrategyMeta,
        derivationStrategy.isAcceptableOrUnknown(
          data['derivation_strategy']!,
          _derivationStrategyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_derivationStrategyMeta);
    }
    if (data.containsKey('lock_duration_seconds')) {
      context.handle(
        _lockDurationSecondsMeta,
        lockDurationSeconds.isAcceptableOrUnknown(
          data['lock_duration_seconds']!,
          _lockDurationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaultMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultMetadataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      salt: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}salt'],
      )!,
      derivationStrategy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}derivation_strategy'],
      )!,
      lockDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lock_duration_seconds'],
      )!,
    );
  }

  @override
  $VaultMetadataTable createAlias(String alias) {
    return $VaultMetadataTable(attachedDatabase, alias);
  }
}

class VaultMetadataData extends DataClass
    implements Insertable<VaultMetadataData> {
  final int id;
  final Uint8List salt;
  final String derivationStrategy;
  final int lockDurationSeconds;
  const VaultMetadataData({
    required this.id,
    required this.salt,
    required this.derivationStrategy,
    required this.lockDurationSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['salt'] = Variable<Uint8List>(salt);
    map['derivation_strategy'] = Variable<String>(derivationStrategy);
    map['lock_duration_seconds'] = Variable<int>(lockDurationSeconds);
    return map;
  }

  VaultMetadataCompanion toCompanion(bool nullToAbsent) {
    return VaultMetadataCompanion(
      id: Value(id),
      salt: Value(salt),
      derivationStrategy: Value(derivationStrategy),
      lockDurationSeconds: Value(lockDurationSeconds),
    );
  }

  factory VaultMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultMetadataData(
      id: serializer.fromJson<int>(json['id']),
      salt: serializer.fromJson<Uint8List>(json['salt']),
      derivationStrategy: serializer.fromJson<String>(
        json['derivationStrategy'],
      ),
      lockDurationSeconds: serializer.fromJson<int>(
        json['lockDurationSeconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'salt': serializer.toJson<Uint8List>(salt),
      'derivationStrategy': serializer.toJson<String>(derivationStrategy),
      'lockDurationSeconds': serializer.toJson<int>(lockDurationSeconds),
    };
  }

  VaultMetadataData copyWith({
    int? id,
    Uint8List? salt,
    String? derivationStrategy,
    int? lockDurationSeconds,
  }) => VaultMetadataData(
    id: id ?? this.id,
    salt: salt ?? this.salt,
    derivationStrategy: derivationStrategy ?? this.derivationStrategy,
    lockDurationSeconds: lockDurationSeconds ?? this.lockDurationSeconds,
  );
  VaultMetadataData copyWithCompanion(VaultMetadataCompanion data) {
    return VaultMetadataData(
      id: data.id.present ? data.id.value : this.id,
      salt: data.salt.present ? data.salt.value : this.salt,
      derivationStrategy: data.derivationStrategy.present
          ? data.derivationStrategy.value
          : this.derivationStrategy,
      lockDurationSeconds: data.lockDurationSeconds.present
          ? data.lockDurationSeconds.value
          : this.lockDurationSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultMetadataData(')
          ..write('id: $id, ')
          ..write('salt: $salt, ')
          ..write('derivationStrategy: $derivationStrategy, ')
          ..write('lockDurationSeconds: $lockDurationSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    $driftBlobEquality.hash(salt),
    derivationStrategy,
    lockDurationSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultMetadataData &&
          other.id == this.id &&
          $driftBlobEquality.equals(other.salt, this.salt) &&
          other.derivationStrategy == this.derivationStrategy &&
          other.lockDurationSeconds == this.lockDurationSeconds);
}

class VaultMetadataCompanion extends UpdateCompanion<VaultMetadataData> {
  final Value<int> id;
  final Value<Uint8List> salt;
  final Value<String> derivationStrategy;
  final Value<int> lockDurationSeconds;
  const VaultMetadataCompanion({
    this.id = const Value.absent(),
    this.salt = const Value.absent(),
    this.derivationStrategy = const Value.absent(),
    this.lockDurationSeconds = const Value.absent(),
  });
  VaultMetadataCompanion.insert({
    this.id = const Value.absent(),
    required Uint8List salt,
    required String derivationStrategy,
    this.lockDurationSeconds = const Value.absent(),
  }) : salt = Value(salt),
       derivationStrategy = Value(derivationStrategy);
  static Insertable<VaultMetadataData> custom({
    Expression<int>? id,
    Expression<Uint8List>? salt,
    Expression<String>? derivationStrategy,
    Expression<int>? lockDurationSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (salt != null) 'salt': salt,
      if (derivationStrategy != null) 'derivation_strategy': derivationStrategy,
      if (lockDurationSeconds != null)
        'lock_duration_seconds': lockDurationSeconds,
    });
  }

  VaultMetadataCompanion copyWith({
    Value<int>? id,
    Value<Uint8List>? salt,
    Value<String>? derivationStrategy,
    Value<int>? lockDurationSeconds,
  }) {
    return VaultMetadataCompanion(
      id: id ?? this.id,
      salt: salt ?? this.salt,
      derivationStrategy: derivationStrategy ?? this.derivationStrategy,
      lockDurationSeconds: lockDurationSeconds ?? this.lockDurationSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (salt.present) {
      map['salt'] = Variable<Uint8List>(salt.value);
    }
    if (derivationStrategy.present) {
      map['derivation_strategy'] = Variable<String>(derivationStrategy.value);
    }
    if (lockDurationSeconds.present) {
      map['lock_duration_seconds'] = Variable<int>(lockDurationSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultMetadataCompanion(')
          ..write('id: $id, ')
          ..write('salt: $salt, ')
          ..write('derivationStrategy: $derivationStrategy, ')
          ..write('lockDurationSeconds: $lockDurationSeconds')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NoteEntriesTable noteEntries = $NoteEntriesTable(this);
  late final $VaultEntriesTable vaultEntries = $VaultEntriesTable(this);
  late final $VaultMetadataTable vaultMetadata = $VaultMetadataTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    noteEntries,
    vaultEntries,
    vaultMetadata,
  ];
}

typedef $$NoteEntriesTableCreateCompanionBuilder =
    NoteEntriesCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      required Uint8List titleCipher,
      required Uint8List contentCipher,
      required Uint8List nonce,
      Value<int> version,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
    });
typedef $$NoteEntriesTableUpdateCompanionBuilder =
    NoteEntriesCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<Uint8List> titleCipher,
      Value<Uint8List> contentCipher,
      Value<Uint8List> nonce,
      Value<int> version,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
    });

final class $$NoteEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $NoteEntriesTable, NoteEntry> {
  $$NoteEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VaultEntriesTable, List<VaultEntry>>
  _vaultEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vaultEntries,
    aliasName: $_aliasNameGenerator(db.noteEntries.id, db.vaultEntries.noteId),
  );

  $$VaultEntriesTableProcessedTableManager get vaultEntriesRefs {
    final manager = $$VaultEntriesTableTableManager(
      $_db,
      $_db.vaultEntries,
    ).filter((f) => f.noteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vaultEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NoteEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $NoteEntriesTable> {
  $$NoteEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get titleCipher => $composableBuilder(
    column: $table.titleCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get contentCipher => $composableBuilder(
    column: $table.contentCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get nonce => $composableBuilder(
    column: $table.nonce,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vaultEntriesRefs(
    Expression<bool> Function($$VaultEntriesTableFilterComposer f) f,
  ) {
    final $$VaultEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vaultEntries,
      getReferencedColumn: (t) => t.noteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultEntriesTableFilterComposer(
            $db: $db,
            $table: $db.vaultEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NoteEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $NoteEntriesTable> {
  $$NoteEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get titleCipher => $composableBuilder(
    column: $table.titleCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get contentCipher => $composableBuilder(
    column: $table.contentCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get nonce => $composableBuilder(
    column: $table.nonce,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NoteEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NoteEntriesTable> {
  $$NoteEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<Uint8List> get titleCipher => $composableBuilder(
    column: $table.titleCipher,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get contentCipher => $composableBuilder(
    column: $table.contentCipher,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get nonce =>
      $composableBuilder(column: $table.nonce, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  Expression<T> vaultEntriesRefs<T extends Object>(
    Expression<T> Function($$VaultEntriesTableAnnotationComposer a) f,
  ) {
    final $$VaultEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vaultEntries,
      getReferencedColumn: (t) => t.noteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VaultEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.vaultEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NoteEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NoteEntriesTable,
          NoteEntry,
          $$NoteEntriesTableFilterComposer,
          $$NoteEntriesTableOrderingComposer,
          $$NoteEntriesTableAnnotationComposer,
          $$NoteEntriesTableCreateCompanionBuilder,
          $$NoteEntriesTableUpdateCompanionBuilder,
          (NoteEntry, $$NoteEntriesTableReferences),
          NoteEntry,
          PrefetchHooks Function({bool vaultEntriesRefs})
        > {
  $$NoteEntriesTableTableManager(_$AppDatabase db, $NoteEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NoteEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NoteEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NoteEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<Uint8List> titleCipher = const Value.absent(),
                Value<Uint8List> contentCipher = const Value.absent(),
                Value<Uint8List> nonce = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => NoteEntriesCompanion(
                id: id,
                serverId: serverId,
                titleCipher: titleCipher,
                contentCipher: contentCipher,
                nonce: nonce,
                version: version,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                required Uint8List titleCipher,
                required Uint8List contentCipher,
                required Uint8List nonce,
                Value<int> version = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
              }) => NoteEntriesCompanion.insert(
                id: id,
                serverId: serverId,
                titleCipher: titleCipher,
                contentCipher: contentCipher,
                nonce: nonce,
                version: version,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NoteEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vaultEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (vaultEntriesRefs) db.vaultEntries],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (vaultEntriesRefs)
                    await $_getPrefetchedData<
                      NoteEntry,
                      $NoteEntriesTable,
                      VaultEntry
                    >(
                      currentTable: table,
                      referencedTable: $$NoteEntriesTableReferences
                          ._vaultEntriesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$NoteEntriesTableReferences(
                            db,
                            table,
                            p0,
                          ).vaultEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.noteId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$NoteEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NoteEntriesTable,
      NoteEntry,
      $$NoteEntriesTableFilterComposer,
      $$NoteEntriesTableOrderingComposer,
      $$NoteEntriesTableAnnotationComposer,
      $$NoteEntriesTableCreateCompanionBuilder,
      $$NoteEntriesTableUpdateCompanionBuilder,
      (NoteEntry, $$NoteEntriesTableReferences),
      NoteEntry,
      PrefetchHooks Function({bool vaultEntriesRefs})
    >;
typedef $$VaultEntriesTableCreateCompanionBuilder =
    VaultEntriesCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      required int noteId,
      required Uint8List fileCipher,
      required Uint8List nonce,
      Value<String?> mimeType,
      required int fileSize,
      Value<DateTime> createdAt,
    });
typedef $$VaultEntriesTableUpdateCompanionBuilder =
    VaultEntriesCompanion Function({
      Value<int> id,
      Value<String?> serverId,
      Value<int> noteId,
      Value<Uint8List> fileCipher,
      Value<Uint8List> nonce,
      Value<String?> mimeType,
      Value<int> fileSize,
      Value<DateTime> createdAt,
    });

final class $$VaultEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $VaultEntriesTable, VaultEntry> {
  $$VaultEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NoteEntriesTable _noteIdTable(_$AppDatabase db) =>
      db.noteEntries.createAlias(
        $_aliasNameGenerator(db.vaultEntries.noteId, db.noteEntries.id),
      );

  $$NoteEntriesTableProcessedTableManager get noteId {
    final $_column = $_itemColumn<int>('note_id')!;

    final manager = $$NoteEntriesTableTableManager(
      $_db,
      $_db.noteEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_noteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VaultEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get fileCipher => $composableBuilder(
    column: $table.fileCipher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get nonce => $composableBuilder(
    column: $table.nonce,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$NoteEntriesTableFilterComposer get noteId {
    final $$NoteEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.noteEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NoteEntriesTableFilterComposer(
            $db: $db,
            $table: $db.noteEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get fileCipher => $composableBuilder(
    column: $table.fileCipher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get nonce => $composableBuilder(
    column: $table.nonce,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$NoteEntriesTableOrderingComposer get noteId {
    final $$NoteEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.noteEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NoteEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.noteEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<Uint8List> get fileCipher => $composableBuilder(
    column: $table.fileCipher,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get nonce =>
      $composableBuilder(column: $table.nonce, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$NoteEntriesTableAnnotationComposer get noteId {
    final $$NoteEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.noteId,
      referencedTable: $db.noteEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NoteEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.noteEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VaultEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VaultEntriesTable,
          VaultEntry,
          $$VaultEntriesTableFilterComposer,
          $$VaultEntriesTableOrderingComposer,
          $$VaultEntriesTableAnnotationComposer,
          $$VaultEntriesTableCreateCompanionBuilder,
          $$VaultEntriesTableUpdateCompanionBuilder,
          (VaultEntry, $$VaultEntriesTableReferences),
          VaultEntry,
          PrefetchHooks Function({bool noteId})
        > {
  $$VaultEntriesTableTableManager(_$AppDatabase db, $VaultEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<int> noteId = const Value.absent(),
                Value<Uint8List> fileCipher = const Value.absent(),
                Value<Uint8List> nonce = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VaultEntriesCompanion(
                id: id,
                serverId: serverId,
                noteId: noteId,
                fileCipher: fileCipher,
                nonce: nonce,
                mimeType: mimeType,
                fileSize: fileSize,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                required int noteId,
                required Uint8List fileCipher,
                required Uint8List nonce,
                Value<String?> mimeType = const Value.absent(),
                required int fileSize,
                Value<DateTime> createdAt = const Value.absent(),
              }) => VaultEntriesCompanion.insert(
                id: id,
                serverId: serverId,
                noteId: noteId,
                fileCipher: fileCipher,
                nonce: nonce,
                mimeType: mimeType,
                fileSize: fileSize,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VaultEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({noteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (noteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.noteId,
                                referencedTable: $$VaultEntriesTableReferences
                                    ._noteIdTable(db),
                                referencedColumn: $$VaultEntriesTableReferences
                                    ._noteIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VaultEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VaultEntriesTable,
      VaultEntry,
      $$VaultEntriesTableFilterComposer,
      $$VaultEntriesTableOrderingComposer,
      $$VaultEntriesTableAnnotationComposer,
      $$VaultEntriesTableCreateCompanionBuilder,
      $$VaultEntriesTableUpdateCompanionBuilder,
      (VaultEntry, $$VaultEntriesTableReferences),
      VaultEntry,
      PrefetchHooks Function({bool noteId})
    >;
typedef $$VaultMetadataTableCreateCompanionBuilder =
    VaultMetadataCompanion Function({
      Value<int> id,
      required Uint8List salt,
      required String derivationStrategy,
      Value<int> lockDurationSeconds,
    });
typedef $$VaultMetadataTableUpdateCompanionBuilder =
    VaultMetadataCompanion Function({
      Value<int> id,
      Value<Uint8List> salt,
      Value<String> derivationStrategy,
      Value<int> lockDurationSeconds,
    });

class $$VaultMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $VaultMetadataTable> {
  $$VaultMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get salt => $composableBuilder(
    column: $table.salt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get derivationStrategy => $composableBuilder(
    column: $table.derivationStrategy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lockDurationSeconds => $composableBuilder(
    column: $table.lockDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VaultMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $VaultMetadataTable> {
  $$VaultMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get salt => $composableBuilder(
    column: $table.salt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get derivationStrategy => $composableBuilder(
    column: $table.derivationStrategy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lockDurationSeconds => $composableBuilder(
    column: $table.lockDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VaultMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $VaultMetadataTable> {
  $$VaultMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<Uint8List> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => column);

  GeneratedColumn<String> get derivationStrategy => $composableBuilder(
    column: $table.derivationStrategy,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lockDurationSeconds => $composableBuilder(
    column: $table.lockDurationSeconds,
    builder: (column) => column,
  );
}

class $$VaultMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VaultMetadataTable,
          VaultMetadataData,
          $$VaultMetadataTableFilterComposer,
          $$VaultMetadataTableOrderingComposer,
          $$VaultMetadataTableAnnotationComposer,
          $$VaultMetadataTableCreateCompanionBuilder,
          $$VaultMetadataTableUpdateCompanionBuilder,
          (
            VaultMetadataData,
            BaseReferences<
              _$AppDatabase,
              $VaultMetadataTable,
              VaultMetadataData
            >,
          ),
          VaultMetadataData,
          PrefetchHooks Function()
        > {
  $$VaultMetadataTableTableManager(_$AppDatabase db, $VaultMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Uint8List> salt = const Value.absent(),
                Value<String> derivationStrategy = const Value.absent(),
                Value<int> lockDurationSeconds = const Value.absent(),
              }) => VaultMetadataCompanion(
                id: id,
                salt: salt,
                derivationStrategy: derivationStrategy,
                lockDurationSeconds: lockDurationSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Uint8List salt,
                required String derivationStrategy,
                Value<int> lockDurationSeconds = const Value.absent(),
              }) => VaultMetadataCompanion.insert(
                id: id,
                salt: salt,
                derivationStrategy: derivationStrategy,
                lockDurationSeconds: lockDurationSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VaultMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VaultMetadataTable,
      VaultMetadataData,
      $$VaultMetadataTableFilterComposer,
      $$VaultMetadataTableOrderingComposer,
      $$VaultMetadataTableAnnotationComposer,
      $$VaultMetadataTableCreateCompanionBuilder,
      $$VaultMetadataTableUpdateCompanionBuilder,
      (
        VaultMetadataData,
        BaseReferences<_$AppDatabase, $VaultMetadataTable, VaultMetadataData>,
      ),
      VaultMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NoteEntriesTableTableManager get noteEntries =>
      $$NoteEntriesTableTableManager(_db, _db.noteEntries);
  $$VaultEntriesTableTableManager get vaultEntries =>
      $$VaultEntriesTableTableManager(_db, _db.vaultEntries);
  $$VaultMetadataTableTableManager get vaultMetadata =>
      $$VaultMetadataTableTableManager(_db, _db.vaultMetadata);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'18ce5c8c4d8ddbfe5a7d819d8fb7d5aca76bf416';
