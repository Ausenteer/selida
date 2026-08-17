// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, StoredBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncKeyMeta = const VerificationMeta(
    'syncKey',
  );
  @override
  late final GeneratedColumn<String> syncKey = GeneratedColumn<String>(
    'sync_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverPathMeta = const VerificationMeta(
    'coverPath',
  );
  @override
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
    'cover_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLengthMeta = const VerificationMeta(
    'totalLength',
  );
  @override
  late final GeneratedColumn<int> totalLength = GeneratedColumn<int>(
    'total_length',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastOpenedAtMeta = const VerificationMeta(
    'lastOpenedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
    'last_opened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncKey,
    format,
    title,
    author,
    language,
    filePath,
    coverPath,
    contentHash,
    totalLength,
    lastOpenedAt,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sync_key')) {
      context.handle(
        _syncKeyMeta,
        syncKey.isAcceptableOrUnknown(data['sync_key']!, _syncKeyMeta),
      );
    }
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    } else if (isInserting) {
      context.missing(_formatMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    }
    if (data.containsKey('cover_path')) {
      context.handle(
        _coverPathMeta,
        coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta),
      );
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentHashMeta);
    }
    if (data.containsKey('total_length')) {
      context.handle(
        _totalLengthMeta,
        totalLength.isAcceptableOrUnknown(
          data['total_length']!,
          _totalLengthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLengthMeta);
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
        _lastOpenedAtMeta,
        lastOpenedAt.isAcceptableOrUnknown(
          data['last_opened_at']!,
          _lastOpenedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastOpenedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredBook(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      syncKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_key'],
      ),
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      ),
      coverPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_path'],
      ),
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      )!,
      totalLength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_length'],
      )!,
      lastOpenedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_opened_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class StoredBook extends DataClass implements Insertable<StoredBook> {
  final String id;
  final String? syncKey;
  final String format;
  final String title;
  final String? author;
  final String language;
  final String? filePath;
  final String? coverPath;
  final String contentHash;
  final int totalLength;
  final DateTime lastOpenedAt;
  final DateTime createdAt;
  final DateTime? deletedAt;
  const StoredBook({
    required this.id,
    this.syncKey,
    required this.format,
    required this.title,
    this.author,
    required this.language,
    this.filePath,
    this.coverPath,
    required this.contentHash,
    required this.totalLength,
    required this.lastOpenedAt,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || syncKey != null) {
      map['sync_key'] = Variable<String>(syncKey);
    }
    map['format'] = Variable<String>(format);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    map['language'] = Variable<String>(language);
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    if (!nullToAbsent || coverPath != null) {
      map['cover_path'] = Variable<String>(coverPath);
    }
    map['content_hash'] = Variable<String>(contentHash);
    map['total_length'] = Variable<int>(totalLength);
    map['last_opened_at'] = Variable<DateTime>(lastOpenedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      syncKey: syncKey == null && nullToAbsent
          ? const Value.absent()
          : Value(syncKey),
      format: Value(format),
      title: Value(title),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      language: Value(language),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      coverPath: coverPath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPath),
      contentHash: Value(contentHash),
      totalLength: Value(totalLength),
      lastOpenedAt: Value(lastOpenedAt),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory StoredBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredBook(
      id: serializer.fromJson<String>(json['id']),
      syncKey: serializer.fromJson<String?>(json['syncKey']),
      format: serializer.fromJson<String>(json['format']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String?>(json['author']),
      language: serializer.fromJson<String>(json['language']),
      filePath: serializer.fromJson<String?>(json['filePath']),
      coverPath: serializer.fromJson<String?>(json['coverPath']),
      contentHash: serializer.fromJson<String>(json['contentHash']),
      totalLength: serializer.fromJson<int>(json['totalLength']),
      lastOpenedAt: serializer.fromJson<DateTime>(json['lastOpenedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'syncKey': serializer.toJson<String?>(syncKey),
      'format': serializer.toJson<String>(format),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String?>(author),
      'language': serializer.toJson<String>(language),
      'filePath': serializer.toJson<String?>(filePath),
      'coverPath': serializer.toJson<String?>(coverPath),
      'contentHash': serializer.toJson<String>(contentHash),
      'totalLength': serializer.toJson<int>(totalLength),
      'lastOpenedAt': serializer.toJson<DateTime>(lastOpenedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  StoredBook copyWith({
    String? id,
    Value<String?> syncKey = const Value.absent(),
    String? format,
    String? title,
    Value<String?> author = const Value.absent(),
    String? language,
    Value<String?> filePath = const Value.absent(),
    Value<String?> coverPath = const Value.absent(),
    String? contentHash,
    int? totalLength,
    DateTime? lastOpenedAt,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => StoredBook(
    id: id ?? this.id,
    syncKey: syncKey.present ? syncKey.value : this.syncKey,
    format: format ?? this.format,
    title: title ?? this.title,
    author: author.present ? author.value : this.author,
    language: language ?? this.language,
    filePath: filePath.present ? filePath.value : this.filePath,
    coverPath: coverPath.present ? coverPath.value : this.coverPath,
    contentHash: contentHash ?? this.contentHash,
    totalLength: totalLength ?? this.totalLength,
    lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  StoredBook copyWithCompanion(BooksCompanion data) {
    return StoredBook(
      id: data.id.present ? data.id.value : this.id,
      syncKey: data.syncKey.present ? data.syncKey.value : this.syncKey,
      format: data.format.present ? data.format.value : this.format,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      language: data.language.present ? data.language.value : this.language,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      coverPath: data.coverPath.present ? data.coverPath.value : this.coverPath,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      totalLength: data.totalLength.present
          ? data.totalLength.value
          : this.totalLength,
      lastOpenedAt: data.lastOpenedAt.present
          ? data.lastOpenedAt.value
          : this.lastOpenedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredBook(')
          ..write('id: $id, ')
          ..write('syncKey: $syncKey, ')
          ..write('format: $format, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('language: $language, ')
          ..write('filePath: $filePath, ')
          ..write('coverPath: $coverPath, ')
          ..write('contentHash: $contentHash, ')
          ..write('totalLength: $totalLength, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncKey,
    format,
    title,
    author,
    language,
    filePath,
    coverPath,
    contentHash,
    totalLength,
    lastOpenedAt,
    createdAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredBook &&
          other.id == this.id &&
          other.syncKey == this.syncKey &&
          other.format == this.format &&
          other.title == this.title &&
          other.author == this.author &&
          other.language == this.language &&
          other.filePath == this.filePath &&
          other.coverPath == this.coverPath &&
          other.contentHash == this.contentHash &&
          other.totalLength == this.totalLength &&
          other.lastOpenedAt == this.lastOpenedAt &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class BooksCompanion extends UpdateCompanion<StoredBook> {
  final Value<String> id;
  final Value<String?> syncKey;
  final Value<String> format;
  final Value<String> title;
  final Value<String?> author;
  final Value<String> language;
  final Value<String?> filePath;
  final Value<String?> coverPath;
  final Value<String> contentHash;
  final Value<int> totalLength;
  final Value<DateTime> lastOpenedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.syncKey = const Value.absent(),
    this.format = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.language = const Value.absent(),
    this.filePath = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.totalLength = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BooksCompanion.insert({
    required String id,
    this.syncKey = const Value.absent(),
    required String format,
    required String title,
    this.author = const Value.absent(),
    required String language,
    this.filePath = const Value.absent(),
    this.coverPath = const Value.absent(),
    required String contentHash,
    required int totalLength,
    required DateTime lastOpenedAt,
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       format = Value(format),
       title = Value(title),
       language = Value(language),
       contentHash = Value(contentHash),
       totalLength = Value(totalLength),
       lastOpenedAt = Value(lastOpenedAt);
  static Insertable<StoredBook> custom({
    Expression<String>? id,
    Expression<String>? syncKey,
    Expression<String>? format,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? language,
    Expression<String>? filePath,
    Expression<String>? coverPath,
    Expression<String>? contentHash,
    Expression<int>? totalLength,
    Expression<DateTime>? lastOpenedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncKey != null) 'sync_key': syncKey,
      if (format != null) 'format': format,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (language != null) 'language': language,
      if (filePath != null) 'file_path': filePath,
      if (coverPath != null) 'cover_path': coverPath,
      if (contentHash != null) 'content_hash': contentHash,
      if (totalLength != null) 'total_length': totalLength,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BooksCompanion copyWith({
    Value<String>? id,
    Value<String?>? syncKey,
    Value<String>? format,
    Value<String>? title,
    Value<String?>? author,
    Value<String>? language,
    Value<String?>? filePath,
    Value<String?>? coverPath,
    Value<String>? contentHash,
    Value<int>? totalLength,
    Value<DateTime>? lastOpenedAt,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      syncKey: syncKey ?? this.syncKey,
      format: format ?? this.format,
      title: title ?? this.title,
      author: author ?? this.author,
      language: language ?? this.language,
      filePath: filePath ?? this.filePath,
      coverPath: coverPath ?? this.coverPath,
      contentHash: contentHash ?? this.contentHash,
      totalLength: totalLength ?? this.totalLength,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (syncKey.present) {
      map['sync_key'] = Variable<String>(syncKey.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (coverPath.present) {
      map['cover_path'] = Variable<String>(coverPath.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (totalLength.present) {
      map['total_length'] = Variable<int>(totalLength.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('syncKey: $syncKey, ')
          ..write('format: $format, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('language: $language, ')
          ..write('filePath: $filePath, ')
          ..write('coverPath: $coverPath, ')
          ..write('contentHash: $contentHash, ')
          ..write('totalLength: $totalLength, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters
    with TableInfo<$ChaptersTable, StoredChapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrefMeta = const VerificationMeta('href');
  @override
  late final GeneratedColumn<String> href = GeneratedColumn<String>(
    'href',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plainTextMeta = const VerificationMeta(
    'plainText',
  );
  @override
  late final GeneratedColumn<String> plainText = GeneratedColumn<String>(
    'plain_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lengthUtf16Meta = const VerificationMeta(
    'lengthUtf16',
  );
  @override
  late final GeneratedColumn<int> lengthUtf16 = GeneratedColumn<int>(
    'length_utf16',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    ordinal,
    title,
    href,
    plainText,
    lengthUtf16,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chapters';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredChapter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('href')) {
      context.handle(
        _hrefMeta,
        href.isAcceptableOrUnknown(data['href']!, _hrefMeta),
      );
    }
    if (data.containsKey('plain_text')) {
      context.handle(
        _plainTextMeta,
        plainText.isAcceptableOrUnknown(data['plain_text']!, _plainTextMeta),
      );
    } else if (isInserting) {
      context.missing(_plainTextMeta);
    }
    if (data.containsKey('length_utf16')) {
      context.handle(
        _lengthUtf16Meta,
        lengthUtf16.isAcceptableOrUnknown(
          data['length_utf16']!,
          _lengthUtf16Meta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lengthUtf16Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredChapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredChapter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      href: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}href'],
      ),
      plainText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plain_text'],
      )!,
      lengthUtf16: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}length_utf16'],
      )!,
    );
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

class StoredChapter extends DataClass implements Insertable<StoredChapter> {
  final String id;
  final String bookId;
  final int ordinal;
  final String? title;
  final String? href;
  final String plainText;
  final int lengthUtf16;
  const StoredChapter({
    required this.id,
    required this.bookId,
    required this.ordinal,
    this.title,
    this.href,
    required this.plainText,
    required this.lengthUtf16,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    map['ordinal'] = Variable<int>(ordinal);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || href != null) {
      map['href'] = Variable<String>(href);
    }
    map['plain_text'] = Variable<String>(plainText);
    map['length_utf16'] = Variable<int>(lengthUtf16);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      bookId: Value(bookId),
      ordinal: Value(ordinal),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      href: href == null && nullToAbsent ? const Value.absent() : Value(href),
      plainText: Value(plainText),
      lengthUtf16: Value(lengthUtf16),
    );
  }

  factory StoredChapter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredChapter(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      title: serializer.fromJson<String?>(json['title']),
      href: serializer.fromJson<String?>(json['href']),
      plainText: serializer.fromJson<String>(json['plainText']),
      lengthUtf16: serializer.fromJson<int>(json['lengthUtf16']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'ordinal': serializer.toJson<int>(ordinal),
      'title': serializer.toJson<String?>(title),
      'href': serializer.toJson<String?>(href),
      'plainText': serializer.toJson<String>(plainText),
      'lengthUtf16': serializer.toJson<int>(lengthUtf16),
    };
  }

  StoredChapter copyWith({
    String? id,
    String? bookId,
    int? ordinal,
    Value<String?> title = const Value.absent(),
    Value<String?> href = const Value.absent(),
    String? plainText,
    int? lengthUtf16,
  }) => StoredChapter(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    ordinal: ordinal ?? this.ordinal,
    title: title.present ? title.value : this.title,
    href: href.present ? href.value : this.href,
    plainText: plainText ?? this.plainText,
    lengthUtf16: lengthUtf16 ?? this.lengthUtf16,
  );
  StoredChapter copyWithCompanion(ChaptersCompanion data) {
    return StoredChapter(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      title: data.title.present ? data.title.value : this.title,
      href: data.href.present ? data.href.value : this.href,
      plainText: data.plainText.present ? data.plainText.value : this.plainText,
      lengthUtf16: data.lengthUtf16.present
          ? data.lengthUtf16.value
          : this.lengthUtf16,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredChapter(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('ordinal: $ordinal, ')
          ..write('title: $title, ')
          ..write('href: $href, ')
          ..write('plainText: $plainText, ')
          ..write('lengthUtf16: $lengthUtf16')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, bookId, ordinal, title, href, plainText, lengthUtf16);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredChapter &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.ordinal == this.ordinal &&
          other.title == this.title &&
          other.href == this.href &&
          other.plainText == this.plainText &&
          other.lengthUtf16 == this.lengthUtf16);
}

class ChaptersCompanion extends UpdateCompanion<StoredChapter> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<int> ordinal;
  final Value<String?> title;
  final Value<String?> href;
  final Value<String> plainText;
  final Value<int> lengthUtf16;
  final Value<int> rowid;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.title = const Value.absent(),
    this.href = const Value.absent(),
    this.plainText = const Value.absent(),
    this.lengthUtf16 = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChaptersCompanion.insert({
    required String id,
    required String bookId,
    required int ordinal,
    this.title = const Value.absent(),
    this.href = const Value.absent(),
    required String plainText,
    required int lengthUtf16,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bookId = Value(bookId),
       ordinal = Value(ordinal),
       plainText = Value(plainText),
       lengthUtf16 = Value(lengthUtf16);
  static Insertable<StoredChapter> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<int>? ordinal,
    Expression<String>? title,
    Expression<String>? href,
    Expression<String>? plainText,
    Expression<int>? lengthUtf16,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (ordinal != null) 'ordinal': ordinal,
      if (title != null) 'title': title,
      if (href != null) 'href': href,
      if (plainText != null) 'plain_text': plainText,
      if (lengthUtf16 != null) 'length_utf16': lengthUtf16,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChaptersCompanion copyWith({
    Value<String>? id,
    Value<String>? bookId,
    Value<int>? ordinal,
    Value<String?>? title,
    Value<String?>? href,
    Value<String>? plainText,
    Value<int>? lengthUtf16,
    Value<int>? rowid,
  }) {
    return ChaptersCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      ordinal: ordinal ?? this.ordinal,
      title: title ?? this.title,
      href: href ?? this.href,
      plainText: plainText ?? this.plainText,
      lengthUtf16: lengthUtf16 ?? this.lengthUtf16,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (href.present) {
      map['href'] = Variable<String>(href.value);
    }
    if (plainText.present) {
      map['plain_text'] = Variable<String>(plainText.value);
    }
    if (lengthUtf16.present) {
      map['length_utf16'] = Variable<int>(lengthUtf16.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('ordinal: $ordinal, ')
          ..write('title: $title, ')
          ..write('href: $href, ')
          ..write('plainText: $plainText, ')
          ..write('lengthUtf16: $lengthUtf16, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContentBlocksTable extends ContentBlocks
    with TableInfo<$ContentBlocksTable, StoredContentBlock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentBlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startOffsetMeta = const VerificationMeta(
    'startOffset',
  );
  @override
  late final GeneratedColumn<int> startOffset = GeneratedColumn<int>(
    'start_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endOffsetMeta = const VerificationMeta(
    'endOffset',
  );
  @override
  late final GeneratedColumn<int> endOffset = GeneratedColumn<int>(
    'end_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inlineSpansJsonMeta = const VerificationMeta(
    'inlineSpansJson',
  );
  @override
  late final GeneratedColumn<String> inlineSpansJson = GeneratedColumn<String>(
    'inline_spans_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _resourcePathMeta = const VerificationMeta(
    'resourcePath',
  );
  @override
  late final GeneratedColumn<String> resourcePath = GeneratedColumn<String>(
    'resource_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altTextMeta = const VerificationMeta(
    'altText',
  );
  @override
  late final GeneratedColumn<String> altText = GeneratedColumn<String>(
    'alt_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    chapterId,
    ordinal,
    kind,
    textContent,
    startOffset,
    endOffset,
    inlineSpansJson,
    resourcePath,
    altText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_blocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredContentBlock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('start_offset')) {
      context.handle(
        _startOffsetMeta,
        startOffset.isAcceptableOrUnknown(
          data['start_offset']!,
          _startOffsetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startOffsetMeta);
    }
    if (data.containsKey('end_offset')) {
      context.handle(
        _endOffsetMeta,
        endOffset.isAcceptableOrUnknown(data['end_offset']!, _endOffsetMeta),
      );
    } else if (isInserting) {
      context.missing(_endOffsetMeta);
    }
    if (data.containsKey('inline_spans_json')) {
      context.handle(
        _inlineSpansJsonMeta,
        inlineSpansJson.isAcceptableOrUnknown(
          data['inline_spans_json']!,
          _inlineSpansJsonMeta,
        ),
      );
    }
    if (data.containsKey('resource_path')) {
      context.handle(
        _resourcePathMeta,
        resourcePath.isAcceptableOrUnknown(
          data['resource_path']!,
          _resourcePathMeta,
        ),
      );
    }
    if (data.containsKey('alt_text')) {
      context.handle(
        _altTextMeta,
        altText.isAcceptableOrUnknown(data['alt_text']!, _altTextMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredContentBlock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredContentBlock(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
      startOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_offset'],
      )!,
      endOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_offset'],
      )!,
      inlineSpansJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inline_spans_json'],
      )!,
      resourcePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource_path'],
      ),
      altText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alt_text'],
      ),
    );
  }

  @override
  $ContentBlocksTable createAlias(String alias) {
    return $ContentBlocksTable(attachedDatabase, alias);
  }
}

class StoredContentBlock extends DataClass
    implements Insertable<StoredContentBlock> {
  final String id;
  final String chapterId;
  final int ordinal;
  final String kind;
  final String textContent;
  final int startOffset;
  final int endOffset;
  final String inlineSpansJson;
  final String? resourcePath;
  final String? altText;
  const StoredContentBlock({
    required this.id,
    required this.chapterId,
    required this.ordinal,
    required this.kind,
    required this.textContent,
    required this.startOffset,
    required this.endOffset,
    required this.inlineSpansJson,
    this.resourcePath,
    this.altText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['chapter_id'] = Variable<String>(chapterId);
    map['ordinal'] = Variable<int>(ordinal);
    map['kind'] = Variable<String>(kind);
    map['text_content'] = Variable<String>(textContent);
    map['start_offset'] = Variable<int>(startOffset);
    map['end_offset'] = Variable<int>(endOffset);
    map['inline_spans_json'] = Variable<String>(inlineSpansJson);
    if (!nullToAbsent || resourcePath != null) {
      map['resource_path'] = Variable<String>(resourcePath);
    }
    if (!nullToAbsent || altText != null) {
      map['alt_text'] = Variable<String>(altText);
    }
    return map;
  }

  ContentBlocksCompanion toCompanion(bool nullToAbsent) {
    return ContentBlocksCompanion(
      id: Value(id),
      chapterId: Value(chapterId),
      ordinal: Value(ordinal),
      kind: Value(kind),
      textContent: Value(textContent),
      startOffset: Value(startOffset),
      endOffset: Value(endOffset),
      inlineSpansJson: Value(inlineSpansJson),
      resourcePath: resourcePath == null && nullToAbsent
          ? const Value.absent()
          : Value(resourcePath),
      altText: altText == null && nullToAbsent
          ? const Value.absent()
          : Value(altText),
    );
  }

  factory StoredContentBlock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredContentBlock(
      id: serializer.fromJson<String>(json['id']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      kind: serializer.fromJson<String>(json['kind']),
      textContent: serializer.fromJson<String>(json['textContent']),
      startOffset: serializer.fromJson<int>(json['startOffset']),
      endOffset: serializer.fromJson<int>(json['endOffset']),
      inlineSpansJson: serializer.fromJson<String>(json['inlineSpansJson']),
      resourcePath: serializer.fromJson<String?>(json['resourcePath']),
      altText: serializer.fromJson<String?>(json['altText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'chapterId': serializer.toJson<String>(chapterId),
      'ordinal': serializer.toJson<int>(ordinal),
      'kind': serializer.toJson<String>(kind),
      'textContent': serializer.toJson<String>(textContent),
      'startOffset': serializer.toJson<int>(startOffset),
      'endOffset': serializer.toJson<int>(endOffset),
      'inlineSpansJson': serializer.toJson<String>(inlineSpansJson),
      'resourcePath': serializer.toJson<String?>(resourcePath),
      'altText': serializer.toJson<String?>(altText),
    };
  }

  StoredContentBlock copyWith({
    String? id,
    String? chapterId,
    int? ordinal,
    String? kind,
    String? textContent,
    int? startOffset,
    int? endOffset,
    String? inlineSpansJson,
    Value<String?> resourcePath = const Value.absent(),
    Value<String?> altText = const Value.absent(),
  }) => StoredContentBlock(
    id: id ?? this.id,
    chapterId: chapterId ?? this.chapterId,
    ordinal: ordinal ?? this.ordinal,
    kind: kind ?? this.kind,
    textContent: textContent ?? this.textContent,
    startOffset: startOffset ?? this.startOffset,
    endOffset: endOffset ?? this.endOffset,
    inlineSpansJson: inlineSpansJson ?? this.inlineSpansJson,
    resourcePath: resourcePath.present ? resourcePath.value : this.resourcePath,
    altText: altText.present ? altText.value : this.altText,
  );
  StoredContentBlock copyWithCompanion(ContentBlocksCompanion data) {
    return StoredContentBlock(
      id: data.id.present ? data.id.value : this.id,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      kind: data.kind.present ? data.kind.value : this.kind,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      startOffset: data.startOffset.present
          ? data.startOffset.value
          : this.startOffset,
      endOffset: data.endOffset.present ? data.endOffset.value : this.endOffset,
      inlineSpansJson: data.inlineSpansJson.present
          ? data.inlineSpansJson.value
          : this.inlineSpansJson,
      resourcePath: data.resourcePath.present
          ? data.resourcePath.value
          : this.resourcePath,
      altText: data.altText.present ? data.altText.value : this.altText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredContentBlock(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('ordinal: $ordinal, ')
          ..write('kind: $kind, ')
          ..write('textContent: $textContent, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('inlineSpansJson: $inlineSpansJson, ')
          ..write('resourcePath: $resourcePath, ')
          ..write('altText: $altText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    chapterId,
    ordinal,
    kind,
    textContent,
    startOffset,
    endOffset,
    inlineSpansJson,
    resourcePath,
    altText,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredContentBlock &&
          other.id == this.id &&
          other.chapterId == this.chapterId &&
          other.ordinal == this.ordinal &&
          other.kind == this.kind &&
          other.textContent == this.textContent &&
          other.startOffset == this.startOffset &&
          other.endOffset == this.endOffset &&
          other.inlineSpansJson == this.inlineSpansJson &&
          other.resourcePath == this.resourcePath &&
          other.altText == this.altText);
}

class ContentBlocksCompanion extends UpdateCompanion<StoredContentBlock> {
  final Value<String> id;
  final Value<String> chapterId;
  final Value<int> ordinal;
  final Value<String> kind;
  final Value<String> textContent;
  final Value<int> startOffset;
  final Value<int> endOffset;
  final Value<String> inlineSpansJson;
  final Value<String?> resourcePath;
  final Value<String?> altText;
  final Value<int> rowid;
  const ContentBlocksCompanion({
    this.id = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.kind = const Value.absent(),
    this.textContent = const Value.absent(),
    this.startOffset = const Value.absent(),
    this.endOffset = const Value.absent(),
    this.inlineSpansJson = const Value.absent(),
    this.resourcePath = const Value.absent(),
    this.altText = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentBlocksCompanion.insert({
    required String id,
    required String chapterId,
    required int ordinal,
    required String kind,
    required String textContent,
    required int startOffset,
    required int endOffset,
    this.inlineSpansJson = const Value.absent(),
    this.resourcePath = const Value.absent(),
    this.altText = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       chapterId = Value(chapterId),
       ordinal = Value(ordinal),
       kind = Value(kind),
       textContent = Value(textContent),
       startOffset = Value(startOffset),
       endOffset = Value(endOffset);
  static Insertable<StoredContentBlock> custom({
    Expression<String>? id,
    Expression<String>? chapterId,
    Expression<int>? ordinal,
    Expression<String>? kind,
    Expression<String>? textContent,
    Expression<int>? startOffset,
    Expression<int>? endOffset,
    Expression<String>? inlineSpansJson,
    Expression<String>? resourcePath,
    Expression<String>? altText,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterId != null) 'chapter_id': chapterId,
      if (ordinal != null) 'ordinal': ordinal,
      if (kind != null) 'kind': kind,
      if (textContent != null) 'text_content': textContent,
      if (startOffset != null) 'start_offset': startOffset,
      if (endOffset != null) 'end_offset': endOffset,
      if (inlineSpansJson != null) 'inline_spans_json': inlineSpansJson,
      if (resourcePath != null) 'resource_path': resourcePath,
      if (altText != null) 'alt_text': altText,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentBlocksCompanion copyWith({
    Value<String>? id,
    Value<String>? chapterId,
    Value<int>? ordinal,
    Value<String>? kind,
    Value<String>? textContent,
    Value<int>? startOffset,
    Value<int>? endOffset,
    Value<String>? inlineSpansJson,
    Value<String?>? resourcePath,
    Value<String?>? altText,
    Value<int>? rowid,
  }) {
    return ContentBlocksCompanion(
      id: id ?? this.id,
      chapterId: chapterId ?? this.chapterId,
      ordinal: ordinal ?? this.ordinal,
      kind: kind ?? this.kind,
      textContent: textContent ?? this.textContent,
      startOffset: startOffset ?? this.startOffset,
      endOffset: endOffset ?? this.endOffset,
      inlineSpansJson: inlineSpansJson ?? this.inlineSpansJson,
      resourcePath: resourcePath ?? this.resourcePath,
      altText: altText ?? this.altText,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (startOffset.present) {
      map['start_offset'] = Variable<int>(startOffset.value);
    }
    if (endOffset.present) {
      map['end_offset'] = Variable<int>(endOffset.value);
    }
    if (inlineSpansJson.present) {
      map['inline_spans_json'] = Variable<String>(inlineSpansJson.value);
    }
    if (resourcePath.present) {
      map['resource_path'] = Variable<String>(resourcePath.value);
    }
    if (altText.present) {
      map['alt_text'] = Variable<String>(altText.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentBlocksCompanion(')
          ..write('id: $id, ')
          ..write('chapterId: $chapterId, ')
          ..write('ordinal: $ordinal, ')
          ..write('kind: $kind, ')
          ..write('textContent: $textContent, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('inlineSpansJson: $inlineSpansJson, ')
          ..write('resourcePath: $resourcePath, ')
          ..write('altText: $altText, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TocEntriesTable extends TocEntries
    with TableInfo<$TocEntriesTable, StoredTocEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TocEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
    'depth',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _textOffsetMeta = const VerificationMeta(
    'textOffset',
  );
  @override
  late final GeneratedColumn<int> textOffset = GeneratedColumn<int>(
    'text_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    parentId,
    ordinal,
    depth,
    title,
    chapterId,
    textOffset,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'toc_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredTocEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
        _depthMeta,
        depth.isAcceptableOrUnknown(data['depth']!, _depthMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    }
    if (data.containsKey('text_offset')) {
      context.handle(
        _textOffsetMeta,
        textOffset.isAcceptableOrUnknown(data['text_offset']!, _textOffsetMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredTocEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredTocEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      depth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}depth'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      ),
      textOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}text_offset'],
      )!,
    );
  }

  @override
  $TocEntriesTable createAlias(String alias) {
    return $TocEntriesTable(attachedDatabase, alias);
  }
}

class StoredTocEntry extends DataClass implements Insertable<StoredTocEntry> {
  final String id;
  final String bookId;
  final String? parentId;
  final int ordinal;
  final int depth;
  final String title;
  final String? chapterId;
  final int textOffset;
  const StoredTocEntry({
    required this.id,
    required this.bookId,
    this.parentId,
    required this.ordinal,
    required this.depth,
    required this.title,
    this.chapterId,
    required this.textOffset,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['ordinal'] = Variable<int>(ordinal);
    map['depth'] = Variable<int>(depth);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || chapterId != null) {
      map['chapter_id'] = Variable<String>(chapterId);
    }
    map['text_offset'] = Variable<int>(textOffset);
    return map;
  }

  TocEntriesCompanion toCompanion(bool nullToAbsent) {
    return TocEntriesCompanion(
      id: Value(id),
      bookId: Value(bookId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      ordinal: Value(ordinal),
      depth: Value(depth),
      title: Value(title),
      chapterId: chapterId == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterId),
      textOffset: Value(textOffset),
    );
  }

  factory StoredTocEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredTocEntry(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      depth: serializer.fromJson<int>(json['depth']),
      title: serializer.fromJson<String>(json['title']),
      chapterId: serializer.fromJson<String?>(json['chapterId']),
      textOffset: serializer.fromJson<int>(json['textOffset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'parentId': serializer.toJson<String?>(parentId),
      'ordinal': serializer.toJson<int>(ordinal),
      'depth': serializer.toJson<int>(depth),
      'title': serializer.toJson<String>(title),
      'chapterId': serializer.toJson<String?>(chapterId),
      'textOffset': serializer.toJson<int>(textOffset),
    };
  }

  StoredTocEntry copyWith({
    String? id,
    String? bookId,
    Value<String?> parentId = const Value.absent(),
    int? ordinal,
    int? depth,
    String? title,
    Value<String?> chapterId = const Value.absent(),
    int? textOffset,
  }) => StoredTocEntry(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    parentId: parentId.present ? parentId.value : this.parentId,
    ordinal: ordinal ?? this.ordinal,
    depth: depth ?? this.depth,
    title: title ?? this.title,
    chapterId: chapterId.present ? chapterId.value : this.chapterId,
    textOffset: textOffset ?? this.textOffset,
  );
  StoredTocEntry copyWithCompanion(TocEntriesCompanion data) {
    return StoredTocEntry(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      depth: data.depth.present ? data.depth.value : this.depth,
      title: data.title.present ? data.title.value : this.title,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      textOffset: data.textOffset.present
          ? data.textOffset.value
          : this.textOffset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredTocEntry(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('parentId: $parentId, ')
          ..write('ordinal: $ordinal, ')
          ..write('depth: $depth, ')
          ..write('title: $title, ')
          ..write('chapterId: $chapterId, ')
          ..write('textOffset: $textOffset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    parentId,
    ordinal,
    depth,
    title,
    chapterId,
    textOffset,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredTocEntry &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.parentId == this.parentId &&
          other.ordinal == this.ordinal &&
          other.depth == this.depth &&
          other.title == this.title &&
          other.chapterId == this.chapterId &&
          other.textOffset == this.textOffset);
}

class TocEntriesCompanion extends UpdateCompanion<StoredTocEntry> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<String?> parentId;
  final Value<int> ordinal;
  final Value<int> depth;
  final Value<String> title;
  final Value<String?> chapterId;
  final Value<int> textOffset;
  final Value<int> rowid;
  const TocEntriesCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.depth = const Value.absent(),
    this.title = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.textOffset = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TocEntriesCompanion.insert({
    required String id,
    required String bookId,
    this.parentId = const Value.absent(),
    required int ordinal,
    this.depth = const Value.absent(),
    required String title,
    this.chapterId = const Value.absent(),
    this.textOffset = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bookId = Value(bookId),
       ordinal = Value(ordinal),
       title = Value(title);
  static Insertable<StoredTocEntry> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<String>? parentId,
    Expression<int>? ordinal,
    Expression<int>? depth,
    Expression<String>? title,
    Expression<String>? chapterId,
    Expression<int>? textOffset,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (parentId != null) 'parent_id': parentId,
      if (ordinal != null) 'ordinal': ordinal,
      if (depth != null) 'depth': depth,
      if (title != null) 'title': title,
      if (chapterId != null) 'chapter_id': chapterId,
      if (textOffset != null) 'text_offset': textOffset,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TocEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? bookId,
    Value<String?>? parentId,
    Value<int>? ordinal,
    Value<int>? depth,
    Value<String>? title,
    Value<String?>? chapterId,
    Value<int>? textOffset,
    Value<int>? rowid,
  }) {
    return TocEntriesCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      parentId: parentId ?? this.parentId,
      ordinal: ordinal ?? this.ordinal,
      depth: depth ?? this.depth,
      title: title ?? this.title,
      chapterId: chapterId ?? this.chapterId,
      textOffset: textOffset ?? this.textOffset,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (textOffset.present) {
      map['text_offset'] = Variable<int>(textOffset.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TocEntriesCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('parentId: $parentId, ')
          ..write('ordinal: $ordinal, ')
          ..write('depth: $depth, ')
          ..write('title: $title, ')
          ..write('chapterId: $chapterId, ')
          ..write('textOffset: $textOffset, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaginationProfilesTable extends PaginationProfiles
    with TableInfo<$PaginationProfilesTable, StoredPaginationProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaginationProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fingerprintMeta = const VerificationMeta(
    'fingerprint',
  );
  @override
  late final GeneratedColumn<String> fingerprint = GeneratedColumn<String>(
    'fingerprint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _viewportWidthMeta = const VerificationMeta(
    'viewportWidth',
  );
  @override
  late final GeneratedColumn<double> viewportWidth = GeneratedColumn<double>(
    'viewport_width',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _viewportHeightMeta = const VerificationMeta(
    'viewportHeight',
  );
  @override
  late final GeneratedColumn<double> viewportHeight = GeneratedColumn<double>(
    'viewport_height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settingsJsonMeta = const VerificationMeta(
    'settingsJson',
  );
  @override
  late final GeneratedColumn<String> settingsJson = GeneratedColumn<String>(
    'settings_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _algorithmVersionMeta = const VerificationMeta(
    'algorithmVersion',
  );
  @override
  late final GeneratedColumn<int> algorithmVersion = GeneratedColumn<int>(
    'algorithm_version',
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
    bookId,
    fingerprint,
    viewportWidth,
    viewportHeight,
    settingsJson,
    algorithmVersion,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pagination_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredPaginationProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('fingerprint')) {
      context.handle(
        _fingerprintMeta,
        fingerprint.isAcceptableOrUnknown(
          data['fingerprint']!,
          _fingerprintMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fingerprintMeta);
    }
    if (data.containsKey('viewport_width')) {
      context.handle(
        _viewportWidthMeta,
        viewportWidth.isAcceptableOrUnknown(
          data['viewport_width']!,
          _viewportWidthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_viewportWidthMeta);
    }
    if (data.containsKey('viewport_height')) {
      context.handle(
        _viewportHeightMeta,
        viewportHeight.isAcceptableOrUnknown(
          data['viewport_height']!,
          _viewportHeightMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_viewportHeightMeta);
    }
    if (data.containsKey('settings_json')) {
      context.handle(
        _settingsJsonMeta,
        settingsJson.isAcceptableOrUnknown(
          data['settings_json']!,
          _settingsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_settingsJsonMeta);
    }
    if (data.containsKey('algorithm_version')) {
      context.handle(
        _algorithmVersionMeta,
        algorithmVersion.isAcceptableOrUnknown(
          data['algorithm_version']!,
          _algorithmVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_algorithmVersionMeta);
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
  StoredPaginationProfile map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredPaginationProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      fingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fingerprint'],
      )!,
      viewportWidth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}viewport_width'],
      )!,
      viewportHeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}viewport_height'],
      )!,
      settingsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settings_json'],
      )!,
      algorithmVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}algorithm_version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaginationProfilesTable createAlias(String alias) {
    return $PaginationProfilesTable(attachedDatabase, alias);
  }
}

class StoredPaginationProfile extends DataClass
    implements Insertable<StoredPaginationProfile> {
  final String id;
  final String bookId;
  final String fingerprint;
  final double viewportWidth;
  final double viewportHeight;
  final String settingsJson;
  final int algorithmVersion;
  final DateTime createdAt;
  const StoredPaginationProfile({
    required this.id,
    required this.bookId,
    required this.fingerprint,
    required this.viewportWidth,
    required this.viewportHeight,
    required this.settingsJson,
    required this.algorithmVersion,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    map['fingerprint'] = Variable<String>(fingerprint);
    map['viewport_width'] = Variable<double>(viewportWidth);
    map['viewport_height'] = Variable<double>(viewportHeight);
    map['settings_json'] = Variable<String>(settingsJson);
    map['algorithm_version'] = Variable<int>(algorithmVersion);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaginationProfilesCompanion toCompanion(bool nullToAbsent) {
    return PaginationProfilesCompanion(
      id: Value(id),
      bookId: Value(bookId),
      fingerprint: Value(fingerprint),
      viewportWidth: Value(viewportWidth),
      viewportHeight: Value(viewportHeight),
      settingsJson: Value(settingsJson),
      algorithmVersion: Value(algorithmVersion),
      createdAt: Value(createdAt),
    );
  }

  factory StoredPaginationProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredPaginationProfile(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      fingerprint: serializer.fromJson<String>(json['fingerprint']),
      viewportWidth: serializer.fromJson<double>(json['viewportWidth']),
      viewportHeight: serializer.fromJson<double>(json['viewportHeight']),
      settingsJson: serializer.fromJson<String>(json['settingsJson']),
      algorithmVersion: serializer.fromJson<int>(json['algorithmVersion']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'fingerprint': serializer.toJson<String>(fingerprint),
      'viewportWidth': serializer.toJson<double>(viewportWidth),
      'viewportHeight': serializer.toJson<double>(viewportHeight),
      'settingsJson': serializer.toJson<String>(settingsJson),
      'algorithmVersion': serializer.toJson<int>(algorithmVersion),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StoredPaginationProfile copyWith({
    String? id,
    String? bookId,
    String? fingerprint,
    double? viewportWidth,
    double? viewportHeight,
    String? settingsJson,
    int? algorithmVersion,
    DateTime? createdAt,
  }) => StoredPaginationProfile(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    fingerprint: fingerprint ?? this.fingerprint,
    viewportWidth: viewportWidth ?? this.viewportWidth,
    viewportHeight: viewportHeight ?? this.viewportHeight,
    settingsJson: settingsJson ?? this.settingsJson,
    algorithmVersion: algorithmVersion ?? this.algorithmVersion,
    createdAt: createdAt ?? this.createdAt,
  );
  StoredPaginationProfile copyWithCompanion(PaginationProfilesCompanion data) {
    return StoredPaginationProfile(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      fingerprint: data.fingerprint.present
          ? data.fingerprint.value
          : this.fingerprint,
      viewportWidth: data.viewportWidth.present
          ? data.viewportWidth.value
          : this.viewportWidth,
      viewportHeight: data.viewportHeight.present
          ? data.viewportHeight.value
          : this.viewportHeight,
      settingsJson: data.settingsJson.present
          ? data.settingsJson.value
          : this.settingsJson,
      algorithmVersion: data.algorithmVersion.present
          ? data.algorithmVersion.value
          : this.algorithmVersion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredPaginationProfile(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('viewportWidth: $viewportWidth, ')
          ..write('viewportHeight: $viewportHeight, ')
          ..write('settingsJson: $settingsJson, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    fingerprint,
    viewportWidth,
    viewportHeight,
    settingsJson,
    algorithmVersion,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredPaginationProfile &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.fingerprint == this.fingerprint &&
          other.viewportWidth == this.viewportWidth &&
          other.viewportHeight == this.viewportHeight &&
          other.settingsJson == this.settingsJson &&
          other.algorithmVersion == this.algorithmVersion &&
          other.createdAt == this.createdAt);
}

class PaginationProfilesCompanion
    extends UpdateCompanion<StoredPaginationProfile> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<String> fingerprint;
  final Value<double> viewportWidth;
  final Value<double> viewportHeight;
  final Value<String> settingsJson;
  final Value<int> algorithmVersion;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PaginationProfilesCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.fingerprint = const Value.absent(),
    this.viewportWidth = const Value.absent(),
    this.viewportHeight = const Value.absent(),
    this.settingsJson = const Value.absent(),
    this.algorithmVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaginationProfilesCompanion.insert({
    required String id,
    required String bookId,
    required String fingerprint,
    required double viewportWidth,
    required double viewportHeight,
    required String settingsJson,
    required int algorithmVersion,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       bookId = Value(bookId),
       fingerprint = Value(fingerprint),
       viewportWidth = Value(viewportWidth),
       viewportHeight = Value(viewportHeight),
       settingsJson = Value(settingsJson),
       algorithmVersion = Value(algorithmVersion);
  static Insertable<StoredPaginationProfile> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<String>? fingerprint,
    Expression<double>? viewportWidth,
    Expression<double>? viewportHeight,
    Expression<String>? settingsJson,
    Expression<int>? algorithmVersion,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (fingerprint != null) 'fingerprint': fingerprint,
      if (viewportWidth != null) 'viewport_width': viewportWidth,
      if (viewportHeight != null) 'viewport_height': viewportHeight,
      if (settingsJson != null) 'settings_json': settingsJson,
      if (algorithmVersion != null) 'algorithm_version': algorithmVersion,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaginationProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? bookId,
    Value<String>? fingerprint,
    Value<double>? viewportWidth,
    Value<double>? viewportHeight,
    Value<String>? settingsJson,
    Value<int>? algorithmVersion,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PaginationProfilesCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      fingerprint: fingerprint ?? this.fingerprint,
      viewportWidth: viewportWidth ?? this.viewportWidth,
      viewportHeight: viewportHeight ?? this.viewportHeight,
      settingsJson: settingsJson ?? this.settingsJson,
      algorithmVersion: algorithmVersion ?? this.algorithmVersion,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (fingerprint.present) {
      map['fingerprint'] = Variable<String>(fingerprint.value);
    }
    if (viewportWidth.present) {
      map['viewport_width'] = Variable<double>(viewportWidth.value);
    }
    if (viewportHeight.present) {
      map['viewport_height'] = Variable<double>(viewportHeight.value);
    }
    if (settingsJson.present) {
      map['settings_json'] = Variable<String>(settingsJson.value);
    }
    if (algorithmVersion.present) {
      map['algorithm_version'] = Variable<int>(algorithmVersion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaginationProfilesCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('fingerprint: $fingerprint, ')
          ..write('viewportWidth: $viewportWidth, ')
          ..write('viewportHeight: $viewportHeight, ')
          ..write('settingsJson: $settingsJson, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookPagesTable extends BookPages
    with TableInfo<$BookPagesTable, StoredPage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookPagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pagination_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chapters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pageIndexMeta = const VerificationMeta(
    'pageIndex',
  );
  @override
  late final GeneratedColumn<int> pageIndex = GeneratedColumn<int>(
    'page_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startOffsetMeta = const VerificationMeta(
    'startOffset',
  );
  @override
  late final GeneratedColumn<int> startOffset = GeneratedColumn<int>(
    'start_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endOffsetMeta = const VerificationMeta(
    'endOffset',
  );
  @override
  late final GeneratedColumn<int> endOffset = GeneratedColumn<int>(
    'end_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    chapterId,
    pageIndex,
    startOffset,
    endOffset,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_pages';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredPage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('page_index')) {
      context.handle(
        _pageIndexMeta,
        pageIndex.isAcceptableOrUnknown(data['page_index']!, _pageIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_pageIndexMeta);
    }
    if (data.containsKey('start_offset')) {
      context.handle(
        _startOffsetMeta,
        startOffset.isAcceptableOrUnknown(
          data['start_offset']!,
          _startOffsetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startOffsetMeta);
    }
    if (data.containsKey('end_offset')) {
      context.handle(
        _endOffsetMeta,
        endOffset.isAcceptableOrUnknown(data['end_offset']!, _endOffsetMeta),
      );
    } else if (isInserting) {
      context.missing(_endOffsetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredPage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredPage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      )!,
      pageIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page_index'],
      )!,
      startOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_offset'],
      )!,
      endOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_offset'],
      )!,
    );
  }

  @override
  $BookPagesTable createAlias(String alias) {
    return $BookPagesTable(attachedDatabase, alias);
  }
}

class StoredPage extends DataClass implements Insertable<StoredPage> {
  final String id;
  final String profileId;
  final String chapterId;
  final int pageIndex;
  final int startOffset;
  final int endOffset;
  const StoredPage({
    required this.id,
    required this.profileId,
    required this.chapterId,
    required this.pageIndex,
    required this.startOffset,
    required this.endOffset,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['chapter_id'] = Variable<String>(chapterId);
    map['page_index'] = Variable<int>(pageIndex);
    map['start_offset'] = Variable<int>(startOffset);
    map['end_offset'] = Variable<int>(endOffset);
    return map;
  }

  BookPagesCompanion toCompanion(bool nullToAbsent) {
    return BookPagesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      chapterId: Value(chapterId),
      pageIndex: Value(pageIndex),
      startOffset: Value(startOffset),
      endOffset: Value(endOffset),
    );
  }

  factory StoredPage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredPage(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      pageIndex: serializer.fromJson<int>(json['pageIndex']),
      startOffset: serializer.fromJson<int>(json['startOffset']),
      endOffset: serializer.fromJson<int>(json['endOffset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'chapterId': serializer.toJson<String>(chapterId),
      'pageIndex': serializer.toJson<int>(pageIndex),
      'startOffset': serializer.toJson<int>(startOffset),
      'endOffset': serializer.toJson<int>(endOffset),
    };
  }

  StoredPage copyWith({
    String? id,
    String? profileId,
    String? chapterId,
    int? pageIndex,
    int? startOffset,
    int? endOffset,
  }) => StoredPage(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    chapterId: chapterId ?? this.chapterId,
    pageIndex: pageIndex ?? this.pageIndex,
    startOffset: startOffset ?? this.startOffset,
    endOffset: endOffset ?? this.endOffset,
  );
  StoredPage copyWithCompanion(BookPagesCompanion data) {
    return StoredPage(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      pageIndex: data.pageIndex.present ? data.pageIndex.value : this.pageIndex,
      startOffset: data.startOffset.present
          ? data.startOffset.value
          : this.startOffset,
      endOffset: data.endOffset.present ? data.endOffset.value : this.endOffset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredPage(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('chapterId: $chapterId, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, profileId, chapterId, pageIndex, startOffset, endOffset);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredPage &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.chapterId == this.chapterId &&
          other.pageIndex == this.pageIndex &&
          other.startOffset == this.startOffset &&
          other.endOffset == this.endOffset);
}

class BookPagesCompanion extends UpdateCompanion<StoredPage> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> chapterId;
  final Value<int> pageIndex;
  final Value<int> startOffset;
  final Value<int> endOffset;
  final Value<int> rowid;
  const BookPagesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.pageIndex = const Value.absent(),
    this.startOffset = const Value.absent(),
    this.endOffset = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookPagesCompanion.insert({
    required String id,
    required String profileId,
    required String chapterId,
    required int pageIndex,
    required int startOffset,
    required int endOffset,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       chapterId = Value(chapterId),
       pageIndex = Value(pageIndex),
       startOffset = Value(startOffset),
       endOffset = Value(endOffset);
  static Insertable<StoredPage> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? chapterId,
    Expression<int>? pageIndex,
    Expression<int>? startOffset,
    Expression<int>? endOffset,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (pageIndex != null) 'page_index': pageIndex,
      if (startOffset != null) 'start_offset': startOffset,
      if (endOffset != null) 'end_offset': endOffset,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookPagesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? chapterId,
    Value<int>? pageIndex,
    Value<int>? startOffset,
    Value<int>? endOffset,
    Value<int>? rowid,
  }) {
    return BookPagesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      chapterId: chapterId ?? this.chapterId,
      pageIndex: pageIndex ?? this.pageIndex,
      startOffset: startOffset ?? this.startOffset,
      endOffset: endOffset ?? this.endOffset,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (pageIndex.present) {
      map['page_index'] = Variable<int>(pageIndex.value);
    }
    if (startOffset.present) {
      map['start_offset'] = Variable<int>(startOffset.value);
    }
    if (endOffset.present) {
      map['end_offset'] = Variable<int>(endOffset.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookPagesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('chapterId: $chapterId, ')
          ..write('pageIndex: $pageIndex, ')
          ..write('startOffset: $startOffset, ')
          ..write('endOffset: $endOffset, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReaderPositionsTable extends ReaderPositions
    with TableInfo<$ReaderPositionsTable, StoredReaderPosition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReaderPositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterIdMeta = const VerificationMeta(
    'chapterId',
  );
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
    'chapter_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textOffsetMeta = const VerificationMeta(
    'textOffset',
  );
  @override
  late final GeneratedColumn<int> textOffset = GeneratedColumn<int>(
    'text_offset',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    bookId,
    chapterId,
    textOffset,
    progress,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reader_positions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredReaderPosition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter_id')) {
      context.handle(
        _chapterIdMeta,
        chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('text_offset')) {
      context.handle(
        _textOffsetMeta,
        textOffset.isAcceptableOrUnknown(data['text_offset']!, _textOffsetMeta),
      );
    } else if (isInserting) {
      context.missing(_textOffsetMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookId};
  @override
  StoredReaderPosition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredReaderPosition(
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}book_id'],
      )!,
      chapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_id'],
      )!,
      textOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}text_offset'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReaderPositionsTable createAlias(String alias) {
    return $ReaderPositionsTable(attachedDatabase, alias);
  }
}

class StoredReaderPosition extends DataClass
    implements Insertable<StoredReaderPosition> {
  final String bookId;
  final String chapterId;
  final int textOffset;
  final double progress;
  final DateTime updatedAt;
  const StoredReaderPosition({
    required this.bookId,
    required this.chapterId,
    required this.textOffset,
    required this.progress,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['book_id'] = Variable<String>(bookId);
    map['chapter_id'] = Variable<String>(chapterId);
    map['text_offset'] = Variable<int>(textOffset);
    map['progress'] = Variable<double>(progress);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReaderPositionsCompanion toCompanion(bool nullToAbsent) {
    return ReaderPositionsCompanion(
      bookId: Value(bookId),
      chapterId: Value(chapterId),
      textOffset: Value(textOffset),
      progress: Value(progress),
      updatedAt: Value(updatedAt),
    );
  }

  factory StoredReaderPosition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredReaderPosition(
      bookId: serializer.fromJson<String>(json['bookId']),
      chapterId: serializer.fromJson<String>(json['chapterId']),
      textOffset: serializer.fromJson<int>(json['textOffset']),
      progress: serializer.fromJson<double>(json['progress']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookId': serializer.toJson<String>(bookId),
      'chapterId': serializer.toJson<String>(chapterId),
      'textOffset': serializer.toJson<int>(textOffset),
      'progress': serializer.toJson<double>(progress),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StoredReaderPosition copyWith({
    String? bookId,
    String? chapterId,
    int? textOffset,
    double? progress,
    DateTime? updatedAt,
  }) => StoredReaderPosition(
    bookId: bookId ?? this.bookId,
    chapterId: chapterId ?? this.chapterId,
    textOffset: textOffset ?? this.textOffset,
    progress: progress ?? this.progress,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StoredReaderPosition copyWithCompanion(ReaderPositionsCompanion data) {
    return StoredReaderPosition(
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      textOffset: data.textOffset.present
          ? data.textOffset.value
          : this.textOffset,
      progress: data.progress.present ? data.progress.value : this.progress,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredReaderPosition(')
          ..write('bookId: $bookId, ')
          ..write('chapterId: $chapterId, ')
          ..write('textOffset: $textOffset, ')
          ..write('progress: $progress, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(bookId, chapterId, textOffset, progress, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredReaderPosition &&
          other.bookId == this.bookId &&
          other.chapterId == this.chapterId &&
          other.textOffset == this.textOffset &&
          other.progress == this.progress &&
          other.updatedAt == this.updatedAt);
}

class ReaderPositionsCompanion extends UpdateCompanion<StoredReaderPosition> {
  final Value<String> bookId;
  final Value<String> chapterId;
  final Value<int> textOffset;
  final Value<double> progress;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ReaderPositionsCompanion({
    this.bookId = const Value.absent(),
    this.chapterId = const Value.absent(),
    this.textOffset = const Value.absent(),
    this.progress = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReaderPositionsCompanion.insert({
    required String bookId,
    required String chapterId,
    required int textOffset,
    required double progress,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : bookId = Value(bookId),
       chapterId = Value(chapterId),
       textOffset = Value(textOffset),
       progress = Value(progress),
       updatedAt = Value(updatedAt);
  static Insertable<StoredReaderPosition> custom({
    Expression<String>? bookId,
    Expression<String>? chapterId,
    Expression<int>? textOffset,
    Expression<double>? progress,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (bookId != null) 'book_id': bookId,
      if (chapterId != null) 'chapter_id': chapterId,
      if (textOffset != null) 'text_offset': textOffset,
      if (progress != null) 'progress': progress,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReaderPositionsCompanion copyWith({
    Value<String>? bookId,
    Value<String>? chapterId,
    Value<int>? textOffset,
    Value<double>? progress,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ReaderPositionsCompanion(
      bookId: bookId ?? this.bookId,
      chapterId: chapterId ?? this.chapterId,
      textOffset: textOffset ?? this.textOffset,
      progress: progress ?? this.progress,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (textOffset.present) {
      map['text_offset'] = Variable<int>(textOffset.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReaderPositionsCompanion(')
          ..write('bookId: $bookId, ')
          ..write('chapterId: $chapterId, ')
          ..write('textOffset: $textOffset, ')
          ..write('progress: $progress, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabularyItemsTable extends VocabularyItems
    with TableInfo<$VocabularyItemsTable, StoredVocabularyItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceLanguageMeta = const VerificationMeta(
    'sourceLanguage',
  );
  @override
  late final GeneratedColumn<String> sourceLanguage = GeneratedColumn<String>(
    'source_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetLanguageMeta = const VerificationMeta(
    'targetLanguage',
  );
  @override
  late final GeneratedColumn<String> targetLanguage = GeneratedColumn<String>(
    'target_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lemmaMeta = const VerificationMeta('lemma');
  @override
  late final GeneratedColumn<String> lemma = GeneratedColumn<String>(
    'lemma',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedLemmaMeta = const VerificationMeta(
    'normalizedLemma',
  );
  @override
  late final GeneratedColumn<String> normalizedLemma = GeneratedColumn<String>(
    'normalized_lemma',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('word'),
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('new'),
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverRevisionMeta = const VerificationMeta(
    'serverRevision',
  );
  @override
  late final GeneratedColumn<int> serverRevision = GeneratedColumn<int>(
    'server_revision',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sourceLanguage,
    targetLanguage,
    lemma,
    normalizedLemma,
    translation,
    kind,
    partOfSpeech,
    status,
    createdAt,
    updatedAt,
    deletedAt,
    serverRevision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredVocabularyItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('source_language')) {
      context.handle(
        _sourceLanguageMeta,
        sourceLanguage.isAcceptableOrUnknown(
          data['source_language']!,
          _sourceLanguageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceLanguageMeta);
    }
    if (data.containsKey('target_language')) {
      context.handle(
        _targetLanguageMeta,
        targetLanguage.isAcceptableOrUnknown(
          data['target_language']!,
          _targetLanguageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetLanguageMeta);
    }
    if (data.containsKey('lemma')) {
      context.handle(
        _lemmaMeta,
        lemma.isAcceptableOrUnknown(data['lemma']!, _lemmaMeta),
      );
    } else if (isInserting) {
      context.missing(_lemmaMeta);
    }
    if (data.containsKey('normalized_lemma')) {
      context.handle(
        _normalizedLemmaMeta,
        normalizedLemma.isAcceptableOrUnknown(
          data['normalized_lemma']!,
          _normalizedLemmaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedLemmaMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
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
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('server_revision')) {
      context.handle(
        _serverRevisionMeta,
        serverRevision.isAcceptableOrUnknown(
          data['server_revision']!,
          _serverRevisionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredVocabularyItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredVocabularyItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sourceLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_language'],
      )!,
      targetLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_language'],
      )!,
      lemma: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lemma'],
      )!,
      normalizedLemma: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_lemma'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      serverRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_revision'],
      ),
    );
  }

  @override
  $VocabularyItemsTable createAlias(String alias) {
    return $VocabularyItemsTable(attachedDatabase, alias);
  }
}

class StoredVocabularyItem extends DataClass
    implements Insertable<StoredVocabularyItem> {
  final String id;
  final String sourceLanguage;
  final String targetLanguage;
  final String lemma;
  final String normalizedLemma;
  final String translation;
  final String kind;
  final String? partOfSpeech;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int? serverRevision;
  const StoredVocabularyItem({
    required this.id,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.lemma,
    required this.normalizedLemma,
    required this.translation,
    required this.kind,
    this.partOfSpeech,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.serverRevision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['source_language'] = Variable<String>(sourceLanguage);
    map['target_language'] = Variable<String>(targetLanguage);
    map['lemma'] = Variable<String>(lemma);
    map['normalized_lemma'] = Variable<String>(normalizedLemma);
    map['translation'] = Variable<String>(translation);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || partOfSpeech != null) {
      map['part_of_speech'] = Variable<String>(partOfSpeech);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || serverRevision != null) {
      map['server_revision'] = Variable<int>(serverRevision);
    }
    return map;
  }

  VocabularyItemsCompanion toCompanion(bool nullToAbsent) {
    return VocabularyItemsCompanion(
      id: Value(id),
      sourceLanguage: Value(sourceLanguage),
      targetLanguage: Value(targetLanguage),
      lemma: Value(lemma),
      normalizedLemma: Value(normalizedLemma),
      translation: Value(translation),
      kind: Value(kind),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const Value.absent()
          : Value(partOfSpeech),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      serverRevision: serverRevision == null && nullToAbsent
          ? const Value.absent()
          : Value(serverRevision),
    );
  }

  factory StoredVocabularyItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredVocabularyItem(
      id: serializer.fromJson<String>(json['id']),
      sourceLanguage: serializer.fromJson<String>(json['sourceLanguage']),
      targetLanguage: serializer.fromJson<String>(json['targetLanguage']),
      lemma: serializer.fromJson<String>(json['lemma']),
      normalizedLemma: serializer.fromJson<String>(json['normalizedLemma']),
      translation: serializer.fromJson<String>(json['translation']),
      kind: serializer.fromJson<String>(json['kind']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      serverRevision: serializer.fromJson<int?>(json['serverRevision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sourceLanguage': serializer.toJson<String>(sourceLanguage),
      'targetLanguage': serializer.toJson<String>(targetLanguage),
      'lemma': serializer.toJson<String>(lemma),
      'normalizedLemma': serializer.toJson<String>(normalizedLemma),
      'translation': serializer.toJson<String>(translation),
      'kind': serializer.toJson<String>(kind),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'serverRevision': serializer.toJson<int?>(serverRevision),
    };
  }

  StoredVocabularyItem copyWith({
    String? id,
    String? sourceLanguage,
    String? targetLanguage,
    String? lemma,
    String? normalizedLemma,
    String? translation,
    String? kind,
    Value<String?> partOfSpeech = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<int?> serverRevision = const Value.absent(),
  }) => StoredVocabularyItem(
    id: id ?? this.id,
    sourceLanguage: sourceLanguage ?? this.sourceLanguage,
    targetLanguage: targetLanguage ?? this.targetLanguage,
    lemma: lemma ?? this.lemma,
    normalizedLemma: normalizedLemma ?? this.normalizedLemma,
    translation: translation ?? this.translation,
    kind: kind ?? this.kind,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    serverRevision: serverRevision.present
        ? serverRevision.value
        : this.serverRevision,
  );
  StoredVocabularyItem copyWithCompanion(VocabularyItemsCompanion data) {
    return StoredVocabularyItem(
      id: data.id.present ? data.id.value : this.id,
      sourceLanguage: data.sourceLanguage.present
          ? data.sourceLanguage.value
          : this.sourceLanguage,
      targetLanguage: data.targetLanguage.present
          ? data.targetLanguage.value
          : this.targetLanguage,
      lemma: data.lemma.present ? data.lemma.value : this.lemma,
      normalizedLemma: data.normalizedLemma.present
          ? data.normalizedLemma.value
          : this.normalizedLemma,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      kind: data.kind.present ? data.kind.value : this.kind,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      serverRevision: data.serverRevision.present
          ? data.serverRevision.value
          : this.serverRevision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredVocabularyItem(')
          ..write('id: $id, ')
          ..write('sourceLanguage: $sourceLanguage, ')
          ..write('targetLanguage: $targetLanguage, ')
          ..write('lemma: $lemma, ')
          ..write('normalizedLemma: $normalizedLemma, ')
          ..write('translation: $translation, ')
          ..write('kind: $kind, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverRevision: $serverRevision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sourceLanguage,
    targetLanguage,
    lemma,
    normalizedLemma,
    translation,
    kind,
    partOfSpeech,
    status,
    createdAt,
    updatedAt,
    deletedAt,
    serverRevision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredVocabularyItem &&
          other.id == this.id &&
          other.sourceLanguage == this.sourceLanguage &&
          other.targetLanguage == this.targetLanguage &&
          other.lemma == this.lemma &&
          other.normalizedLemma == this.normalizedLemma &&
          other.translation == this.translation &&
          other.kind == this.kind &&
          other.partOfSpeech == this.partOfSpeech &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.serverRevision == this.serverRevision);
}

class VocabularyItemsCompanion extends UpdateCompanion<StoredVocabularyItem> {
  final Value<String> id;
  final Value<String> sourceLanguage;
  final Value<String> targetLanguage;
  final Value<String> lemma;
  final Value<String> normalizedLemma;
  final Value<String> translation;
  final Value<String> kind;
  final Value<String?> partOfSpeech;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int?> serverRevision;
  final Value<int> rowid;
  const VocabularyItemsCompanion({
    this.id = const Value.absent(),
    this.sourceLanguage = const Value.absent(),
    this.targetLanguage = const Value.absent(),
    this.lemma = const Value.absent(),
    this.normalizedLemma = const Value.absent(),
    this.translation = const Value.absent(),
    this.kind = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.serverRevision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabularyItemsCompanion.insert({
    required String id,
    required String sourceLanguage,
    required String targetLanguage,
    required String lemma,
    required String normalizedLemma,
    required String translation,
    this.kind = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.serverRevision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sourceLanguage = Value(sourceLanguage),
       targetLanguage = Value(targetLanguage),
       lemma = Value(lemma),
       normalizedLemma = Value(normalizedLemma),
       translation = Value(translation),
       updatedAt = Value(updatedAt);
  static Insertable<StoredVocabularyItem> custom({
    Expression<String>? id,
    Expression<String>? sourceLanguage,
    Expression<String>? targetLanguage,
    Expression<String>? lemma,
    Expression<String>? normalizedLemma,
    Expression<String>? translation,
    Expression<String>? kind,
    Expression<String>? partOfSpeech,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? serverRevision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sourceLanguage != null) 'source_language': sourceLanguage,
      if (targetLanguage != null) 'target_language': targetLanguage,
      if (lemma != null) 'lemma': lemma,
      if (normalizedLemma != null) 'normalized_lemma': normalizedLemma,
      if (translation != null) 'translation': translation,
      if (kind != null) 'kind': kind,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (serverRevision != null) 'server_revision': serverRevision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabularyItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? sourceLanguage,
    Value<String>? targetLanguage,
    Value<String>? lemma,
    Value<String>? normalizedLemma,
    Value<String>? translation,
    Value<String>? kind,
    Value<String?>? partOfSpeech,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int?>? serverRevision,
    Value<int>? rowid,
  }) {
    return VocabularyItemsCompanion(
      id: id ?? this.id,
      sourceLanguage: sourceLanguage ?? this.sourceLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      lemma: lemma ?? this.lemma,
      normalizedLemma: normalizedLemma ?? this.normalizedLemma,
      translation: translation ?? this.translation,
      kind: kind ?? this.kind,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      serverRevision: serverRevision ?? this.serverRevision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sourceLanguage.present) {
      map['source_language'] = Variable<String>(sourceLanguage.value);
    }
    if (targetLanguage.present) {
      map['target_language'] = Variable<String>(targetLanguage.value);
    }
    if (lemma.present) {
      map['lemma'] = Variable<String>(lemma.value);
    }
    if (normalizedLemma.present) {
      map['normalized_lemma'] = Variable<String>(normalizedLemma.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (serverRevision.present) {
      map['server_revision'] = Variable<int>(serverRevision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyItemsCompanion(')
          ..write('id: $id, ')
          ..write('sourceLanguage: $sourceLanguage, ')
          ..write('targetLanguage: $targetLanguage, ')
          ..write('lemma: $lemma, ')
          ..write('normalizedLemma: $normalizedLemma, ')
          ..write('translation: $translation, ')
          ..write('kind: $kind, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('serverRevision: $serverRevision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordOccurrencesTable extends WordOccurrences
    with TableInfo<$WordOccurrencesTable, StoredWordOccurrence> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordOccurrencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vocabularyIdMeta = const VerificationMeta(
    'vocabularyId',
  );
  @override
  late final GeneratedColumn<String> vocabularyId = GeneratedColumn<String>(
    'vocabulary_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabulary_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _surfaceFormMeta = const VerificationMeta(
    'surfaceForm',
  );
  @override
  late final GeneratedColumn<String> surfaceForm = GeneratedColumn<String>(
    'surface_form',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contextSentenceMeta = const VerificationMeta(
    'contextSentence',
  );
  @override
  late final GeneratedColumn<String> contextSentence = GeneratedColumn<String>(
    'context_sentence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordStartMeta = const VerificationMeta(
    'wordStart',
  );
  @override
  late final GeneratedColumn<int> wordStart = GeneratedColumn<int>(
    'word_start',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordEndMeta = const VerificationMeta(
    'wordEnd',
  );
  @override
  late final GeneratedColumn<int> wordEnd = GeneratedColumn<int>(
    'word_end',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceBookIdMeta = const VerificationMeta(
    'sourceBookId',
  );
  @override
  late final GeneratedColumn<String> sourceBookId = GeneratedColumn<String>(
    'source_book_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceBookTitleMeta = const VerificationMeta(
    'sourceBookTitle',
  );
  @override
  late final GeneratedColumn<String> sourceBookTitle = GeneratedColumn<String>(
    'source_book_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceChapterIdMeta = const VerificationMeta(
    'sourceChapterId',
  );
  @override
  late final GeneratedColumn<String> sourceChapterId = GeneratedColumn<String>(
    'source_chapter_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceChapterTitleMeta =
      const VerificationMeta('sourceChapterTitle');
  @override
  late final GeneratedColumn<String> sourceChapterTitle =
      GeneratedColumn<String>(
        'source_chapter_title',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sourceOffsetMeta = const VerificationMeta(
    'sourceOffset',
  );
  @override
  late final GeneratedColumn<int> sourceOffset = GeneratedColumn<int>(
    'source_offset',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    vocabularyId,
    surfaceForm,
    contextSentence,
    wordStart,
    wordEnd,
    sourceBookId,
    sourceBookTitle,
    sourceChapterId,
    sourceChapterTitle,
    sourceOffset,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_occurrences';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredWordOccurrence> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vocabulary_id')) {
      context.handle(
        _vocabularyIdMeta,
        vocabularyId.isAcceptableOrUnknown(
          data['vocabulary_id']!,
          _vocabularyIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vocabularyIdMeta);
    }
    if (data.containsKey('surface_form')) {
      context.handle(
        _surfaceFormMeta,
        surfaceForm.isAcceptableOrUnknown(
          data['surface_form']!,
          _surfaceFormMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surfaceFormMeta);
    }
    if (data.containsKey('context_sentence')) {
      context.handle(
        _contextSentenceMeta,
        contextSentence.isAcceptableOrUnknown(
          data['context_sentence']!,
          _contextSentenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contextSentenceMeta);
    }
    if (data.containsKey('word_start')) {
      context.handle(
        _wordStartMeta,
        wordStart.isAcceptableOrUnknown(data['word_start']!, _wordStartMeta),
      );
    } else if (isInserting) {
      context.missing(_wordStartMeta);
    }
    if (data.containsKey('word_end')) {
      context.handle(
        _wordEndMeta,
        wordEnd.isAcceptableOrUnknown(data['word_end']!, _wordEndMeta),
      );
    } else if (isInserting) {
      context.missing(_wordEndMeta);
    }
    if (data.containsKey('source_book_id')) {
      context.handle(
        _sourceBookIdMeta,
        sourceBookId.isAcceptableOrUnknown(
          data['source_book_id']!,
          _sourceBookIdMeta,
        ),
      );
    }
    if (data.containsKey('source_book_title')) {
      context.handle(
        _sourceBookTitleMeta,
        sourceBookTitle.isAcceptableOrUnknown(
          data['source_book_title']!,
          _sourceBookTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceBookTitleMeta);
    }
    if (data.containsKey('source_chapter_id')) {
      context.handle(
        _sourceChapterIdMeta,
        sourceChapterId.isAcceptableOrUnknown(
          data['source_chapter_id']!,
          _sourceChapterIdMeta,
        ),
      );
    }
    if (data.containsKey('source_chapter_title')) {
      context.handle(
        _sourceChapterTitleMeta,
        sourceChapterTitle.isAcceptableOrUnknown(
          data['source_chapter_title']!,
          _sourceChapterTitleMeta,
        ),
      );
    }
    if (data.containsKey('source_offset')) {
      context.handle(
        _sourceOffsetMeta,
        sourceOffset.isAcceptableOrUnknown(
          data['source_offset']!,
          _sourceOffsetMeta,
        ),
      );
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
  StoredWordOccurrence map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredWordOccurrence(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vocabularyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocabulary_id'],
      )!,
      surfaceForm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surface_form'],
      )!,
      contextSentence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}context_sentence'],
      )!,
      wordStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_start'],
      )!,
      wordEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_end'],
      )!,
      sourceBookId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_book_id'],
      ),
      sourceBookTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_book_title'],
      )!,
      sourceChapterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_chapter_id'],
      ),
      sourceChapterTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_chapter_title'],
      ),
      sourceOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_offset'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WordOccurrencesTable createAlias(String alias) {
    return $WordOccurrencesTable(attachedDatabase, alias);
  }
}

class StoredWordOccurrence extends DataClass
    implements Insertable<StoredWordOccurrence> {
  final String id;
  final String vocabularyId;
  final String surfaceForm;
  final String contextSentence;
  final int wordStart;
  final int wordEnd;
  final String? sourceBookId;
  final String sourceBookTitle;
  final String? sourceChapterId;
  final String? sourceChapterTitle;
  final int? sourceOffset;
  final DateTime createdAt;
  const StoredWordOccurrence({
    required this.id,
    required this.vocabularyId,
    required this.surfaceForm,
    required this.contextSentence,
    required this.wordStart,
    required this.wordEnd,
    this.sourceBookId,
    required this.sourceBookTitle,
    this.sourceChapterId,
    this.sourceChapterTitle,
    this.sourceOffset,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vocabulary_id'] = Variable<String>(vocabularyId);
    map['surface_form'] = Variable<String>(surfaceForm);
    map['context_sentence'] = Variable<String>(contextSentence);
    map['word_start'] = Variable<int>(wordStart);
    map['word_end'] = Variable<int>(wordEnd);
    if (!nullToAbsent || sourceBookId != null) {
      map['source_book_id'] = Variable<String>(sourceBookId);
    }
    map['source_book_title'] = Variable<String>(sourceBookTitle);
    if (!nullToAbsent || sourceChapterId != null) {
      map['source_chapter_id'] = Variable<String>(sourceChapterId);
    }
    if (!nullToAbsent || sourceChapterTitle != null) {
      map['source_chapter_title'] = Variable<String>(sourceChapterTitle);
    }
    if (!nullToAbsent || sourceOffset != null) {
      map['source_offset'] = Variable<int>(sourceOffset);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WordOccurrencesCompanion toCompanion(bool nullToAbsent) {
    return WordOccurrencesCompanion(
      id: Value(id),
      vocabularyId: Value(vocabularyId),
      surfaceForm: Value(surfaceForm),
      contextSentence: Value(contextSentence),
      wordStart: Value(wordStart),
      wordEnd: Value(wordEnd),
      sourceBookId: sourceBookId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceBookId),
      sourceBookTitle: Value(sourceBookTitle),
      sourceChapterId: sourceChapterId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceChapterId),
      sourceChapterTitle: sourceChapterTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceChapterTitle),
      sourceOffset: sourceOffset == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceOffset),
      createdAt: Value(createdAt),
    );
  }

  factory StoredWordOccurrence.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredWordOccurrence(
      id: serializer.fromJson<String>(json['id']),
      vocabularyId: serializer.fromJson<String>(json['vocabularyId']),
      surfaceForm: serializer.fromJson<String>(json['surfaceForm']),
      contextSentence: serializer.fromJson<String>(json['contextSentence']),
      wordStart: serializer.fromJson<int>(json['wordStart']),
      wordEnd: serializer.fromJson<int>(json['wordEnd']),
      sourceBookId: serializer.fromJson<String?>(json['sourceBookId']),
      sourceBookTitle: serializer.fromJson<String>(json['sourceBookTitle']),
      sourceChapterId: serializer.fromJson<String?>(json['sourceChapterId']),
      sourceChapterTitle: serializer.fromJson<String?>(
        json['sourceChapterTitle'],
      ),
      sourceOffset: serializer.fromJson<int?>(json['sourceOffset']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vocabularyId': serializer.toJson<String>(vocabularyId),
      'surfaceForm': serializer.toJson<String>(surfaceForm),
      'contextSentence': serializer.toJson<String>(contextSentence),
      'wordStart': serializer.toJson<int>(wordStart),
      'wordEnd': serializer.toJson<int>(wordEnd),
      'sourceBookId': serializer.toJson<String?>(sourceBookId),
      'sourceBookTitle': serializer.toJson<String>(sourceBookTitle),
      'sourceChapterId': serializer.toJson<String?>(sourceChapterId),
      'sourceChapterTitle': serializer.toJson<String?>(sourceChapterTitle),
      'sourceOffset': serializer.toJson<int?>(sourceOffset),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StoredWordOccurrence copyWith({
    String? id,
    String? vocabularyId,
    String? surfaceForm,
    String? contextSentence,
    int? wordStart,
    int? wordEnd,
    Value<String?> sourceBookId = const Value.absent(),
    String? sourceBookTitle,
    Value<String?> sourceChapterId = const Value.absent(),
    Value<String?> sourceChapterTitle = const Value.absent(),
    Value<int?> sourceOffset = const Value.absent(),
    DateTime? createdAt,
  }) => StoredWordOccurrence(
    id: id ?? this.id,
    vocabularyId: vocabularyId ?? this.vocabularyId,
    surfaceForm: surfaceForm ?? this.surfaceForm,
    contextSentence: contextSentence ?? this.contextSentence,
    wordStart: wordStart ?? this.wordStart,
    wordEnd: wordEnd ?? this.wordEnd,
    sourceBookId: sourceBookId.present ? sourceBookId.value : this.sourceBookId,
    sourceBookTitle: sourceBookTitle ?? this.sourceBookTitle,
    sourceChapterId: sourceChapterId.present
        ? sourceChapterId.value
        : this.sourceChapterId,
    sourceChapterTitle: sourceChapterTitle.present
        ? sourceChapterTitle.value
        : this.sourceChapterTitle,
    sourceOffset: sourceOffset.present ? sourceOffset.value : this.sourceOffset,
    createdAt: createdAt ?? this.createdAt,
  );
  StoredWordOccurrence copyWithCompanion(WordOccurrencesCompanion data) {
    return StoredWordOccurrence(
      id: data.id.present ? data.id.value : this.id,
      vocabularyId: data.vocabularyId.present
          ? data.vocabularyId.value
          : this.vocabularyId,
      surfaceForm: data.surfaceForm.present
          ? data.surfaceForm.value
          : this.surfaceForm,
      contextSentence: data.contextSentence.present
          ? data.contextSentence.value
          : this.contextSentence,
      wordStart: data.wordStart.present ? data.wordStart.value : this.wordStart,
      wordEnd: data.wordEnd.present ? data.wordEnd.value : this.wordEnd,
      sourceBookId: data.sourceBookId.present
          ? data.sourceBookId.value
          : this.sourceBookId,
      sourceBookTitle: data.sourceBookTitle.present
          ? data.sourceBookTitle.value
          : this.sourceBookTitle,
      sourceChapterId: data.sourceChapterId.present
          ? data.sourceChapterId.value
          : this.sourceChapterId,
      sourceChapterTitle: data.sourceChapterTitle.present
          ? data.sourceChapterTitle.value
          : this.sourceChapterTitle,
      sourceOffset: data.sourceOffset.present
          ? data.sourceOffset.value
          : this.sourceOffset,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredWordOccurrence(')
          ..write('id: $id, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('surfaceForm: $surfaceForm, ')
          ..write('contextSentence: $contextSentence, ')
          ..write('wordStart: $wordStart, ')
          ..write('wordEnd: $wordEnd, ')
          ..write('sourceBookId: $sourceBookId, ')
          ..write('sourceBookTitle: $sourceBookTitle, ')
          ..write('sourceChapterId: $sourceChapterId, ')
          ..write('sourceChapterTitle: $sourceChapterTitle, ')
          ..write('sourceOffset: $sourceOffset, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vocabularyId,
    surfaceForm,
    contextSentence,
    wordStart,
    wordEnd,
    sourceBookId,
    sourceBookTitle,
    sourceChapterId,
    sourceChapterTitle,
    sourceOffset,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredWordOccurrence &&
          other.id == this.id &&
          other.vocabularyId == this.vocabularyId &&
          other.surfaceForm == this.surfaceForm &&
          other.contextSentence == this.contextSentence &&
          other.wordStart == this.wordStart &&
          other.wordEnd == this.wordEnd &&
          other.sourceBookId == this.sourceBookId &&
          other.sourceBookTitle == this.sourceBookTitle &&
          other.sourceChapterId == this.sourceChapterId &&
          other.sourceChapterTitle == this.sourceChapterTitle &&
          other.sourceOffset == this.sourceOffset &&
          other.createdAt == this.createdAt);
}

class WordOccurrencesCompanion extends UpdateCompanion<StoredWordOccurrence> {
  final Value<String> id;
  final Value<String> vocabularyId;
  final Value<String> surfaceForm;
  final Value<String> contextSentence;
  final Value<int> wordStart;
  final Value<int> wordEnd;
  final Value<String?> sourceBookId;
  final Value<String> sourceBookTitle;
  final Value<String?> sourceChapterId;
  final Value<String?> sourceChapterTitle;
  final Value<int?> sourceOffset;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WordOccurrencesCompanion({
    this.id = const Value.absent(),
    this.vocabularyId = const Value.absent(),
    this.surfaceForm = const Value.absent(),
    this.contextSentence = const Value.absent(),
    this.wordStart = const Value.absent(),
    this.wordEnd = const Value.absent(),
    this.sourceBookId = const Value.absent(),
    this.sourceBookTitle = const Value.absent(),
    this.sourceChapterId = const Value.absent(),
    this.sourceChapterTitle = const Value.absent(),
    this.sourceOffset = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordOccurrencesCompanion.insert({
    required String id,
    required String vocabularyId,
    required String surfaceForm,
    required String contextSentence,
    required int wordStart,
    required int wordEnd,
    this.sourceBookId = const Value.absent(),
    required String sourceBookTitle,
    this.sourceChapterId = const Value.absent(),
    this.sourceChapterTitle = const Value.absent(),
    this.sourceOffset = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vocabularyId = Value(vocabularyId),
       surfaceForm = Value(surfaceForm),
       contextSentence = Value(contextSentence),
       wordStart = Value(wordStart),
       wordEnd = Value(wordEnd),
       sourceBookTitle = Value(sourceBookTitle);
  static Insertable<StoredWordOccurrence> custom({
    Expression<String>? id,
    Expression<String>? vocabularyId,
    Expression<String>? surfaceForm,
    Expression<String>? contextSentence,
    Expression<int>? wordStart,
    Expression<int>? wordEnd,
    Expression<String>? sourceBookId,
    Expression<String>? sourceBookTitle,
    Expression<String>? sourceChapterId,
    Expression<String>? sourceChapterTitle,
    Expression<int>? sourceOffset,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vocabularyId != null) 'vocabulary_id': vocabularyId,
      if (surfaceForm != null) 'surface_form': surfaceForm,
      if (contextSentence != null) 'context_sentence': contextSentence,
      if (wordStart != null) 'word_start': wordStart,
      if (wordEnd != null) 'word_end': wordEnd,
      if (sourceBookId != null) 'source_book_id': sourceBookId,
      if (sourceBookTitle != null) 'source_book_title': sourceBookTitle,
      if (sourceChapterId != null) 'source_chapter_id': sourceChapterId,
      if (sourceChapterTitle != null)
        'source_chapter_title': sourceChapterTitle,
      if (sourceOffset != null) 'source_offset': sourceOffset,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordOccurrencesCompanion copyWith({
    Value<String>? id,
    Value<String>? vocabularyId,
    Value<String>? surfaceForm,
    Value<String>? contextSentence,
    Value<int>? wordStart,
    Value<int>? wordEnd,
    Value<String?>? sourceBookId,
    Value<String>? sourceBookTitle,
    Value<String?>? sourceChapterId,
    Value<String?>? sourceChapterTitle,
    Value<int?>? sourceOffset,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return WordOccurrencesCompanion(
      id: id ?? this.id,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      surfaceForm: surfaceForm ?? this.surfaceForm,
      contextSentence: contextSentence ?? this.contextSentence,
      wordStart: wordStart ?? this.wordStart,
      wordEnd: wordEnd ?? this.wordEnd,
      sourceBookId: sourceBookId ?? this.sourceBookId,
      sourceBookTitle: sourceBookTitle ?? this.sourceBookTitle,
      sourceChapterId: sourceChapterId ?? this.sourceChapterId,
      sourceChapterTitle: sourceChapterTitle ?? this.sourceChapterTitle,
      sourceOffset: sourceOffset ?? this.sourceOffset,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vocabularyId.present) {
      map['vocabulary_id'] = Variable<String>(vocabularyId.value);
    }
    if (surfaceForm.present) {
      map['surface_form'] = Variable<String>(surfaceForm.value);
    }
    if (contextSentence.present) {
      map['context_sentence'] = Variable<String>(contextSentence.value);
    }
    if (wordStart.present) {
      map['word_start'] = Variable<int>(wordStart.value);
    }
    if (wordEnd.present) {
      map['word_end'] = Variable<int>(wordEnd.value);
    }
    if (sourceBookId.present) {
      map['source_book_id'] = Variable<String>(sourceBookId.value);
    }
    if (sourceBookTitle.present) {
      map['source_book_title'] = Variable<String>(sourceBookTitle.value);
    }
    if (sourceChapterId.present) {
      map['source_chapter_id'] = Variable<String>(sourceChapterId.value);
    }
    if (sourceChapterTitle.present) {
      map['source_chapter_title'] = Variable<String>(sourceChapterTitle.value);
    }
    if (sourceOffset.present) {
      map['source_offset'] = Variable<int>(sourceOffset.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordOccurrencesCompanion(')
          ..write('id: $id, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('surfaceForm: $surfaceForm, ')
          ..write('contextSentence: $contextSentence, ')
          ..write('wordStart: $wordStart, ')
          ..write('wordEnd: $wordEnd, ')
          ..write('sourceBookId: $sourceBookId, ')
          ..write('sourceBookTitle: $sourceBookTitle, ')
          ..write('sourceChapterId: $sourceChapterId, ')
          ..write('sourceChapterTitle: $sourceChapterTitle, ')
          ..write('sourceOffset: $sourceOffset, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SrsCardsTable extends SrsCards
    with TableInfo<$SrsCardsTable, StoredSrsCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SrsCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vocabularyIdMeta = const VerificationMeta(
    'vocabularyId',
  );
  @override
  late final GeneratedColumn<String> vocabularyId = GeneratedColumn<String>(
    'vocabulary_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES vocabulary_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _algorithmMeta = const VerificationMeta(
    'algorithm',
  );
  @override
  late final GeneratedColumn<String> algorithm = GeneratedColumn<String>(
    'algorithm',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _algorithmVersionMeta = const VerificationMeta(
    'algorithmVersion',
  );
  @override
  late final GeneratedColumn<int> algorithmVersion = GeneratedColumn<int>(
    'algorithm_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateJsonMeta = const VerificationMeta(
    'stateJson',
  );
  @override
  late final GeneratedColumn<String> stateJson = GeneratedColumn<String>(
    'state_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _serverRevisionMeta = const VerificationMeta(
    'serverRevision',
  );
  @override
  late final GeneratedColumn<int> serverRevision = GeneratedColumn<int>(
    'server_revision',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vocabularyId,
    algorithm,
    algorithmVersion,
    stateJson,
    dueAt,
    lastReviewedAt,
    serverRevision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'srs_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredSrsCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vocabulary_id')) {
      context.handle(
        _vocabularyIdMeta,
        vocabularyId.isAcceptableOrUnknown(
          data['vocabulary_id']!,
          _vocabularyIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vocabularyIdMeta);
    }
    if (data.containsKey('algorithm')) {
      context.handle(
        _algorithmMeta,
        algorithm.isAcceptableOrUnknown(data['algorithm']!, _algorithmMeta),
      );
    } else if (isInserting) {
      context.missing(_algorithmMeta);
    }
    if (data.containsKey('algorithm_version')) {
      context.handle(
        _algorithmVersionMeta,
        algorithmVersion.isAcceptableOrUnknown(
          data['algorithm_version']!,
          _algorithmVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_algorithmVersionMeta);
    }
    if (data.containsKey('state_json')) {
      context.handle(
        _stateJsonMeta,
        stateJson.isAcceptableOrUnknown(data['state_json']!, _stateJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_stateJsonMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    if (data.containsKey('server_revision')) {
      context.handle(
        _serverRevisionMeta,
        serverRevision.isAcceptableOrUnknown(
          data['server_revision']!,
          _serverRevisionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredSrsCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredSrsCard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vocabularyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vocabulary_id'],
      )!,
      algorithm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}algorithm'],
      )!,
      algorithmVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}algorithm_version'],
      )!,
      stateJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_json'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      )!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
      serverRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_revision'],
      ),
    );
  }

  @override
  $SrsCardsTable createAlias(String alias) {
    return $SrsCardsTable(attachedDatabase, alias);
  }
}

class StoredSrsCard extends DataClass implements Insertable<StoredSrsCard> {
  final String id;
  final String vocabularyId;
  final String algorithm;
  final int algorithmVersion;
  final String stateJson;
  final DateTime dueAt;
  final DateTime? lastReviewedAt;
  final int? serverRevision;
  const StoredSrsCard({
    required this.id,
    required this.vocabularyId,
    required this.algorithm,
    required this.algorithmVersion,
    required this.stateJson,
    required this.dueAt,
    this.lastReviewedAt,
    this.serverRevision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vocabulary_id'] = Variable<String>(vocabularyId);
    map['algorithm'] = Variable<String>(algorithm);
    map['algorithm_version'] = Variable<int>(algorithmVersion);
    map['state_json'] = Variable<String>(stateJson);
    map['due_at'] = Variable<DateTime>(dueAt);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    if (!nullToAbsent || serverRevision != null) {
      map['server_revision'] = Variable<int>(serverRevision);
    }
    return map;
  }

  SrsCardsCompanion toCompanion(bool nullToAbsent) {
    return SrsCardsCompanion(
      id: Value(id),
      vocabularyId: Value(vocabularyId),
      algorithm: Value(algorithm),
      algorithmVersion: Value(algorithmVersion),
      stateJson: Value(stateJson),
      dueAt: Value(dueAt),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
      serverRevision: serverRevision == null && nullToAbsent
          ? const Value.absent()
          : Value(serverRevision),
    );
  }

  factory StoredSrsCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredSrsCard(
      id: serializer.fromJson<String>(json['id']),
      vocabularyId: serializer.fromJson<String>(json['vocabularyId']),
      algorithm: serializer.fromJson<String>(json['algorithm']),
      algorithmVersion: serializer.fromJson<int>(json['algorithmVersion']),
      stateJson: serializer.fromJson<String>(json['stateJson']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      serverRevision: serializer.fromJson<int?>(json['serverRevision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vocabularyId': serializer.toJson<String>(vocabularyId),
      'algorithm': serializer.toJson<String>(algorithm),
      'algorithmVersion': serializer.toJson<int>(algorithmVersion),
      'stateJson': serializer.toJson<String>(stateJson),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'serverRevision': serializer.toJson<int?>(serverRevision),
    };
  }

  StoredSrsCard copyWith({
    String? id,
    String? vocabularyId,
    String? algorithm,
    int? algorithmVersion,
    String? stateJson,
    DateTime? dueAt,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    Value<int?> serverRevision = const Value.absent(),
  }) => StoredSrsCard(
    id: id ?? this.id,
    vocabularyId: vocabularyId ?? this.vocabularyId,
    algorithm: algorithm ?? this.algorithm,
    algorithmVersion: algorithmVersion ?? this.algorithmVersion,
    stateJson: stateJson ?? this.stateJson,
    dueAt: dueAt ?? this.dueAt,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
    serverRevision: serverRevision.present
        ? serverRevision.value
        : this.serverRevision,
  );
  StoredSrsCard copyWithCompanion(SrsCardsCompanion data) {
    return StoredSrsCard(
      id: data.id.present ? data.id.value : this.id,
      vocabularyId: data.vocabularyId.present
          ? data.vocabularyId.value
          : this.vocabularyId,
      algorithm: data.algorithm.present ? data.algorithm.value : this.algorithm,
      algorithmVersion: data.algorithmVersion.present
          ? data.algorithmVersion.value
          : this.algorithmVersion,
      stateJson: data.stateJson.present ? data.stateJson.value : this.stateJson,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
      serverRevision: data.serverRevision.present
          ? data.serverRevision.value
          : this.serverRevision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredSrsCard(')
          ..write('id: $id, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('algorithm: $algorithm, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('stateJson: $stateJson, ')
          ..write('dueAt: $dueAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('serverRevision: $serverRevision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vocabularyId,
    algorithm,
    algorithmVersion,
    stateJson,
    dueAt,
    lastReviewedAt,
    serverRevision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredSrsCard &&
          other.id == this.id &&
          other.vocabularyId == this.vocabularyId &&
          other.algorithm == this.algorithm &&
          other.algorithmVersion == this.algorithmVersion &&
          other.stateJson == this.stateJson &&
          other.dueAt == this.dueAt &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.serverRevision == this.serverRevision);
}

class SrsCardsCompanion extends UpdateCompanion<StoredSrsCard> {
  final Value<String> id;
  final Value<String> vocabularyId;
  final Value<String> algorithm;
  final Value<int> algorithmVersion;
  final Value<String> stateJson;
  final Value<DateTime> dueAt;
  final Value<DateTime?> lastReviewedAt;
  final Value<int?> serverRevision;
  final Value<int> rowid;
  const SrsCardsCompanion({
    this.id = const Value.absent(),
    this.vocabularyId = const Value.absent(),
    this.algorithm = const Value.absent(),
    this.algorithmVersion = const Value.absent(),
    this.stateJson = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.serverRevision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SrsCardsCompanion.insert({
    required String id,
    required String vocabularyId,
    required String algorithm,
    required int algorithmVersion,
    required String stateJson,
    required DateTime dueAt,
    this.lastReviewedAt = const Value.absent(),
    this.serverRevision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vocabularyId = Value(vocabularyId),
       algorithm = Value(algorithm),
       algorithmVersion = Value(algorithmVersion),
       stateJson = Value(stateJson),
       dueAt = Value(dueAt);
  static Insertable<StoredSrsCard> custom({
    Expression<String>? id,
    Expression<String>? vocabularyId,
    Expression<String>? algorithm,
    Expression<int>? algorithmVersion,
    Expression<String>? stateJson,
    Expression<DateTime>? dueAt,
    Expression<DateTime>? lastReviewedAt,
    Expression<int>? serverRevision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vocabularyId != null) 'vocabulary_id': vocabularyId,
      if (algorithm != null) 'algorithm': algorithm,
      if (algorithmVersion != null) 'algorithm_version': algorithmVersion,
      if (stateJson != null) 'state_json': stateJson,
      if (dueAt != null) 'due_at': dueAt,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (serverRevision != null) 'server_revision': serverRevision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SrsCardsCompanion copyWith({
    Value<String>? id,
    Value<String>? vocabularyId,
    Value<String>? algorithm,
    Value<int>? algorithmVersion,
    Value<String>? stateJson,
    Value<DateTime>? dueAt,
    Value<DateTime?>? lastReviewedAt,
    Value<int?>? serverRevision,
    Value<int>? rowid,
  }) {
    return SrsCardsCompanion(
      id: id ?? this.id,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      algorithm: algorithm ?? this.algorithm,
      algorithmVersion: algorithmVersion ?? this.algorithmVersion,
      stateJson: stateJson ?? this.stateJson,
      dueAt: dueAt ?? this.dueAt,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      serverRevision: serverRevision ?? this.serverRevision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vocabularyId.present) {
      map['vocabulary_id'] = Variable<String>(vocabularyId.value);
    }
    if (algorithm.present) {
      map['algorithm'] = Variable<String>(algorithm.value);
    }
    if (algorithmVersion.present) {
      map['algorithm_version'] = Variable<int>(algorithmVersion.value);
    }
    if (stateJson.present) {
      map['state_json'] = Variable<String>(stateJson.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (serverRevision.present) {
      map['server_revision'] = Variable<int>(serverRevision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SrsCardsCompanion(')
          ..write('id: $id, ')
          ..write('vocabularyId: $vocabularyId, ')
          ..write('algorithm: $algorithm, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('stateJson: $stateJson, ')
          ..write('dueAt: $dueAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('serverRevision: $serverRevision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewEventsTable extends ReviewEvents
    with TableInfo<$ReviewEventsTable, StoredReviewEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES srs_cards (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateBeforeJsonMeta = const VerificationMeta(
    'stateBeforeJson',
  );
  @override
  late final GeneratedColumn<String> stateBeforeJson = GeneratedColumn<String>(
    'state_before_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateAfterJsonMeta = const VerificationMeta(
    'stateAfterJson',
  );
  @override
  late final GeneratedColumn<String> stateAfterJson = GeneratedColumn<String>(
    'state_after_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serverRevisionMeta = const VerificationMeta(
    'serverRevision',
  );
  @override
  late final GeneratedColumn<int> serverRevision = GeneratedColumn<int>(
    'server_revision',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    rating,
    reviewedAt,
    stateBeforeJson,
    stateAfterJson,
    durationMs,
    serverRevision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredReviewEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    if (data.containsKey('state_before_json')) {
      context.handle(
        _stateBeforeJsonMeta,
        stateBeforeJson.isAcceptableOrUnknown(
          data['state_before_json']!,
          _stateBeforeJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stateBeforeJsonMeta);
    }
    if (data.containsKey('state_after_json')) {
      context.handle(
        _stateAfterJsonMeta,
        stateAfterJson.isAcceptableOrUnknown(
          data['state_after_json']!,
          _stateAfterJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stateAfterJsonMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('server_revision')) {
      context.handle(
        _serverRevisionMeta,
        serverRevision.isAcceptableOrUnknown(
          data['server_revision']!,
          _serverRevisionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredReviewEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredReviewEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reviewed_at'],
      )!,
      stateBeforeJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_before_json'],
      )!,
      stateAfterJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_after_json'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      serverRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_revision'],
      ),
    );
  }

  @override
  $ReviewEventsTable createAlias(String alias) {
    return $ReviewEventsTable(attachedDatabase, alias);
  }
}

class StoredReviewEvent extends DataClass
    implements Insertable<StoredReviewEvent> {
  final String id;
  final String cardId;
  final int rating;
  final DateTime reviewedAt;
  final String stateBeforeJson;
  final String stateAfterJson;
  final int? durationMs;
  final int? serverRevision;
  const StoredReviewEvent({
    required this.id,
    required this.cardId,
    required this.rating,
    required this.reviewedAt,
    required this.stateBeforeJson,
    required this.stateAfterJson,
    this.durationMs,
    this.serverRevision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['card_id'] = Variable<String>(cardId);
    map['rating'] = Variable<int>(rating);
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    map['state_before_json'] = Variable<String>(stateBeforeJson);
    map['state_after_json'] = Variable<String>(stateAfterJson);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    if (!nullToAbsent || serverRevision != null) {
      map['server_revision'] = Variable<int>(serverRevision);
    }
    return map;
  }

  ReviewEventsCompanion toCompanion(bool nullToAbsent) {
    return ReviewEventsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      rating: Value(rating),
      reviewedAt: Value(reviewedAt),
      stateBeforeJson: Value(stateBeforeJson),
      stateAfterJson: Value(stateAfterJson),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      serverRevision: serverRevision == null && nullToAbsent
          ? const Value.absent()
          : Value(serverRevision),
    );
  }

  factory StoredReviewEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredReviewEvent(
      id: serializer.fromJson<String>(json['id']),
      cardId: serializer.fromJson<String>(json['cardId']),
      rating: serializer.fromJson<int>(json['rating']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
      stateBeforeJson: serializer.fromJson<String>(json['stateBeforeJson']),
      stateAfterJson: serializer.fromJson<String>(json['stateAfterJson']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      serverRevision: serializer.fromJson<int?>(json['serverRevision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cardId': serializer.toJson<String>(cardId),
      'rating': serializer.toJson<int>(rating),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
      'stateBeforeJson': serializer.toJson<String>(stateBeforeJson),
      'stateAfterJson': serializer.toJson<String>(stateAfterJson),
      'durationMs': serializer.toJson<int?>(durationMs),
      'serverRevision': serializer.toJson<int?>(serverRevision),
    };
  }

  StoredReviewEvent copyWith({
    String? id,
    String? cardId,
    int? rating,
    DateTime? reviewedAt,
    String? stateBeforeJson,
    String? stateAfterJson,
    Value<int?> durationMs = const Value.absent(),
    Value<int?> serverRevision = const Value.absent(),
  }) => StoredReviewEvent(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    rating: rating ?? this.rating,
    reviewedAt: reviewedAt ?? this.reviewedAt,
    stateBeforeJson: stateBeforeJson ?? this.stateBeforeJson,
    stateAfterJson: stateAfterJson ?? this.stateAfterJson,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    serverRevision: serverRevision.present
        ? serverRevision.value
        : this.serverRevision,
  );
  StoredReviewEvent copyWithCompanion(ReviewEventsCompanion data) {
    return StoredReviewEvent(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
      stateBeforeJson: data.stateBeforeJson.present
          ? data.stateBeforeJson.value
          : this.stateBeforeJson,
      stateAfterJson: data.stateAfterJson.present
          ? data.stateAfterJson.value
          : this.stateAfterJson,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      serverRevision: data.serverRevision.present
          ? data.serverRevision.value
          : this.serverRevision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredReviewEvent(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('rating: $rating, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('stateBeforeJson: $stateBeforeJson, ')
          ..write('stateAfterJson: $stateAfterJson, ')
          ..write('durationMs: $durationMs, ')
          ..write('serverRevision: $serverRevision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cardId,
    rating,
    reviewedAt,
    stateBeforeJson,
    stateAfterJson,
    durationMs,
    serverRevision,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredReviewEvent &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.rating == this.rating &&
          other.reviewedAt == this.reviewedAt &&
          other.stateBeforeJson == this.stateBeforeJson &&
          other.stateAfterJson == this.stateAfterJson &&
          other.durationMs == this.durationMs &&
          other.serverRevision == this.serverRevision);
}

class ReviewEventsCompanion extends UpdateCompanion<StoredReviewEvent> {
  final Value<String> id;
  final Value<String> cardId;
  final Value<int> rating;
  final Value<DateTime> reviewedAt;
  final Value<String> stateBeforeJson;
  final Value<String> stateAfterJson;
  final Value<int?> durationMs;
  final Value<int?> serverRevision;
  final Value<int> rowid;
  const ReviewEventsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.stateBeforeJson = const Value.absent(),
    this.stateAfterJson = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.serverRevision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewEventsCompanion.insert({
    required String id,
    required String cardId,
    required int rating,
    required DateTime reviewedAt,
    required String stateBeforeJson,
    required String stateAfterJson,
    this.durationMs = const Value.absent(),
    this.serverRevision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cardId = Value(cardId),
       rating = Value(rating),
       reviewedAt = Value(reviewedAt),
       stateBeforeJson = Value(stateBeforeJson),
       stateAfterJson = Value(stateAfterJson);
  static Insertable<StoredReviewEvent> custom({
    Expression<String>? id,
    Expression<String>? cardId,
    Expression<int>? rating,
    Expression<DateTime>? reviewedAt,
    Expression<String>? stateBeforeJson,
    Expression<String>? stateAfterJson,
    Expression<int>? durationMs,
    Expression<int>? serverRevision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (rating != null) 'rating': rating,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (stateBeforeJson != null) 'state_before_json': stateBeforeJson,
      if (stateAfterJson != null) 'state_after_json': stateAfterJson,
      if (durationMs != null) 'duration_ms': durationMs,
      if (serverRevision != null) 'server_revision': serverRevision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? cardId,
    Value<int>? rating,
    Value<DateTime>? reviewedAt,
    Value<String>? stateBeforeJson,
    Value<String>? stateAfterJson,
    Value<int?>? durationMs,
    Value<int?>? serverRevision,
    Value<int>? rowid,
  }) {
    return ReviewEventsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      rating: rating ?? this.rating,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      stateBeforeJson: stateBeforeJson ?? this.stateBeforeJson,
      stateAfterJson: stateAfterJson ?? this.stateAfterJson,
      durationMs: durationMs ?? this.durationMs,
      serverRevision: serverRevision ?? this.serverRevision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (stateBeforeJson.present) {
      map['state_before_json'] = Variable<String>(stateBeforeJson.value);
    }
    if (stateAfterJson.present) {
      map['state_after_json'] = Variable<String>(stateAfterJson.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (serverRevision.present) {
      map['server_revision'] = Variable<int>(serverRevision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewEventsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('rating: $rating, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('stateBeforeJson: $stateBeforeJson, ')
          ..write('stateAfterJson: $stateAfterJson, ')
          ..write('durationMs: $durationMs, ')
          ..write('serverRevision: $serverRevision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSettingsTable extends LocalSettings
    with TableInfo<$LocalSettingsTable, StoredSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueJsonMeta = const VerificationMeta(
    'valueJson',
  );
  @override
  late final GeneratedColumn<String> valueJson = GeneratedColumn<String>(
    'value_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverRevisionMeta = const VerificationMeta(
    'serverRevision',
  );
  @override
  late final GeneratedColumn<int> serverRevision = GeneratedColumn<int>(
    'server_revision',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    key,
    valueJson,
    updatedAt,
    serverRevision,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value_json')) {
      context.handle(
        _valueJsonMeta,
        valueJson.isAcceptableOrUnknown(data['value_json']!, _valueJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_valueJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('server_revision')) {
      context.handle(
        _serverRevisionMeta,
        serverRevision.isAcceptableOrUnknown(
          data['server_revision']!,
          _serverRevisionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  StoredSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      valueJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      serverRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_revision'],
      ),
    );
  }

  @override
  $LocalSettingsTable createAlias(String alias) {
    return $LocalSettingsTable(attachedDatabase, alias);
  }
}

class StoredSetting extends DataClass implements Insertable<StoredSetting> {
  final String key;
  final String valueJson;
  final DateTime updatedAt;
  final int? serverRevision;
  const StoredSetting({
    required this.key,
    required this.valueJson,
    required this.updatedAt,
    this.serverRevision,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value_json'] = Variable<String>(valueJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || serverRevision != null) {
      map['server_revision'] = Variable<int>(serverRevision);
    }
    return map;
  }

  LocalSettingsCompanion toCompanion(bool nullToAbsent) {
    return LocalSettingsCompanion(
      key: Value(key),
      valueJson: Value(valueJson),
      updatedAt: Value(updatedAt),
      serverRevision: serverRevision == null && nullToAbsent
          ? const Value.absent()
          : Value(serverRevision),
    );
  }

  factory StoredSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredSetting(
      key: serializer.fromJson<String>(json['key']),
      valueJson: serializer.fromJson<String>(json['valueJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      serverRevision: serializer.fromJson<int?>(json['serverRevision']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'valueJson': serializer.toJson<String>(valueJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'serverRevision': serializer.toJson<int?>(serverRevision),
    };
  }

  StoredSetting copyWith({
    String? key,
    String? valueJson,
    DateTime? updatedAt,
    Value<int?> serverRevision = const Value.absent(),
  }) => StoredSetting(
    key: key ?? this.key,
    valueJson: valueJson ?? this.valueJson,
    updatedAt: updatedAt ?? this.updatedAt,
    serverRevision: serverRevision.present
        ? serverRevision.value
        : this.serverRevision,
  );
  StoredSetting copyWithCompanion(LocalSettingsCompanion data) {
    return StoredSetting(
      key: data.key.present ? data.key.value : this.key,
      valueJson: data.valueJson.present ? data.valueJson.value : this.valueJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      serverRevision: data.serverRevision.present
          ? data.serverRevision.value
          : this.serverRevision,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredSetting(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serverRevision: $serverRevision')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, valueJson, updatedAt, serverRevision);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredSetting &&
          other.key == this.key &&
          other.valueJson == this.valueJson &&
          other.updatedAt == this.updatedAt &&
          other.serverRevision == this.serverRevision);
}

class LocalSettingsCompanion extends UpdateCompanion<StoredSetting> {
  final Value<String> key;
  final Value<String> valueJson;
  final Value<DateTime> updatedAt;
  final Value<int?> serverRevision;
  final Value<int> rowid;
  const LocalSettingsCompanion({
    this.key = const Value.absent(),
    this.valueJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.serverRevision = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSettingsCompanion.insert({
    required String key,
    required String valueJson,
    required DateTime updatedAt,
    this.serverRevision = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       valueJson = Value(valueJson),
       updatedAt = Value(updatedAt);
  static Insertable<StoredSetting> custom({
    Expression<String>? key,
    Expression<String>? valueJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? serverRevision,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (valueJson != null) 'value_json': valueJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (serverRevision != null) 'server_revision': serverRevision,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? valueJson,
    Value<DateTime>? updatedAt,
    Value<int?>? serverRevision,
    Value<int>? rowid,
  }) {
    return LocalSettingsCompanion(
      key: key ?? this.key,
      valueJson: valueJson ?? this.valueJson,
      updatedAt: updatedAt ?? this.updatedAt,
      serverRevision: serverRevision ?? this.serverRevision,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (valueJson.present) {
      map['value_json'] = Variable<String>(valueJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (serverRevision.present) {
      map['server_revision'] = Variable<int>(serverRevision.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSettingsCompanion(')
          ..write('key: $key, ')
          ..write('valueJson: $valueJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('serverRevision: $serverRevision, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TranslationCacheEntriesTable extends TranslationCacheEntries
    with TableInfo<$TranslationCacheEntriesTable, StoredTranslationCacheEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TranslationCacheEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cacheKeyMeta = const VerificationMeta(
    'cacheKey',
  );
  @override
  late final GeneratedColumn<String> cacheKey = GeneratedColumn<String>(
    'cache_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requestKindMeta = const VerificationMeta(
    'requestKind',
  );
  @override
  late final GeneratedColumn<String> requestKind = GeneratedColumn<String>(
    'request_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultJsonMeta = const VerificationMeta(
    'resultJson',
  );
  @override
  late final GeneratedColumn<String> resultJson = GeneratedColumn<String>(
    'result_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
    cacheKey,
    requestKind,
    resultJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'translation_cache_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredTranslationCacheEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cache_key')) {
      context.handle(
        _cacheKeyMeta,
        cacheKey.isAcceptableOrUnknown(data['cache_key']!, _cacheKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_cacheKeyMeta);
    }
    if (data.containsKey('request_kind')) {
      context.handle(
        _requestKindMeta,
        requestKind.isAcceptableOrUnknown(
          data['request_kind']!,
          _requestKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requestKindMeta);
    }
    if (data.containsKey('result_json')) {
      context.handle(
        _resultJsonMeta,
        resultJson.isAcceptableOrUnknown(data['result_json']!, _resultJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_resultJsonMeta);
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
  Set<GeneratedColumn> get $primaryKey => {cacheKey};
  @override
  StoredTranslationCacheEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredTranslationCacheEntry(
      cacheKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cache_key'],
      )!,
      requestKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}request_kind'],
      )!,
      resultJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TranslationCacheEntriesTable createAlias(String alias) {
    return $TranslationCacheEntriesTable(attachedDatabase, alias);
  }
}

class StoredTranslationCacheEntry extends DataClass
    implements Insertable<StoredTranslationCacheEntry> {
  final String cacheKey;
  final String requestKind;
  final String resultJson;
  final DateTime createdAt;
  const StoredTranslationCacheEntry({
    required this.cacheKey,
    required this.requestKind,
    required this.resultJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cache_key'] = Variable<String>(cacheKey);
    map['request_kind'] = Variable<String>(requestKind);
    map['result_json'] = Variable<String>(resultJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TranslationCacheEntriesCompanion toCompanion(bool nullToAbsent) {
    return TranslationCacheEntriesCompanion(
      cacheKey: Value(cacheKey),
      requestKind: Value(requestKind),
      resultJson: Value(resultJson),
      createdAt: Value(createdAt),
    );
  }

  factory StoredTranslationCacheEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredTranslationCacheEntry(
      cacheKey: serializer.fromJson<String>(json['cacheKey']),
      requestKind: serializer.fromJson<String>(json['requestKind']),
      resultJson: serializer.fromJson<String>(json['resultJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cacheKey': serializer.toJson<String>(cacheKey),
      'requestKind': serializer.toJson<String>(requestKind),
      'resultJson': serializer.toJson<String>(resultJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StoredTranslationCacheEntry copyWith({
    String? cacheKey,
    String? requestKind,
    String? resultJson,
    DateTime? createdAt,
  }) => StoredTranslationCacheEntry(
    cacheKey: cacheKey ?? this.cacheKey,
    requestKind: requestKind ?? this.requestKind,
    resultJson: resultJson ?? this.resultJson,
    createdAt: createdAt ?? this.createdAt,
  );
  StoredTranslationCacheEntry copyWithCompanion(
    TranslationCacheEntriesCompanion data,
  ) {
    return StoredTranslationCacheEntry(
      cacheKey: data.cacheKey.present ? data.cacheKey.value : this.cacheKey,
      requestKind: data.requestKind.present
          ? data.requestKind.value
          : this.requestKind,
      resultJson: data.resultJson.present
          ? data.resultJson.value
          : this.resultJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredTranslationCacheEntry(')
          ..write('cacheKey: $cacheKey, ')
          ..write('requestKind: $requestKind, ')
          ..write('resultJson: $resultJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cacheKey, requestKind, resultJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredTranslationCacheEntry &&
          other.cacheKey == this.cacheKey &&
          other.requestKind == this.requestKind &&
          other.resultJson == this.resultJson &&
          other.createdAt == this.createdAt);
}

class TranslationCacheEntriesCompanion
    extends UpdateCompanion<StoredTranslationCacheEntry> {
  final Value<String> cacheKey;
  final Value<String> requestKind;
  final Value<String> resultJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TranslationCacheEntriesCompanion({
    this.cacheKey = const Value.absent(),
    this.requestKind = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TranslationCacheEntriesCompanion.insert({
    required String cacheKey,
    required String requestKind,
    required String resultJson,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : cacheKey = Value(cacheKey),
       requestKind = Value(requestKind),
       resultJson = Value(resultJson);
  static Insertable<StoredTranslationCacheEntry> custom({
    Expression<String>? cacheKey,
    Expression<String>? requestKind,
    Expression<String>? resultJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cacheKey != null) 'cache_key': cacheKey,
      if (requestKind != null) 'request_kind': requestKind,
      if (resultJson != null) 'result_json': resultJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TranslationCacheEntriesCompanion copyWith({
    Value<String>? cacheKey,
    Value<String>? requestKind,
    Value<String>? resultJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TranslationCacheEntriesCompanion(
      cacheKey: cacheKey ?? this.cacheKey,
      requestKind: requestKind ?? this.requestKind,
      resultJson: resultJson ?? this.resultJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cacheKey.present) {
      map['cache_key'] = Variable<String>(cacheKey.value);
    }
    if (requestKind.present) {
      map['request_kind'] = Variable<String>(requestKind.value);
    }
    if (resultJson.present) {
      map['result_json'] = Variable<String>(resultJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TranslationCacheEntriesCompanion(')
          ..write('cacheKey: $cacheKey, ')
          ..write('requestKind: $requestKind, ')
          ..write('resultJson: $resultJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncOutboxEntriesTable extends SyncOutboxEntries
    with TableInfo<$SyncOutboxEntriesTable, StoredSyncOutboxEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncOutboxEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _mutationIdMeta = const VerificationMeta(
    'mutationId',
  );
  @override
  late final GeneratedColumn<String> mutationId = GeneratedColumn<String>(
    'mutation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _nextAttemptAtMeta = const VerificationMeta(
    'nextAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextAttemptAt =
      GeneratedColumn<DateTime>(
        'next_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    mutationId,
    entityType,
    entityId,
    operation,
    payloadJson,
    attempts,
    createdAt,
    nextAttemptAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_outbox_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredSyncOutboxEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('mutation_id')) {
      context.handle(
        _mutationIdMeta,
        mutationId.isAcceptableOrUnknown(data['mutation_id']!, _mutationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mutationIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('next_attempt_at')) {
      context.handle(
        _nextAttemptAtMeta,
        nextAttemptAt.isAcceptableOrUnknown(
          data['next_attempt_at']!,
          _nextAttemptAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {mutationId};
  @override
  StoredSyncOutboxEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredSyncOutboxEntry(
      mutationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mutation_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      nextAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_attempt_at'],
      ),
    );
  }

  @override
  $SyncOutboxEntriesTable createAlias(String alias) {
    return $SyncOutboxEntriesTable(attachedDatabase, alias);
  }
}

class StoredSyncOutboxEntry extends DataClass
    implements Insertable<StoredSyncOutboxEntry> {
  final String mutationId;
  final String entityType;
  final String entityId;
  final String operation;
  final String payloadJson;
  final int attempts;
  final DateTime createdAt;
  final DateTime? nextAttemptAt;
  const StoredSyncOutboxEntry({
    required this.mutationId,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payloadJson,
    required this.attempts,
    required this.createdAt,
    this.nextAttemptAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['mutation_id'] = Variable<String>(mutationId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['attempts'] = Variable<int>(attempts);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || nextAttemptAt != null) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt);
    }
    return map;
  }

  SyncOutboxEntriesCompanion toCompanion(bool nullToAbsent) {
    return SyncOutboxEntriesCompanion(
      mutationId: Value(mutationId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      attempts: Value(attempts),
      createdAt: Value(createdAt),
      nextAttemptAt: nextAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextAttemptAt),
    );
  }

  factory StoredSyncOutboxEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredSyncOutboxEntry(
      mutationId: serializer.fromJson<String>(json['mutationId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      attempts: serializer.fromJson<int>(json['attempts']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      nextAttemptAt: serializer.fromJson<DateTime?>(json['nextAttemptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'mutationId': serializer.toJson<String>(mutationId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'attempts': serializer.toJson<int>(attempts),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'nextAttemptAt': serializer.toJson<DateTime?>(nextAttemptAt),
    };
  }

  StoredSyncOutboxEntry copyWith({
    String? mutationId,
    String? entityType,
    String? entityId,
    String? operation,
    String? payloadJson,
    int? attempts,
    DateTime? createdAt,
    Value<DateTime?> nextAttemptAt = const Value.absent(),
  }) => StoredSyncOutboxEntry(
    mutationId: mutationId ?? this.mutationId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    attempts: attempts ?? this.attempts,
    createdAt: createdAt ?? this.createdAt,
    nextAttemptAt: nextAttemptAt.present
        ? nextAttemptAt.value
        : this.nextAttemptAt,
  );
  StoredSyncOutboxEntry copyWithCompanion(SyncOutboxEntriesCompanion data) {
    return StoredSyncOutboxEntry(
      mutationId: data.mutationId.present
          ? data.mutationId.value
          : this.mutationId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      nextAttemptAt: data.nextAttemptAt.present
          ? data.nextAttemptAt.value
          : this.nextAttemptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredSyncOutboxEntry(')
          ..write('mutationId: $mutationId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('attempts: $attempts, ')
          ..write('createdAt: $createdAt, ')
          ..write('nextAttemptAt: $nextAttemptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    mutationId,
    entityType,
    entityId,
    operation,
    payloadJson,
    attempts,
    createdAt,
    nextAttemptAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredSyncOutboxEntry &&
          other.mutationId == this.mutationId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.attempts == this.attempts &&
          other.createdAt == this.createdAt &&
          other.nextAttemptAt == this.nextAttemptAt);
}

class SyncOutboxEntriesCompanion
    extends UpdateCompanion<StoredSyncOutboxEntry> {
  final Value<String> mutationId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<int> attempts;
  final Value<DateTime> createdAt;
  final Value<DateTime?> nextAttemptAt;
  final Value<int> rowid;
  const SyncOutboxEntriesCompanion({
    this.mutationId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.attempts = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncOutboxEntriesCompanion.insert({
    required String mutationId,
    required String entityType,
    required String entityId,
    required String operation,
    required String payloadJson,
    this.attempts = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.nextAttemptAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : mutationId = Value(mutationId),
       entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       payloadJson = Value(payloadJson);
  static Insertable<StoredSyncOutboxEntry> custom({
    Expression<String>? mutationId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<int>? attempts,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? nextAttemptAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (mutationId != null) 'mutation_id': mutationId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (attempts != null) 'attempts': attempts,
      if (createdAt != null) 'created_at': createdAt,
      if (nextAttemptAt != null) 'next_attempt_at': nextAttemptAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncOutboxEntriesCompanion copyWith({
    Value<String>? mutationId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<int>? attempts,
    Value<DateTime>? createdAt,
    Value<DateTime?>? nextAttemptAt,
    Value<int>? rowid,
  }) {
    return SyncOutboxEntriesCompanion(
      mutationId: mutationId ?? this.mutationId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      attempts: attempts ?? this.attempts,
      createdAt: createdAt ?? this.createdAt,
      nextAttemptAt: nextAttemptAt ?? this.nextAttemptAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (mutationId.present) {
      map['mutation_id'] = Variable<String>(mutationId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (nextAttemptAt.present) {
      map['next_attempt_at'] = Variable<DateTime>(nextAttemptAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncOutboxEntriesCompanion(')
          ..write('mutationId: $mutationId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('attempts: $attempts, ')
          ..write('createdAt: $createdAt, ')
          ..write('nextAttemptAt: $nextAttemptAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncStatesTable extends SyncStates
    with TableInfo<$SyncStatesTable, StoredSyncState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverCursorMeta = const VerificationMeta(
    'serverCursor',
  );
  @override
  late final GeneratedColumn<int> serverCursor = GeneratedColumn<int>(
    'server_cursor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastSuccessfulSyncAtMeta =
      const VerificationMeta('lastSuccessfulSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSuccessfulSyncAt =
      GeneratedColumn<DateTime>(
        'last_successful_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    serverCursor,
    lastSuccessfulSyncAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredSyncState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('server_cursor')) {
      context.handle(
        _serverCursorMeta,
        serverCursor.isAcceptableOrUnknown(
          data['server_cursor']!,
          _serverCursorMeta,
        ),
      );
    }
    if (data.containsKey('last_successful_sync_at')) {
      context.handle(
        _lastSuccessfulSyncAtMeta,
        lastSuccessfulSyncAt.isAcceptableOrUnknown(
          data['last_successful_sync_at']!,
          _lastSuccessfulSyncAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  StoredSyncState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredSyncState(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      serverCursor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}server_cursor'],
      )!,
      lastSuccessfulSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_successful_sync_at'],
      ),
    );
  }

  @override
  $SyncStatesTable createAlias(String alias) {
    return $SyncStatesTable(attachedDatabase, alias);
  }
}

class StoredSyncState extends DataClass implements Insertable<StoredSyncState> {
  final String accountId;
  final int serverCursor;
  final DateTime? lastSuccessfulSyncAt;
  const StoredSyncState({
    required this.accountId,
    required this.serverCursor,
    this.lastSuccessfulSyncAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<String>(accountId);
    map['server_cursor'] = Variable<int>(serverCursor);
    if (!nullToAbsent || lastSuccessfulSyncAt != null) {
      map['last_successful_sync_at'] = Variable<DateTime>(lastSuccessfulSyncAt);
    }
    return map;
  }

  SyncStatesCompanion toCompanion(bool nullToAbsent) {
    return SyncStatesCompanion(
      accountId: Value(accountId),
      serverCursor: Value(serverCursor),
      lastSuccessfulSyncAt: lastSuccessfulSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessfulSyncAt),
    );
  }

  factory StoredSyncState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredSyncState(
      accountId: serializer.fromJson<String>(json['accountId']),
      serverCursor: serializer.fromJson<int>(json['serverCursor']),
      lastSuccessfulSyncAt: serializer.fromJson<DateTime?>(
        json['lastSuccessfulSyncAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<String>(accountId),
      'serverCursor': serializer.toJson<int>(serverCursor),
      'lastSuccessfulSyncAt': serializer.toJson<DateTime?>(
        lastSuccessfulSyncAt,
      ),
    };
  }

  StoredSyncState copyWith({
    String? accountId,
    int? serverCursor,
    Value<DateTime?> lastSuccessfulSyncAt = const Value.absent(),
  }) => StoredSyncState(
    accountId: accountId ?? this.accountId,
    serverCursor: serverCursor ?? this.serverCursor,
    lastSuccessfulSyncAt: lastSuccessfulSyncAt.present
        ? lastSuccessfulSyncAt.value
        : this.lastSuccessfulSyncAt,
  );
  StoredSyncState copyWithCompanion(SyncStatesCompanion data) {
    return StoredSyncState(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      serverCursor: data.serverCursor.present
          ? data.serverCursor.value
          : this.serverCursor,
      lastSuccessfulSyncAt: data.lastSuccessfulSyncAt.present
          ? data.lastSuccessfulSyncAt.value
          : this.lastSuccessfulSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredSyncState(')
          ..write('accountId: $accountId, ')
          ..write('serverCursor: $serverCursor, ')
          ..write('lastSuccessfulSyncAt: $lastSuccessfulSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(accountId, serverCursor, lastSuccessfulSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredSyncState &&
          other.accountId == this.accountId &&
          other.serverCursor == this.serverCursor &&
          other.lastSuccessfulSyncAt == this.lastSuccessfulSyncAt);
}

class SyncStatesCompanion extends UpdateCompanion<StoredSyncState> {
  final Value<String> accountId;
  final Value<int> serverCursor;
  final Value<DateTime?> lastSuccessfulSyncAt;
  final Value<int> rowid;
  const SyncStatesCompanion({
    this.accountId = const Value.absent(),
    this.serverCursor = const Value.absent(),
    this.lastSuccessfulSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncStatesCompanion.insert({
    required String accountId,
    this.serverCursor = const Value.absent(),
    this.lastSuccessfulSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : accountId = Value(accountId);
  static Insertable<StoredSyncState> custom({
    Expression<String>? accountId,
    Expression<int>? serverCursor,
    Expression<DateTime>? lastSuccessfulSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (serverCursor != null) 'server_cursor': serverCursor,
      if (lastSuccessfulSyncAt != null)
        'last_successful_sync_at': lastSuccessfulSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncStatesCompanion copyWith({
    Value<String>? accountId,
    Value<int>? serverCursor,
    Value<DateTime?>? lastSuccessfulSyncAt,
    Value<int>? rowid,
  }) {
    return SyncStatesCompanion(
      accountId: accountId ?? this.accountId,
      serverCursor: serverCursor ?? this.serverCursor,
      lastSuccessfulSyncAt: lastSuccessfulSyncAt ?? this.lastSuccessfulSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (serverCursor.present) {
      map['server_cursor'] = Variable<int>(serverCursor.value);
    }
    if (lastSuccessfulSyncAt.present) {
      map['last_successful_sync_at'] = Variable<DateTime>(
        lastSuccessfulSyncAt.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncStatesCompanion(')
          ..write('accountId: $accountId, ')
          ..write('serverCursor: $serverCursor, ')
          ..write('lastSuccessfulSyncAt: $lastSuccessfulSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  late final $ContentBlocksTable contentBlocks = $ContentBlocksTable(this);
  late final $TocEntriesTable tocEntries = $TocEntriesTable(this);
  late final $PaginationProfilesTable paginationProfiles =
      $PaginationProfilesTable(this);
  late final $BookPagesTable bookPages = $BookPagesTable(this);
  late final $ReaderPositionsTable readerPositions = $ReaderPositionsTable(
    this,
  );
  late final $VocabularyItemsTable vocabularyItems = $VocabularyItemsTable(
    this,
  );
  late final $WordOccurrencesTable wordOccurrences = $WordOccurrencesTable(
    this,
  );
  late final $SrsCardsTable srsCards = $SrsCardsTable(this);
  late final $ReviewEventsTable reviewEvents = $ReviewEventsTable(this);
  late final $LocalSettingsTable localSettings = $LocalSettingsTable(this);
  late final $TranslationCacheEntriesTable translationCacheEntries =
      $TranslationCacheEntriesTable(this);
  late final $SyncOutboxEntriesTable syncOutboxEntries =
      $SyncOutboxEntriesTable(this);
  late final $SyncStatesTable syncStates = $SyncStatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    books,
    chapters,
    contentBlocks,
    tocEntries,
    paginationProfiles,
    bookPages,
    readerPositions,
    vocabularyItems,
    wordOccurrences,
    srsCards,
    reviewEvents,
    localSettings,
    translationCacheEntries,
    syncOutboxEntries,
    syncStates,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('chapters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chapters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('content_blocks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('toc_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pagination_profiles', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pagination_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('book_pages', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'chapters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('book_pages', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vocabulary_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('word_occurrences', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vocabulary_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('srs_cards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'srs_cards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_events', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$BooksTableCreateCompanionBuilder =
    BooksCompanion Function({
      required String id,
      Value<String?> syncKey,
      required String format,
      required String title,
      Value<String?> author,
      required String language,
      Value<String?> filePath,
      Value<String?> coverPath,
      required String contentHash,
      required int totalLength,
      required DateTime lastOpenedAt,
      Value<DateTime> createdAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$BooksTableUpdateCompanionBuilder =
    BooksCompanion Function({
      Value<String> id,
      Value<String?> syncKey,
      Value<String> format,
      Value<String> title,
      Value<String?> author,
      Value<String> language,
      Value<String?> filePath,
      Value<String?> coverPath,
      Value<String> contentHash,
      Value<int> totalLength,
      Value<DateTime> lastOpenedAt,
      Value<DateTime> createdAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

final class $$BooksTableReferences
    extends BaseReferences<_$AppDatabase, $BooksTable, StoredBook> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChaptersTable, List<StoredChapter>>
  _chaptersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chapters,
    aliasName: 'books__id__chapters__book_id',
  );

  $$ChaptersTableProcessedTableManager get chaptersRefs {
    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_chaptersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TocEntriesTable, List<StoredTocEntry>>
  _tocEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.tocEntries,
    aliasName: 'books__id__toc_entries__book_id',
  );

  $$TocEntriesTableProcessedTableManager get tocEntriesRefs {
    final manager = $$TocEntriesTableTableManager(
      $_db,
      $_db.tocEntries,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tocEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PaginationProfilesTable,
    List<StoredPaginationProfile>
  >
  _paginationProfilesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.paginationProfiles,
        aliasName: 'books__id__pagination_profiles__book_id',
      );

  $$PaginationProfilesTableProcessedTableManager get paginationProfilesRefs {
    final manager = $$PaginationProfilesTableTableManager(
      $_db,
      $_db.paginationProfiles,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _paginationProfilesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncKey => $composableBuilder(
    column: $table.syncKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLength => $composableBuilder(
    column: $table.totalLength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> chaptersRefs(
    Expression<bool> Function($$ChaptersTableFilterComposer f) f,
  ) {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tocEntriesRefs(
    Expression<bool> Function($$TocEntriesTableFilterComposer f) f,
  ) {
    final $$TocEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tocEntries,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TocEntriesTableFilterComposer(
            $db: $db,
            $table: $db.tocEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paginationProfilesRefs(
    Expression<bool> Function($$PaginationProfilesTableFilterComposer f) f,
  ) {
    final $$PaginationProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.paginationProfiles,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaginationProfilesTableFilterComposer(
            $db: $db,
            $table: $db.paginationProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncKey => $composableBuilder(
    column: $table.syncKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLength => $composableBuilder(
    column: $table.totalLength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncKey =>
      $composableBuilder(column: $table.syncKey, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get coverPath =>
      $composableBuilder(column: $table.coverPath, builder: (column) => column);

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalLength => $composableBuilder(
    column: $table.totalLength,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> chaptersRefs<T extends Object>(
    Expression<T> Function($$ChaptersTableAnnotationComposer a) f,
  ) {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tocEntriesRefs<T extends Object>(
    Expression<T> Function($$TocEntriesTableAnnotationComposer a) f,
  ) {
    final $$TocEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tocEntries,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TocEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.tocEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paginationProfilesRefs<T extends Object>(
    Expression<T> Function($$PaginationProfilesTableAnnotationComposer a) f,
  ) {
    final $$PaginationProfilesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.paginationProfiles,
          getReferencedColumn: (t) => t.bookId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaginationProfilesTableAnnotationComposer(
                $db: $db,
                $table: $db.paginationProfiles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          StoredBook,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (StoredBook, $$BooksTableReferences),
          StoredBook,
          PrefetchHooks Function({
            bool chaptersRefs,
            bool tocEntriesRefs,
            bool paginationProfilesRefs,
          })
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> syncKey = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
                Value<String?> coverPath = const Value.absent(),
                Value<String> contentHash = const Value.absent(),
                Value<int> totalLength = const Value.absent(),
                Value<DateTime> lastOpenedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                syncKey: syncKey,
                format: format,
                title: title,
                author: author,
                language: language,
                filePath: filePath,
                coverPath: coverPath,
                contentHash: contentHash,
                totalLength: totalLength,
                lastOpenedAt: lastOpenedAt,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> syncKey = const Value.absent(),
                required String format,
                required String title,
                Value<String?> author = const Value.absent(),
                required String language,
                Value<String?> filePath = const Value.absent(),
                Value<String?> coverPath = const Value.absent(),
                required String contentHash,
                required int totalLength,
                required DateTime lastOpenedAt,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BooksCompanion.insert(
                id: id,
                syncKey: syncKey,
                format: format,
                title: title,
                author: author,
                language: language,
                filePath: filePath,
                coverPath: coverPath,
                contentHash: contentHash,
                totalLength: totalLength,
                lastOpenedAt: lastOpenedAt,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BooksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                chaptersRefs = false,
                tocEntriesRefs = false,
                paginationProfilesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (chaptersRefs) db.chapters,
                    if (tocEntriesRefs) db.tocEntries,
                    if (paginationProfilesRefs) db.paginationProfiles,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (chaptersRefs)
                        await $_getPrefetchedData<
                          StoredBook,
                          $BooksTable,
                          StoredChapter
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._chaptersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).chaptersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tocEntriesRefs)
                        await $_getPrefetchedData<
                          StoredBook,
                          $BooksTable,
                          StoredTocEntry
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._tocEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).tocEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paginationProfilesRefs)
                        await $_getPrefetchedData<
                          StoredBook,
                          $BooksTable,
                          StoredPaginationProfile
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._paginationProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).paginationProfilesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      StoredBook,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (StoredBook, $$BooksTableReferences),
      StoredBook,
      PrefetchHooks Function({
        bool chaptersRefs,
        bool tocEntriesRefs,
        bool paginationProfilesRefs,
      })
    >;
typedef $$ChaptersTableCreateCompanionBuilder =
    ChaptersCompanion Function({
      required String id,
      required String bookId,
      required int ordinal,
      Value<String?> title,
      Value<String?> href,
      required String plainText,
      required int lengthUtf16,
      Value<int> rowid,
    });
typedef $$ChaptersTableUpdateCompanionBuilder =
    ChaptersCompanion Function({
      Value<String> id,
      Value<String> bookId,
      Value<int> ordinal,
      Value<String?> title,
      Value<String?> href,
      Value<String> plainText,
      Value<int> lengthUtf16,
      Value<int> rowid,
    });

final class $$ChaptersTableReferences
    extends BaseReferences<_$AppDatabase, $ChaptersTable, StoredChapter> {
  $$ChaptersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) =>
      db.books.createAlias('chapters__book_id__books__id');

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ContentBlocksTable, List<StoredContentBlock>>
  _contentBlocksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contentBlocks,
    aliasName: 'chapters__id__content_blocks__chapter_id',
  );

  $$ContentBlocksTableProcessedTableManager get contentBlocksRefs {
    final manager = $$ContentBlocksTableTableManager(
      $_db,
      $_db.contentBlocks,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contentBlocksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BookPagesTable, List<StoredPage>>
  _bookPagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookPages,
    aliasName: 'chapters__id__book_pages__chapter_id',
  );

  $$BookPagesTableProcessedTableManager get bookPagesRefs {
    final manager = $$BookPagesTableTableManager(
      $_db,
      $_db.bookPages,
    ).filter((f) => f.chapterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookPagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChaptersTableFilterComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get href => $composableBuilder(
    column: $table.href,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plainText => $composableBuilder(
    column: $table.plainText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lengthUtf16 => $composableBuilder(
    column: $table.lengthUtf16,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> contentBlocksRefs(
    Expression<bool> Function($$ContentBlocksTableFilterComposer f) f,
  ) {
    final $$ContentBlocksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contentBlocks,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentBlocksTableFilterComposer(
            $db: $db,
            $table: $db.contentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bookPagesRefs(
    Expression<bool> Function($$BookPagesTableFilterComposer f) f,
  ) {
    final $$BookPagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookPages,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookPagesTableFilterComposer(
            $db: $db,
            $table: $db.bookPages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableOrderingComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get href => $composableBuilder(
    column: $table.href,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plainText => $composableBuilder(
    column: $table.plainText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lengthUtf16 => $composableBuilder(
    column: $table.lengthUtf16,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChaptersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChaptersTable> {
  $$ChaptersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get href =>
      $composableBuilder(column: $table.href, builder: (column) => column);

  GeneratedColumn<String> get plainText =>
      $composableBuilder(column: $table.plainText, builder: (column) => column);

  GeneratedColumn<int> get lengthUtf16 => $composableBuilder(
    column: $table.lengthUtf16,
    builder: (column) => column,
  );

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> contentBlocksRefs<T extends Object>(
    Expression<T> Function($$ContentBlocksTableAnnotationComposer a) f,
  ) {
    final $$ContentBlocksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contentBlocks,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentBlocksTableAnnotationComposer(
            $db: $db,
            $table: $db.contentBlocks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bookPagesRefs<T extends Object>(
    Expression<T> Function($$BookPagesTableAnnotationComposer a) f,
  ) {
    final $$BookPagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookPages,
      getReferencedColumn: (t) => t.chapterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookPagesTableAnnotationComposer(
            $db: $db,
            $table: $db.bookPages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChaptersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChaptersTable,
          StoredChapter,
          $$ChaptersTableFilterComposer,
          $$ChaptersTableOrderingComposer,
          $$ChaptersTableAnnotationComposer,
          $$ChaptersTableCreateCompanionBuilder,
          $$ChaptersTableUpdateCompanionBuilder,
          (StoredChapter, $$ChaptersTableReferences),
          StoredChapter,
          PrefetchHooks Function({
            bool bookId,
            bool contentBlocksRefs,
            bool bookPagesRefs,
          })
        > {
  $$ChaptersTableTableManager(_$AppDatabase db, $ChaptersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChaptersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChaptersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChaptersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> href = const Value.absent(),
                Value<String> plainText = const Value.absent(),
                Value<int> lengthUtf16 = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChaptersCompanion(
                id: id,
                bookId: bookId,
                ordinal: ordinal,
                title: title,
                href: href,
                plainText: plainText,
                lengthUtf16: lengthUtf16,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bookId,
                required int ordinal,
                Value<String?> title = const Value.absent(),
                Value<String?> href = const Value.absent(),
                required String plainText,
                required int lengthUtf16,
                Value<int> rowid = const Value.absent(),
              }) => ChaptersCompanion.insert(
                id: id,
                bookId: bookId,
                ordinal: ordinal,
                title: title,
                href: href,
                plainText: plainText,
                lengthUtf16: lengthUtf16,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChaptersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                bookId = false,
                contentBlocksRefs = false,
                bookPagesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (contentBlocksRefs) db.contentBlocks,
                    if (bookPagesRefs) db.bookPages,
                  ],
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
                        if (bookId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.bookId,
                                    referencedTable: $$ChaptersTableReferences
                                        ._bookIdTable(db),
                                    referencedColumn: $$ChaptersTableReferences
                                        ._bookIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (contentBlocksRefs)
                        await $_getPrefetchedData<
                          StoredChapter,
                          $ChaptersTable,
                          StoredContentBlock
                        >(
                          currentTable: table,
                          referencedTable: $$ChaptersTableReferences
                              ._contentBlocksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChaptersTableReferences(
                                db,
                                table,
                                p0,
                              ).contentBlocksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chapterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bookPagesRefs)
                        await $_getPrefetchedData<
                          StoredChapter,
                          $ChaptersTable,
                          StoredPage
                        >(
                          currentTable: table,
                          referencedTable: $$ChaptersTableReferences
                              ._bookPagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChaptersTableReferences(
                                db,
                                table,
                                p0,
                              ).bookPagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.chapterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ChaptersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChaptersTable,
      StoredChapter,
      $$ChaptersTableFilterComposer,
      $$ChaptersTableOrderingComposer,
      $$ChaptersTableAnnotationComposer,
      $$ChaptersTableCreateCompanionBuilder,
      $$ChaptersTableUpdateCompanionBuilder,
      (StoredChapter, $$ChaptersTableReferences),
      StoredChapter,
      PrefetchHooks Function({
        bool bookId,
        bool contentBlocksRefs,
        bool bookPagesRefs,
      })
    >;
typedef $$ContentBlocksTableCreateCompanionBuilder =
    ContentBlocksCompanion Function({
      required String id,
      required String chapterId,
      required int ordinal,
      required String kind,
      required String textContent,
      required int startOffset,
      required int endOffset,
      Value<String> inlineSpansJson,
      Value<String?> resourcePath,
      Value<String?> altText,
      Value<int> rowid,
    });
typedef $$ContentBlocksTableUpdateCompanionBuilder =
    ContentBlocksCompanion Function({
      Value<String> id,
      Value<String> chapterId,
      Value<int> ordinal,
      Value<String> kind,
      Value<String> textContent,
      Value<int> startOffset,
      Value<int> endOffset,
      Value<String> inlineSpansJson,
      Value<String?> resourcePath,
      Value<String?> altText,
      Value<int> rowid,
    });

final class $$ContentBlocksTableReferences
    extends
        BaseReferences<_$AppDatabase, $ContentBlocksTable, StoredContentBlock> {
  $$ContentBlocksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias('content_blocks__chapter_id__chapters__id');

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContentBlocksTableFilterComposer
    extends Composer<_$AppDatabase, $ContentBlocksTable> {
  $$ContentBlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inlineSpansJson => $composableBuilder(
    column: $table.inlineSpansJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resourcePath => $composableBuilder(
    column: $table.resourcePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get altText => $composableBuilder(
    column: $table.altText,
    builder: (column) => ColumnFilters(column),
  );

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentBlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentBlocksTable> {
  $$ContentBlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inlineSpansJson => $composableBuilder(
    column: $table.inlineSpansJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resourcePath => $composableBuilder(
    column: $table.resourcePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get altText => $composableBuilder(
    column: $table.altText,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentBlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentBlocksTable> {
  $$ContentBlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endOffset =>
      $composableBuilder(column: $table.endOffset, builder: (column) => column);

  GeneratedColumn<String> get inlineSpansJson => $composableBuilder(
    column: $table.inlineSpansJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resourcePath => $composableBuilder(
    column: $table.resourcePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get altText =>
      $composableBuilder(column: $table.altText, builder: (column) => column);

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContentBlocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContentBlocksTable,
          StoredContentBlock,
          $$ContentBlocksTableFilterComposer,
          $$ContentBlocksTableOrderingComposer,
          $$ContentBlocksTableAnnotationComposer,
          $$ContentBlocksTableCreateCompanionBuilder,
          $$ContentBlocksTableUpdateCompanionBuilder,
          (StoredContentBlock, $$ContentBlocksTableReferences),
          StoredContentBlock,
          PrefetchHooks Function({bool chapterId})
        > {
  $$ContentBlocksTableTableManager(_$AppDatabase db, $ContentBlocksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentBlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentBlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentBlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<int> startOffset = const Value.absent(),
                Value<int> endOffset = const Value.absent(),
                Value<String> inlineSpansJson = const Value.absent(),
                Value<String?> resourcePath = const Value.absent(),
                Value<String?> altText = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentBlocksCompanion(
                id: id,
                chapterId: chapterId,
                ordinal: ordinal,
                kind: kind,
                textContent: textContent,
                startOffset: startOffset,
                endOffset: endOffset,
                inlineSpansJson: inlineSpansJson,
                resourcePath: resourcePath,
                altText: altText,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String chapterId,
                required int ordinal,
                required String kind,
                required String textContent,
                required int startOffset,
                required int endOffset,
                Value<String> inlineSpansJson = const Value.absent(),
                Value<String?> resourcePath = const Value.absent(),
                Value<String?> altText = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentBlocksCompanion.insert(
                id: id,
                chapterId: chapterId,
                ordinal: ordinal,
                kind: kind,
                textContent: textContent,
                startOffset: startOffset,
                endOffset: endOffset,
                inlineSpansJson: inlineSpansJson,
                resourcePath: resourcePath,
                altText: altText,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContentBlocksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({chapterId = false}) {
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
                    if (chapterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.chapterId,
                                referencedTable: $$ContentBlocksTableReferences
                                    ._chapterIdTable(db),
                                referencedColumn: $$ContentBlocksTableReferences
                                    ._chapterIdTable(db)
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

typedef $$ContentBlocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContentBlocksTable,
      StoredContentBlock,
      $$ContentBlocksTableFilterComposer,
      $$ContentBlocksTableOrderingComposer,
      $$ContentBlocksTableAnnotationComposer,
      $$ContentBlocksTableCreateCompanionBuilder,
      $$ContentBlocksTableUpdateCompanionBuilder,
      (StoredContentBlock, $$ContentBlocksTableReferences),
      StoredContentBlock,
      PrefetchHooks Function({bool chapterId})
    >;
typedef $$TocEntriesTableCreateCompanionBuilder =
    TocEntriesCompanion Function({
      required String id,
      required String bookId,
      Value<String?> parentId,
      required int ordinal,
      Value<int> depth,
      required String title,
      Value<String?> chapterId,
      Value<int> textOffset,
      Value<int> rowid,
    });
typedef $$TocEntriesTableUpdateCompanionBuilder =
    TocEntriesCompanion Function({
      Value<String> id,
      Value<String> bookId,
      Value<String?> parentId,
      Value<int> ordinal,
      Value<int> depth,
      Value<String> title,
      Value<String?> chapterId,
      Value<int> textOffset,
      Value<int> rowid,
    });

final class $$TocEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $TocEntriesTable, StoredTocEntry> {
  $$TocEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) =>
      db.books.createAlias('toc_entries__book_id__books__id');

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TocEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TocEntriesTable> {
  $$TocEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterId => $composableBuilder(
    column: $table.chapterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get textOffset => $composableBuilder(
    column: $table.textOffset,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TocEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TocEntriesTable> {
  $$TocEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get depth => $composableBuilder(
    column: $table.depth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterId => $composableBuilder(
    column: $table.chapterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get textOffset => $composableBuilder(
    column: $table.textOffset,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TocEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TocEntriesTable> {
  $$TocEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<int> get depth =>
      $composableBuilder(column: $table.depth, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get chapterId =>
      $composableBuilder(column: $table.chapterId, builder: (column) => column);

  GeneratedColumn<int> get textOffset => $composableBuilder(
    column: $table.textOffset,
    builder: (column) => column,
  );

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TocEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TocEntriesTable,
          StoredTocEntry,
          $$TocEntriesTableFilterComposer,
          $$TocEntriesTableOrderingComposer,
          $$TocEntriesTableAnnotationComposer,
          $$TocEntriesTableCreateCompanionBuilder,
          $$TocEntriesTableUpdateCompanionBuilder,
          (StoredTocEntry, $$TocEntriesTableReferences),
          StoredTocEntry,
          PrefetchHooks Function({bool bookId})
        > {
  $$TocEntriesTableTableManager(_$AppDatabase db, $TocEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TocEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TocEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TocEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<int> depth = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> chapterId = const Value.absent(),
                Value<int> textOffset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TocEntriesCompanion(
                id: id,
                bookId: bookId,
                parentId: parentId,
                ordinal: ordinal,
                depth: depth,
                title: title,
                chapterId: chapterId,
                textOffset: textOffset,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bookId,
                Value<String?> parentId = const Value.absent(),
                required int ordinal,
                Value<int> depth = const Value.absent(),
                required String title,
                Value<String?> chapterId = const Value.absent(),
                Value<int> textOffset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TocEntriesCompanion.insert(
                id: id,
                bookId: bookId,
                parentId: parentId,
                ordinal: ordinal,
                depth: depth,
                title: title,
                chapterId: chapterId,
                textOffset: textOffset,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TocEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
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
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$TocEntriesTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$TocEntriesTableReferences
                                    ._bookIdTable(db)
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

typedef $$TocEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TocEntriesTable,
      StoredTocEntry,
      $$TocEntriesTableFilterComposer,
      $$TocEntriesTableOrderingComposer,
      $$TocEntriesTableAnnotationComposer,
      $$TocEntriesTableCreateCompanionBuilder,
      $$TocEntriesTableUpdateCompanionBuilder,
      (StoredTocEntry, $$TocEntriesTableReferences),
      StoredTocEntry,
      PrefetchHooks Function({bool bookId})
    >;
typedef $$PaginationProfilesTableCreateCompanionBuilder =
    PaginationProfilesCompanion Function({
      required String id,
      required String bookId,
      required String fingerprint,
      required double viewportWidth,
      required double viewportHeight,
      required String settingsJson,
      required int algorithmVersion,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PaginationProfilesTableUpdateCompanionBuilder =
    PaginationProfilesCompanion Function({
      Value<String> id,
      Value<String> bookId,
      Value<String> fingerprint,
      Value<double> viewportWidth,
      Value<double> viewportHeight,
      Value<String> settingsJson,
      Value<int> algorithmVersion,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PaginationProfilesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PaginationProfilesTable,
          StoredPaginationProfile
        > {
  $$PaginationProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BooksTable _bookIdTable(_$AppDatabase db) =>
      db.books.createAlias('pagination_profiles__book_id__books__id');

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<String>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BookPagesTable, List<StoredPage>>
  _bookPagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookPages,
    aliasName: 'pagination_profiles__id__book_pages__profile_id',
  );

  $$BookPagesTableProcessedTableManager get bookPagesRefs {
    final manager = $$BookPagesTableTableManager(
      $_db,
      $_db.bookPages,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookPagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaginationProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $PaginationProfilesTable> {
  $$PaginationProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get viewportWidth => $composableBuilder(
    column: $table.viewportWidth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get viewportHeight => $composableBuilder(
    column: $table.viewportHeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settingsJson => $composableBuilder(
    column: $table.settingsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> bookPagesRefs(
    Expression<bool> Function($$BookPagesTableFilterComposer f) f,
  ) {
    final $$BookPagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookPages,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookPagesTableFilterComposer(
            $db: $db,
            $table: $db.bookPages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaginationProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PaginationProfilesTable> {
  $$PaginationProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get viewportWidth => $composableBuilder(
    column: $table.viewportWidth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get viewportHeight => $composableBuilder(
    column: $table.viewportHeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settingsJson => $composableBuilder(
    column: $table.settingsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaginationProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaginationProfilesTable> {
  $$PaginationProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fingerprint => $composableBuilder(
    column: $table.fingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<double> get viewportWidth => $composableBuilder(
    column: $table.viewportWidth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get viewportHeight => $composableBuilder(
    column: $table.viewportHeight,
    builder: (column) => column,
  );

  GeneratedColumn<String> get settingsJson => $composableBuilder(
    column: $table.settingsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> bookPagesRefs<T extends Object>(
    Expression<T> Function($$BookPagesTableAnnotationComposer a) f,
  ) {
    final $$BookPagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookPages,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookPagesTableAnnotationComposer(
            $db: $db,
            $table: $db.bookPages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaginationProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaginationProfilesTable,
          StoredPaginationProfile,
          $$PaginationProfilesTableFilterComposer,
          $$PaginationProfilesTableOrderingComposer,
          $$PaginationProfilesTableAnnotationComposer,
          $$PaginationProfilesTableCreateCompanionBuilder,
          $$PaginationProfilesTableUpdateCompanionBuilder,
          (StoredPaginationProfile, $$PaginationProfilesTableReferences),
          StoredPaginationProfile,
          PrefetchHooks Function({bool bookId, bool bookPagesRefs})
        > {
  $$PaginationProfilesTableTableManager(
    _$AppDatabase db,
    $PaginationProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaginationProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaginationProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaginationProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> bookId = const Value.absent(),
                Value<String> fingerprint = const Value.absent(),
                Value<double> viewportWidth = const Value.absent(),
                Value<double> viewportHeight = const Value.absent(),
                Value<String> settingsJson = const Value.absent(),
                Value<int> algorithmVersion = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaginationProfilesCompanion(
                id: id,
                bookId: bookId,
                fingerprint: fingerprint,
                viewportWidth: viewportWidth,
                viewportHeight: viewportHeight,
                settingsJson: settingsJson,
                algorithmVersion: algorithmVersion,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String bookId,
                required String fingerprint,
                required double viewportWidth,
                required double viewportHeight,
                required String settingsJson,
                required int algorithmVersion,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaginationProfilesCompanion.insert(
                id: id,
                bookId: bookId,
                fingerprint: fingerprint,
                viewportWidth: viewportWidth,
                viewportHeight: viewportHeight,
                settingsJson: settingsJson,
                algorithmVersion: algorithmVersion,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaginationProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false, bookPagesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bookPagesRefs) db.bookPages],
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
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable:
                                    $$PaginationProfilesTableReferences
                                        ._bookIdTable(db),
                                referencedColumn:
                                    $$PaginationProfilesTableReferences
                                        ._bookIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bookPagesRefs)
                    await $_getPrefetchedData<
                      StoredPaginationProfile,
                      $PaginationProfilesTable,
                      StoredPage
                    >(
                      currentTable: table,
                      referencedTable: $$PaginationProfilesTableReferences
                          ._bookPagesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PaginationProfilesTableReferences(
                            db,
                            table,
                            p0,
                          ).bookPagesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.profileId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PaginationProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaginationProfilesTable,
      StoredPaginationProfile,
      $$PaginationProfilesTableFilterComposer,
      $$PaginationProfilesTableOrderingComposer,
      $$PaginationProfilesTableAnnotationComposer,
      $$PaginationProfilesTableCreateCompanionBuilder,
      $$PaginationProfilesTableUpdateCompanionBuilder,
      (StoredPaginationProfile, $$PaginationProfilesTableReferences),
      StoredPaginationProfile,
      PrefetchHooks Function({bool bookId, bool bookPagesRefs})
    >;
typedef $$BookPagesTableCreateCompanionBuilder =
    BookPagesCompanion Function({
      required String id,
      required String profileId,
      required String chapterId,
      required int pageIndex,
      required int startOffset,
      required int endOffset,
      Value<int> rowid,
    });
typedef $$BookPagesTableUpdateCompanionBuilder =
    BookPagesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> chapterId,
      Value<int> pageIndex,
      Value<int> startOffset,
      Value<int> endOffset,
      Value<int> rowid,
    });

final class $$BookPagesTableReferences
    extends BaseReferences<_$AppDatabase, $BookPagesTable, StoredPage> {
  $$BookPagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PaginationProfilesTable _profileIdTable(_$AppDatabase db) => db
      .paginationProfiles
      .createAlias('book_pages__profile_id__pagination_profiles__id');

  $$PaginationProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$PaginationProfilesTableTableManager(
      $_db,
      $_db.paginationProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ChaptersTable _chapterIdTable(_$AppDatabase db) =>
      db.chapters.createAlias('book_pages__chapter_id__chapters__id');

  $$ChaptersTableProcessedTableManager get chapterId {
    final $_column = $_itemColumn<String>('chapter_id')!;

    final manager = $$ChaptersTableTableManager(
      $_db,
      $_db.chapters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_chapterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BookPagesTableFilterComposer
    extends Composer<_$AppDatabase, $BookPagesTable> {
  $$BookPagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnFilters(column),
  );

  $$PaginationProfilesTableFilterComposer get profileId {
    final $$PaginationProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.paginationProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaginationProfilesTableFilterComposer(
            $db: $db,
            $table: $db.paginationProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableFilterComposer get chapterId {
    final $$ChaptersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableFilterComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookPagesTableOrderingComposer
    extends Composer<_$AppDatabase, $BookPagesTable> {
  $$BookPagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pageIndex => $composableBuilder(
    column: $table.pageIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endOffset => $composableBuilder(
    column: $table.endOffset,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaginationProfilesTableOrderingComposer get profileId {
    final $$PaginationProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.paginationProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaginationProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.paginationProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ChaptersTableOrderingComposer get chapterId {
    final $$ChaptersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableOrderingComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookPagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookPagesTable> {
  $$BookPagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pageIndex =>
      $composableBuilder(column: $table.pageIndex, builder: (column) => column);

  GeneratedColumn<int> get startOffset => $composableBuilder(
    column: $table.startOffset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endOffset =>
      $composableBuilder(column: $table.endOffset, builder: (column) => column);

  $$PaginationProfilesTableAnnotationComposer get profileId {
    final $$PaginationProfilesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.profileId,
          referencedTable: $db.paginationProfiles,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PaginationProfilesTableAnnotationComposer(
                $db: $db,
                $table: $db.paginationProfiles,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ChaptersTableAnnotationComposer get chapterId {
    final $$ChaptersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.chapterId,
      referencedTable: $db.chapters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChaptersTableAnnotationComposer(
            $db: $db,
            $table: $db.chapters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookPagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookPagesTable,
          StoredPage,
          $$BookPagesTableFilterComposer,
          $$BookPagesTableOrderingComposer,
          $$BookPagesTableAnnotationComposer,
          $$BookPagesTableCreateCompanionBuilder,
          $$BookPagesTableUpdateCompanionBuilder,
          (StoredPage, $$BookPagesTableReferences),
          StoredPage,
          PrefetchHooks Function({bool profileId, bool chapterId})
        > {
  $$BookPagesTableTableManager(_$AppDatabase db, $BookPagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookPagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookPagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookPagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<int> pageIndex = const Value.absent(),
                Value<int> startOffset = const Value.absent(),
                Value<int> endOffset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookPagesCompanion(
                id: id,
                profileId: profileId,
                chapterId: chapterId,
                pageIndex: pageIndex,
                startOffset: startOffset,
                endOffset: endOffset,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String chapterId,
                required int pageIndex,
                required int startOffset,
                required int endOffset,
                Value<int> rowid = const Value.absent(),
              }) => BookPagesCompanion.insert(
                id: id,
                profileId: profileId,
                chapterId: chapterId,
                pageIndex: pageIndex,
                startOffset: startOffset,
                endOffset: endOffset,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookPagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, chapterId = false}) {
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$BookPagesTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$BookPagesTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (chapterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.chapterId,
                                referencedTable: $$BookPagesTableReferences
                                    ._chapterIdTable(db),
                                referencedColumn: $$BookPagesTableReferences
                                    ._chapterIdTable(db)
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

typedef $$BookPagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookPagesTable,
      StoredPage,
      $$BookPagesTableFilterComposer,
      $$BookPagesTableOrderingComposer,
      $$BookPagesTableAnnotationComposer,
      $$BookPagesTableCreateCompanionBuilder,
      $$BookPagesTableUpdateCompanionBuilder,
      (StoredPage, $$BookPagesTableReferences),
      StoredPage,
      PrefetchHooks Function({bool profileId, bool chapterId})
    >;
typedef $$ReaderPositionsTableCreateCompanionBuilder =
    ReaderPositionsCompanion Function({
      required String bookId,
      required String chapterId,
      required int textOffset,
      required double progress,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ReaderPositionsTableUpdateCompanionBuilder =
    ReaderPositionsCompanion Function({
      Value<String> bookId,
      Value<String> chapterId,
      Value<int> textOffset,
      Value<double> progress,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ReaderPositionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReaderPositionsTable> {
  $$ReaderPositionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterId => $composableBuilder(
    column: $table.chapterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get textOffset => $composableBuilder(
    column: $table.textOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReaderPositionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReaderPositionsTable> {
  $$ReaderPositionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get bookId => $composableBuilder(
    column: $table.bookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterId => $composableBuilder(
    column: $table.chapterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get textOffset => $composableBuilder(
    column: $table.textOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReaderPositionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReaderPositionsTable> {
  $$ReaderPositionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<String> get chapterId =>
      $composableBuilder(column: $table.chapterId, builder: (column) => column);

  GeneratedColumn<int> get textOffset => $composableBuilder(
    column: $table.textOffset,
    builder: (column) => column,
  );

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ReaderPositionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReaderPositionsTable,
          StoredReaderPosition,
          $$ReaderPositionsTableFilterComposer,
          $$ReaderPositionsTableOrderingComposer,
          $$ReaderPositionsTableAnnotationComposer,
          $$ReaderPositionsTableCreateCompanionBuilder,
          $$ReaderPositionsTableUpdateCompanionBuilder,
          (
            StoredReaderPosition,
            BaseReferences<
              _$AppDatabase,
              $ReaderPositionsTable,
              StoredReaderPosition
            >,
          ),
          StoredReaderPosition,
          PrefetchHooks Function()
        > {
  $$ReaderPositionsTableTableManager(
    _$AppDatabase db,
    $ReaderPositionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReaderPositionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReaderPositionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReaderPositionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> bookId = const Value.absent(),
                Value<String> chapterId = const Value.absent(),
                Value<int> textOffset = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReaderPositionsCompanion(
                bookId: bookId,
                chapterId: chapterId,
                textOffset: textOffset,
                progress: progress,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String bookId,
                required String chapterId,
                required int textOffset,
                required double progress,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ReaderPositionsCompanion.insert(
                bookId: bookId,
                chapterId: chapterId,
                textOffset: textOffset,
                progress: progress,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReaderPositionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReaderPositionsTable,
      StoredReaderPosition,
      $$ReaderPositionsTableFilterComposer,
      $$ReaderPositionsTableOrderingComposer,
      $$ReaderPositionsTableAnnotationComposer,
      $$ReaderPositionsTableCreateCompanionBuilder,
      $$ReaderPositionsTableUpdateCompanionBuilder,
      (
        StoredReaderPosition,
        BaseReferences<
          _$AppDatabase,
          $ReaderPositionsTable,
          StoredReaderPosition
        >,
      ),
      StoredReaderPosition,
      PrefetchHooks Function()
    >;
typedef $$VocabularyItemsTableCreateCompanionBuilder =
    VocabularyItemsCompanion Function({
      required String id,
      required String sourceLanguage,
      required String targetLanguage,
      required String lemma,
      required String normalizedLemma,
      required String translation,
      Value<String> kind,
      Value<String?> partOfSpeech,
      Value<String> status,
      Value<DateTime> createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int?> serverRevision,
      Value<int> rowid,
    });
typedef $$VocabularyItemsTableUpdateCompanionBuilder =
    VocabularyItemsCompanion Function({
      Value<String> id,
      Value<String> sourceLanguage,
      Value<String> targetLanguage,
      Value<String> lemma,
      Value<String> normalizedLemma,
      Value<String> translation,
      Value<String> kind,
      Value<String?> partOfSpeech,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int?> serverRevision,
      Value<int> rowid,
    });

final class $$VocabularyItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VocabularyItemsTable,
          StoredVocabularyItem
        > {
  $$VocabularyItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$WordOccurrencesTable, List<StoredWordOccurrence>>
  _wordOccurrencesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordOccurrences,
    aliasName: 'vocabulary_items__id__word_occurrences__vocabulary_id',
  );

  $$WordOccurrencesTableProcessedTableManager get wordOccurrencesRefs {
    final manager = $$WordOccurrencesTableTableManager(
      $_db,
      $_db.wordOccurrences,
    ).filter((f) => f.vocabularyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _wordOccurrencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SrsCardsTable, List<StoredSrsCard>>
  _srsCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.srsCards,
    aliasName: 'vocabulary_items__id__srs_cards__vocabulary_id',
  );

  $$SrsCardsTableProcessedTableManager get srsCardsRefs {
    final manager = $$SrsCardsTableTableManager(
      $_db,
      $_db.srsCards,
    ).filter((f) => f.vocabularyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_srsCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VocabularyItemsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceLanguage => $composableBuilder(
    column: $table.sourceLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetLanguage => $composableBuilder(
    column: $table.targetLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedLemma => $composableBuilder(
    column: $table.normalizedLemma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
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

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordOccurrencesRefs(
    Expression<bool> Function($$WordOccurrencesTableFilterComposer f) f,
  ) {
    final $$WordOccurrencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordOccurrences,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordOccurrencesTableFilterComposer(
            $db: $db,
            $table: $db.wordOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> srsCardsRefs(
    Expression<bool> Function($$SrsCardsTableFilterComposer f) f,
  ) {
    final $$SrsCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.srsCards,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SrsCardsTableFilterComposer(
            $db: $db,
            $table: $db.srsCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VocabularyItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceLanguage => $composableBuilder(
    column: $table.sourceLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetLanguage => $composableBuilder(
    column: $table.targetLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedLemma => $composableBuilder(
    column: $table.normalizedLemma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
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

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VocabularyItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyItemsTable> {
  $$VocabularyItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceLanguage => $composableBuilder(
    column: $table.sourceLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetLanguage => $composableBuilder(
    column: $table.targetLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lemma =>
      $composableBuilder(column: $table.lemma, builder: (column) => column);

  GeneratedColumn<String> get normalizedLemma => $composableBuilder(
    column: $table.normalizedLemma,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => column,
  );

  Expression<T> wordOccurrencesRefs<T extends Object>(
    Expression<T> Function($$WordOccurrencesTableAnnotationComposer a) f,
  ) {
    final $$WordOccurrencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordOccurrences,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordOccurrencesTableAnnotationComposer(
            $db: $db,
            $table: $db.wordOccurrences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> srsCardsRefs<T extends Object>(
    Expression<T> Function($$SrsCardsTableAnnotationComposer a) f,
  ) {
    final $$SrsCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.srsCards,
      getReferencedColumn: (t) => t.vocabularyId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SrsCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.srsCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VocabularyItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabularyItemsTable,
          StoredVocabularyItem,
          $$VocabularyItemsTableFilterComposer,
          $$VocabularyItemsTableOrderingComposer,
          $$VocabularyItemsTableAnnotationComposer,
          $$VocabularyItemsTableCreateCompanionBuilder,
          $$VocabularyItemsTableUpdateCompanionBuilder,
          (StoredVocabularyItem, $$VocabularyItemsTableReferences),
          StoredVocabularyItem,
          PrefetchHooks Function({bool wordOccurrencesRefs, bool srsCardsRefs})
        > {
  $$VocabularyItemsTableTableManager(
    _$AppDatabase db,
    $VocabularyItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabularyItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sourceLanguage = const Value.absent(),
                Value<String> targetLanguage = const Value.absent(),
                Value<String> lemma = const Value.absent(),
                Value<String> normalizedLemma = const Value.absent(),
                Value<String> translation = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> partOfSpeech = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int?> serverRevision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabularyItemsCompanion(
                id: id,
                sourceLanguage: sourceLanguage,
                targetLanguage: targetLanguage,
                lemma: lemma,
                normalizedLemma: normalizedLemma,
                translation: translation,
                kind: kind,
                partOfSpeech: partOfSpeech,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverRevision: serverRevision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sourceLanguage,
                required String targetLanguage,
                required String lemma,
                required String normalizedLemma,
                required String translation,
                Value<String> kind = const Value.absent(),
                Value<String?> partOfSpeech = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int?> serverRevision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabularyItemsCompanion.insert(
                id: id,
                sourceLanguage: sourceLanguage,
                targetLanguage: targetLanguage,
                lemma: lemma,
                normalizedLemma: normalizedLemma,
                translation: translation,
                kind: kind,
                partOfSpeech: partOfSpeech,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                serverRevision: serverRevision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VocabularyItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({wordOccurrencesRefs = false, srsCardsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wordOccurrencesRefs) db.wordOccurrences,
                    if (srsCardsRefs) db.srsCards,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wordOccurrencesRefs)
                        await $_getPrefetchedData<
                          StoredVocabularyItem,
                          $VocabularyItemsTable,
                          StoredWordOccurrence
                        >(
                          currentTable: table,
                          referencedTable: $$VocabularyItemsTableReferences
                              ._wordOccurrencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabularyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).wordOccurrencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vocabularyId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (srsCardsRefs)
                        await $_getPrefetchedData<
                          StoredVocabularyItem,
                          $VocabularyItemsTable,
                          StoredSrsCard
                        >(
                          currentTable: table,
                          referencedTable: $$VocabularyItemsTableReferences
                              ._srsCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabularyItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).srsCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vocabularyId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VocabularyItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabularyItemsTable,
      StoredVocabularyItem,
      $$VocabularyItemsTableFilterComposer,
      $$VocabularyItemsTableOrderingComposer,
      $$VocabularyItemsTableAnnotationComposer,
      $$VocabularyItemsTableCreateCompanionBuilder,
      $$VocabularyItemsTableUpdateCompanionBuilder,
      (StoredVocabularyItem, $$VocabularyItemsTableReferences),
      StoredVocabularyItem,
      PrefetchHooks Function({bool wordOccurrencesRefs, bool srsCardsRefs})
    >;
typedef $$WordOccurrencesTableCreateCompanionBuilder =
    WordOccurrencesCompanion Function({
      required String id,
      required String vocabularyId,
      required String surfaceForm,
      required String contextSentence,
      required int wordStart,
      required int wordEnd,
      Value<String?> sourceBookId,
      required String sourceBookTitle,
      Value<String?> sourceChapterId,
      Value<String?> sourceChapterTitle,
      Value<int?> sourceOffset,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$WordOccurrencesTableUpdateCompanionBuilder =
    WordOccurrencesCompanion Function({
      Value<String> id,
      Value<String> vocabularyId,
      Value<String> surfaceForm,
      Value<String> contextSentence,
      Value<int> wordStart,
      Value<int> wordEnd,
      Value<String?> sourceBookId,
      Value<String> sourceBookTitle,
      Value<String?> sourceChapterId,
      Value<String?> sourceChapterTitle,
      Value<int?> sourceOffset,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$WordOccurrencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WordOccurrencesTable,
          StoredWordOccurrence
        > {
  $$WordOccurrencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VocabularyItemsTable _vocabularyIdTable(_$AppDatabase db) => db
      .vocabularyItems
      .createAlias('word_occurrences__vocabulary_id__vocabulary_items__id');

  $$VocabularyItemsTableProcessedTableManager get vocabularyId {
    final $_column = $_itemColumn<String>('vocabulary_id')!;

    final manager = $$VocabularyItemsTableTableManager(
      $_db,
      $_db.vocabularyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabularyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordOccurrencesTableFilterComposer
    extends Composer<_$AppDatabase, $WordOccurrencesTable> {
  $$WordOccurrencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surfaceForm => $composableBuilder(
    column: $table.surfaceForm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contextSentence => $composableBuilder(
    column: $table.contextSentence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordStart => $composableBuilder(
    column: $table.wordStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordEnd => $composableBuilder(
    column: $table.wordEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceBookId => $composableBuilder(
    column: $table.sourceBookId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceBookTitle => $composableBuilder(
    column: $table.sourceBookTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceChapterId => $composableBuilder(
    column: $table.sourceChapterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceChapterTitle => $composableBuilder(
    column: $table.sourceChapterTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sourceOffset => $composableBuilder(
    column: $table.sourceOffset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VocabularyItemsTableFilterComposer get vocabularyId {
    final $$VocabularyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordOccurrencesTableOrderingComposer
    extends Composer<_$AppDatabase, $WordOccurrencesTable> {
  $$WordOccurrencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surfaceForm => $composableBuilder(
    column: $table.surfaceForm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contextSentence => $composableBuilder(
    column: $table.contextSentence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordStart => $composableBuilder(
    column: $table.wordStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordEnd => $composableBuilder(
    column: $table.wordEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceBookId => $composableBuilder(
    column: $table.sourceBookId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceBookTitle => $composableBuilder(
    column: $table.sourceBookTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceChapterId => $composableBuilder(
    column: $table.sourceChapterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceChapterTitle => $composableBuilder(
    column: $table.sourceChapterTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sourceOffset => $composableBuilder(
    column: $table.sourceOffset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VocabularyItemsTableOrderingComposer get vocabularyId {
    final $$VocabularyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordOccurrencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordOccurrencesTable> {
  $$WordOccurrencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get surfaceForm => $composableBuilder(
    column: $table.surfaceForm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contextSentence => $composableBuilder(
    column: $table.contextSentence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wordStart =>
      $composableBuilder(column: $table.wordStart, builder: (column) => column);

  GeneratedColumn<int> get wordEnd =>
      $composableBuilder(column: $table.wordEnd, builder: (column) => column);

  GeneratedColumn<String> get sourceBookId => $composableBuilder(
    column: $table.sourceBookId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceBookTitle => $composableBuilder(
    column: $table.sourceBookTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceChapterId => $composableBuilder(
    column: $table.sourceChapterId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceChapterTitle => $composableBuilder(
    column: $table.sourceChapterTitle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sourceOffset => $composableBuilder(
    column: $table.sourceOffset,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VocabularyItemsTableAnnotationComposer get vocabularyId {
    final $$VocabularyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordOccurrencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordOccurrencesTable,
          StoredWordOccurrence,
          $$WordOccurrencesTableFilterComposer,
          $$WordOccurrencesTableOrderingComposer,
          $$WordOccurrencesTableAnnotationComposer,
          $$WordOccurrencesTableCreateCompanionBuilder,
          $$WordOccurrencesTableUpdateCompanionBuilder,
          (StoredWordOccurrence, $$WordOccurrencesTableReferences),
          StoredWordOccurrence,
          PrefetchHooks Function({bool vocabularyId})
        > {
  $$WordOccurrencesTableTableManager(
    _$AppDatabase db,
    $WordOccurrencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordOccurrencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordOccurrencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordOccurrencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vocabularyId = const Value.absent(),
                Value<String> surfaceForm = const Value.absent(),
                Value<String> contextSentence = const Value.absent(),
                Value<int> wordStart = const Value.absent(),
                Value<int> wordEnd = const Value.absent(),
                Value<String?> sourceBookId = const Value.absent(),
                Value<String> sourceBookTitle = const Value.absent(),
                Value<String?> sourceChapterId = const Value.absent(),
                Value<String?> sourceChapterTitle = const Value.absent(),
                Value<int?> sourceOffset = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordOccurrencesCompanion(
                id: id,
                vocabularyId: vocabularyId,
                surfaceForm: surfaceForm,
                contextSentence: contextSentence,
                wordStart: wordStart,
                wordEnd: wordEnd,
                sourceBookId: sourceBookId,
                sourceBookTitle: sourceBookTitle,
                sourceChapterId: sourceChapterId,
                sourceChapterTitle: sourceChapterTitle,
                sourceOffset: sourceOffset,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vocabularyId,
                required String surfaceForm,
                required String contextSentence,
                required int wordStart,
                required int wordEnd,
                Value<String?> sourceBookId = const Value.absent(),
                required String sourceBookTitle,
                Value<String?> sourceChapterId = const Value.absent(),
                Value<String?> sourceChapterTitle = const Value.absent(),
                Value<int?> sourceOffset = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordOccurrencesCompanion.insert(
                id: id,
                vocabularyId: vocabularyId,
                surfaceForm: surfaceForm,
                contextSentence: contextSentence,
                wordStart: wordStart,
                wordEnd: wordEnd,
                sourceBookId: sourceBookId,
                sourceBookTitle: sourceBookTitle,
                sourceChapterId: sourceChapterId,
                sourceChapterTitle: sourceChapterTitle,
                sourceOffset: sourceOffset,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WordOccurrencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vocabularyId = false}) {
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
                    if (vocabularyId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vocabularyId,
                                referencedTable:
                                    $$WordOccurrencesTableReferences
                                        ._vocabularyIdTable(db),
                                referencedColumn:
                                    $$WordOccurrencesTableReferences
                                        ._vocabularyIdTable(db)
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

typedef $$WordOccurrencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordOccurrencesTable,
      StoredWordOccurrence,
      $$WordOccurrencesTableFilterComposer,
      $$WordOccurrencesTableOrderingComposer,
      $$WordOccurrencesTableAnnotationComposer,
      $$WordOccurrencesTableCreateCompanionBuilder,
      $$WordOccurrencesTableUpdateCompanionBuilder,
      (StoredWordOccurrence, $$WordOccurrencesTableReferences),
      StoredWordOccurrence,
      PrefetchHooks Function({bool vocabularyId})
    >;
typedef $$SrsCardsTableCreateCompanionBuilder =
    SrsCardsCompanion Function({
      required String id,
      required String vocabularyId,
      required String algorithm,
      required int algorithmVersion,
      required String stateJson,
      required DateTime dueAt,
      Value<DateTime?> lastReviewedAt,
      Value<int?> serverRevision,
      Value<int> rowid,
    });
typedef $$SrsCardsTableUpdateCompanionBuilder =
    SrsCardsCompanion Function({
      Value<String> id,
      Value<String> vocabularyId,
      Value<String> algorithm,
      Value<int> algorithmVersion,
      Value<String> stateJson,
      Value<DateTime> dueAt,
      Value<DateTime?> lastReviewedAt,
      Value<int?> serverRevision,
      Value<int> rowid,
    });

final class $$SrsCardsTableReferences
    extends BaseReferences<_$AppDatabase, $SrsCardsTable, StoredSrsCard> {
  $$SrsCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VocabularyItemsTable _vocabularyIdTable(_$AppDatabase db) => db
      .vocabularyItems
      .createAlias('srs_cards__vocabulary_id__vocabulary_items__id');

  $$VocabularyItemsTableProcessedTableManager get vocabularyId {
    final $_column = $_itemColumn<String>('vocabulary_id')!;

    final manager = $$VocabularyItemsTableTableManager(
      $_db,
      $_db.vocabularyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabularyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReviewEventsTable, List<StoredReviewEvent>>
  _reviewEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewEvents,
    aliasName: 'srs_cards__id__review_events__card_id',
  );

  $$ReviewEventsTableProcessedTableManager get reviewEventsRefs {
    final manager = $$ReviewEventsTableTableManager(
      $_db,
      $_db.reviewEvents,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SrsCardsTableFilterComposer
    extends Composer<_$AppDatabase, $SrsCardsTable> {
  $$SrsCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get algorithm => $composableBuilder(
    column: $table.algorithm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateJson => $composableBuilder(
    column: $table.stateJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => ColumnFilters(column),
  );

  $$VocabularyItemsTableFilterComposer get vocabularyId {
    final $$VocabularyItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> reviewEventsRefs(
    Expression<bool> Function($$ReviewEventsTableFilterComposer f) f,
  ) {
    final $$ReviewEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableFilterComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SrsCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $SrsCardsTable> {
  $$SrsCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get algorithm => $composableBuilder(
    column: $table.algorithm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateJson => $composableBuilder(
    column: $table.stateJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => ColumnOrderings(column),
  );

  $$VocabularyItemsTableOrderingComposer get vocabularyId {
    final $$VocabularyItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SrsCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SrsCardsTable> {
  $$SrsCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get algorithm =>
      $composableBuilder(column: $table.algorithm, builder: (column) => column);

  GeneratedColumn<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stateJson =>
      $composableBuilder(column: $table.stateJson, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => column,
  );

  $$VocabularyItemsTableAnnotationComposer get vocabularyId {
    final $$VocabularyItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vocabularyId,
      referencedTable: $db.vocabularyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabularyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> reviewEventsRefs<T extends Object>(
    Expression<T> Function($$ReviewEventsTableAnnotationComposer a) f,
  ) {
    final $$ReviewEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SrsCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SrsCardsTable,
          StoredSrsCard,
          $$SrsCardsTableFilterComposer,
          $$SrsCardsTableOrderingComposer,
          $$SrsCardsTableAnnotationComposer,
          $$SrsCardsTableCreateCompanionBuilder,
          $$SrsCardsTableUpdateCompanionBuilder,
          (StoredSrsCard, $$SrsCardsTableReferences),
          StoredSrsCard,
          PrefetchHooks Function({bool vocabularyId, bool reviewEventsRefs})
        > {
  $$SrsCardsTableTableManager(_$AppDatabase db, $SrsCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SrsCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SrsCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SrsCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vocabularyId = const Value.absent(),
                Value<String> algorithm = const Value.absent(),
                Value<int> algorithmVersion = const Value.absent(),
                Value<String> stateJson = const Value.absent(),
                Value<DateTime> dueAt = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<int?> serverRevision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SrsCardsCompanion(
                id: id,
                vocabularyId: vocabularyId,
                algorithm: algorithm,
                algorithmVersion: algorithmVersion,
                stateJson: stateJson,
                dueAt: dueAt,
                lastReviewedAt: lastReviewedAt,
                serverRevision: serverRevision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vocabularyId,
                required String algorithm,
                required int algorithmVersion,
                required String stateJson,
                required DateTime dueAt,
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<int?> serverRevision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SrsCardsCompanion.insert(
                id: id,
                vocabularyId: vocabularyId,
                algorithm: algorithm,
                algorithmVersion: algorithmVersion,
                stateJson: stateJson,
                dueAt: dueAt,
                lastReviewedAt: lastReviewedAt,
                serverRevision: serverRevision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SrsCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vocabularyId = false, reviewEventsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (reviewEventsRefs) db.reviewEvents,
                  ],
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
                        if (vocabularyId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.vocabularyId,
                                    referencedTable: $$SrsCardsTableReferences
                                        ._vocabularyIdTable(db),
                                    referencedColumn: $$SrsCardsTableReferences
                                        ._vocabularyIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (reviewEventsRefs)
                        await $_getPrefetchedData<
                          StoredSrsCard,
                          $SrsCardsTable,
                          StoredReviewEvent
                        >(
                          currentTable: table,
                          referencedTable: $$SrsCardsTableReferences
                              ._reviewEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SrsCardsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SrsCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SrsCardsTable,
      StoredSrsCard,
      $$SrsCardsTableFilterComposer,
      $$SrsCardsTableOrderingComposer,
      $$SrsCardsTableAnnotationComposer,
      $$SrsCardsTableCreateCompanionBuilder,
      $$SrsCardsTableUpdateCompanionBuilder,
      (StoredSrsCard, $$SrsCardsTableReferences),
      StoredSrsCard,
      PrefetchHooks Function({bool vocabularyId, bool reviewEventsRefs})
    >;
typedef $$ReviewEventsTableCreateCompanionBuilder =
    ReviewEventsCompanion Function({
      required String id,
      required String cardId,
      required int rating,
      required DateTime reviewedAt,
      required String stateBeforeJson,
      required String stateAfterJson,
      Value<int?> durationMs,
      Value<int?> serverRevision,
      Value<int> rowid,
    });
typedef $$ReviewEventsTableUpdateCompanionBuilder =
    ReviewEventsCompanion Function({
      Value<String> id,
      Value<String> cardId,
      Value<int> rating,
      Value<DateTime> reviewedAt,
      Value<String> stateBeforeJson,
      Value<String> stateAfterJson,
      Value<int?> durationMs,
      Value<int?> serverRevision,
      Value<int> rowid,
    });

final class $$ReviewEventsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReviewEventsTable, StoredReviewEvent> {
  $$ReviewEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SrsCardsTable _cardIdTable(_$AppDatabase db) =>
      db.srsCards.createAlias('review_events__card_id__srs_cards__id');

  $$SrsCardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$SrsCardsTableTableManager(
      $_db,
      $_db.srsCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateBeforeJson => $composableBuilder(
    column: $table.stateBeforeJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateAfterJson => $composableBuilder(
    column: $table.stateAfterJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => ColumnFilters(column),
  );

  $$SrsCardsTableFilterComposer get cardId {
    final $$SrsCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.srsCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SrsCardsTableFilterComposer(
            $db: $db,
            $table: $db.srsCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateBeforeJson => $composableBuilder(
    column: $table.stateBeforeJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateAfterJson => $composableBuilder(
    column: $table.stateAfterJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => ColumnOrderings(column),
  );

  $$SrsCardsTableOrderingComposer get cardId {
    final $$SrsCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.srsCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SrsCardsTableOrderingComposer(
            $db: $db,
            $table: $db.srsCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stateBeforeJson => $composableBuilder(
    column: $table.stateBeforeJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stateAfterJson => $composableBuilder(
    column: $table.stateAfterJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => column,
  );

  $$SrsCardsTableAnnotationComposer get cardId {
    final $$SrsCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.srsCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SrsCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.srsCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewEventsTable,
          StoredReviewEvent,
          $$ReviewEventsTableFilterComposer,
          $$ReviewEventsTableOrderingComposer,
          $$ReviewEventsTableAnnotationComposer,
          $$ReviewEventsTableCreateCompanionBuilder,
          $$ReviewEventsTableUpdateCompanionBuilder,
          (StoredReviewEvent, $$ReviewEventsTableReferences),
          StoredReviewEvent,
          PrefetchHooks Function({bool cardId})
        > {
  $$ReviewEventsTableTableManager(_$AppDatabase db, $ReviewEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
                Value<String> stateBeforeJson = const Value.absent(),
                Value<String> stateAfterJson = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<int?> serverRevision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewEventsCompanion(
                id: id,
                cardId: cardId,
                rating: rating,
                reviewedAt: reviewedAt,
                stateBeforeJson: stateBeforeJson,
                stateAfterJson: stateAfterJson,
                durationMs: durationMs,
                serverRevision: serverRevision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cardId,
                required int rating,
                required DateTime reviewedAt,
                required String stateBeforeJson,
                required String stateAfterJson,
                Value<int?> durationMs = const Value.absent(),
                Value<int?> serverRevision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewEventsCompanion.insert(
                id: id,
                cardId: cardId,
                rating: rating,
                reviewedAt: reviewedAt,
                stateBeforeJson: stateBeforeJson,
                stateAfterJson: stateAfterJson,
                durationMs: durationMs,
                serverRevision: serverRevision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReviewEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
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
                    if (cardId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cardId,
                                referencedTable: $$ReviewEventsTableReferences
                                    ._cardIdTable(db),
                                referencedColumn: $$ReviewEventsTableReferences
                                    ._cardIdTable(db)
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

typedef $$ReviewEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewEventsTable,
      StoredReviewEvent,
      $$ReviewEventsTableFilterComposer,
      $$ReviewEventsTableOrderingComposer,
      $$ReviewEventsTableAnnotationComposer,
      $$ReviewEventsTableCreateCompanionBuilder,
      $$ReviewEventsTableUpdateCompanionBuilder,
      (StoredReviewEvent, $$ReviewEventsTableReferences),
      StoredReviewEvent,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$LocalSettingsTableCreateCompanionBuilder =
    LocalSettingsCompanion Function({
      required String key,
      required String valueJson,
      required DateTime updatedAt,
      Value<int?> serverRevision,
      Value<int> rowid,
    });
typedef $$LocalSettingsTableUpdateCompanionBuilder =
    LocalSettingsCompanion Function({
      Value<String> key,
      Value<String> valueJson,
      Value<DateTime> updatedAt,
      Value<int?> serverRevision,
      Value<int> rowid,
    });

class $$LocalSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSettingsTable> {
  $$LocalSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSettingsTable> {
  $$LocalSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueJson => $composableBuilder(
    column: $table.valueJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSettingsTable> {
  $$LocalSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get valueJson =>
      $composableBuilder(column: $table.valueJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get serverRevision => $composableBuilder(
    column: $table.serverRevision,
    builder: (column) => column,
  );
}

class $$LocalSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSettingsTable,
          StoredSetting,
          $$LocalSettingsTableFilterComposer,
          $$LocalSettingsTableOrderingComposer,
          $$LocalSettingsTableAnnotationComposer,
          $$LocalSettingsTableCreateCompanionBuilder,
          $$LocalSettingsTableUpdateCompanionBuilder,
          (
            StoredSetting,
            BaseReferences<_$AppDatabase, $LocalSettingsTable, StoredSetting>,
          ),
          StoredSetting,
          PrefetchHooks Function()
        > {
  $$LocalSettingsTableTableManager(_$AppDatabase db, $LocalSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> valueJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> serverRevision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSettingsCompanion(
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
                serverRevision: serverRevision,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String valueJson,
                required DateTime updatedAt,
                Value<int?> serverRevision = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSettingsCompanion.insert(
                key: key,
                valueJson: valueJson,
                updatedAt: updatedAt,
                serverRevision: serverRevision,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSettingsTable,
      StoredSetting,
      $$LocalSettingsTableFilterComposer,
      $$LocalSettingsTableOrderingComposer,
      $$LocalSettingsTableAnnotationComposer,
      $$LocalSettingsTableCreateCompanionBuilder,
      $$LocalSettingsTableUpdateCompanionBuilder,
      (
        StoredSetting,
        BaseReferences<_$AppDatabase, $LocalSettingsTable, StoredSetting>,
      ),
      StoredSetting,
      PrefetchHooks Function()
    >;
typedef $$TranslationCacheEntriesTableCreateCompanionBuilder =
    TranslationCacheEntriesCompanion Function({
      required String cacheKey,
      required String requestKind,
      required String resultJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$TranslationCacheEntriesTableUpdateCompanionBuilder =
    TranslationCacheEntriesCompanion Function({
      Value<String> cacheKey,
      Value<String> requestKind,
      Value<String> resultJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TranslationCacheEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TranslationCacheEntriesTable> {
  $$TranslationCacheEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requestKind => $composableBuilder(
    column: $table.requestKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TranslationCacheEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TranslationCacheEntriesTable> {
  $$TranslationCacheEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cacheKey => $composableBuilder(
    column: $table.cacheKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requestKind => $composableBuilder(
    column: $table.requestKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TranslationCacheEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TranslationCacheEntriesTable> {
  $$TranslationCacheEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cacheKey =>
      $composableBuilder(column: $table.cacheKey, builder: (column) => column);

  GeneratedColumn<String> get requestKind => $composableBuilder(
    column: $table.requestKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resultJson => $composableBuilder(
    column: $table.resultJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TranslationCacheEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TranslationCacheEntriesTable,
          StoredTranslationCacheEntry,
          $$TranslationCacheEntriesTableFilterComposer,
          $$TranslationCacheEntriesTableOrderingComposer,
          $$TranslationCacheEntriesTableAnnotationComposer,
          $$TranslationCacheEntriesTableCreateCompanionBuilder,
          $$TranslationCacheEntriesTableUpdateCompanionBuilder,
          (
            StoredTranslationCacheEntry,
            BaseReferences<
              _$AppDatabase,
              $TranslationCacheEntriesTable,
              StoredTranslationCacheEntry
            >,
          ),
          StoredTranslationCacheEntry,
          PrefetchHooks Function()
        > {
  $$TranslationCacheEntriesTableTableManager(
    _$AppDatabase db,
    $TranslationCacheEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TranslationCacheEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TranslationCacheEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TranslationCacheEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> cacheKey = const Value.absent(),
                Value<String> requestKind = const Value.absent(),
                Value<String> resultJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TranslationCacheEntriesCompanion(
                cacheKey: cacheKey,
                requestKind: requestKind,
                resultJson: resultJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String cacheKey,
                required String requestKind,
                required String resultJson,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TranslationCacheEntriesCompanion.insert(
                cacheKey: cacheKey,
                requestKind: requestKind,
                resultJson: resultJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TranslationCacheEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TranslationCacheEntriesTable,
      StoredTranslationCacheEntry,
      $$TranslationCacheEntriesTableFilterComposer,
      $$TranslationCacheEntriesTableOrderingComposer,
      $$TranslationCacheEntriesTableAnnotationComposer,
      $$TranslationCacheEntriesTableCreateCompanionBuilder,
      $$TranslationCacheEntriesTableUpdateCompanionBuilder,
      (
        StoredTranslationCacheEntry,
        BaseReferences<
          _$AppDatabase,
          $TranslationCacheEntriesTable,
          StoredTranslationCacheEntry
        >,
      ),
      StoredTranslationCacheEntry,
      PrefetchHooks Function()
    >;
typedef $$SyncOutboxEntriesTableCreateCompanionBuilder =
    SyncOutboxEntriesCompanion Function({
      required String mutationId,
      required String entityType,
      required String entityId,
      required String operation,
      required String payloadJson,
      Value<int> attempts,
      Value<DateTime> createdAt,
      Value<DateTime?> nextAttemptAt,
      Value<int> rowid,
    });
typedef $$SyncOutboxEntriesTableUpdateCompanionBuilder =
    SyncOutboxEntriesCompanion Function({
      Value<String> mutationId,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String> payloadJson,
      Value<int> attempts,
      Value<DateTime> createdAt,
      Value<DateTime?> nextAttemptAt,
      Value<int> rowid,
    });

class $$SyncOutboxEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncOutboxEntriesTable> {
  $$SyncOutboxEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get mutationId => $composableBuilder(
    column: $table.mutationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncOutboxEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncOutboxEntriesTable> {
  $$SyncOutboxEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get mutationId => $composableBuilder(
    column: $table.mutationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncOutboxEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncOutboxEntriesTable> {
  $$SyncOutboxEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get mutationId => $composableBuilder(
    column: $table.mutationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get nextAttemptAt => $composableBuilder(
    column: $table.nextAttemptAt,
    builder: (column) => column,
  );
}

class $$SyncOutboxEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncOutboxEntriesTable,
          StoredSyncOutboxEntry,
          $$SyncOutboxEntriesTableFilterComposer,
          $$SyncOutboxEntriesTableOrderingComposer,
          $$SyncOutboxEntriesTableAnnotationComposer,
          $$SyncOutboxEntriesTableCreateCompanionBuilder,
          $$SyncOutboxEntriesTableUpdateCompanionBuilder,
          (
            StoredSyncOutboxEntry,
            BaseReferences<
              _$AppDatabase,
              $SyncOutboxEntriesTable,
              StoredSyncOutboxEntry
            >,
          ),
          StoredSyncOutboxEntry,
          PrefetchHooks Function()
        > {
  $$SyncOutboxEntriesTableTableManager(
    _$AppDatabase db,
    $SyncOutboxEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncOutboxEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncOutboxEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncOutboxEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> mutationId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxEntriesCompanion(
                mutationId: mutationId,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                attempts: attempts,
                createdAt: createdAt,
                nextAttemptAt: nextAttemptAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String mutationId,
                required String entityType,
                required String entityId,
                required String operation,
                required String payloadJson,
                Value<int> attempts = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> nextAttemptAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncOutboxEntriesCompanion.insert(
                mutationId: mutationId,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payloadJson: payloadJson,
                attempts: attempts,
                createdAt: createdAt,
                nextAttemptAt: nextAttemptAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncOutboxEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncOutboxEntriesTable,
      StoredSyncOutboxEntry,
      $$SyncOutboxEntriesTableFilterComposer,
      $$SyncOutboxEntriesTableOrderingComposer,
      $$SyncOutboxEntriesTableAnnotationComposer,
      $$SyncOutboxEntriesTableCreateCompanionBuilder,
      $$SyncOutboxEntriesTableUpdateCompanionBuilder,
      (
        StoredSyncOutboxEntry,
        BaseReferences<
          _$AppDatabase,
          $SyncOutboxEntriesTable,
          StoredSyncOutboxEntry
        >,
      ),
      StoredSyncOutboxEntry,
      PrefetchHooks Function()
    >;
typedef $$SyncStatesTableCreateCompanionBuilder =
    SyncStatesCompanion Function({
      required String accountId,
      Value<int> serverCursor,
      Value<DateTime?> lastSuccessfulSyncAt,
      Value<int> rowid,
    });
typedef $$SyncStatesTableUpdateCompanionBuilder =
    SyncStatesCompanion Function({
      Value<String> accountId,
      Value<int> serverCursor,
      Value<DateTime?> lastSuccessfulSyncAt,
      Value<int> rowid,
    });

class $$SyncStatesTableFilterComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get serverCursor => $composableBuilder(
    column: $table.serverCursor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get accountId => $composableBuilder(
    column: $table.accountId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get serverCursor => $composableBuilder(
    column: $table.serverCursor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncStatesTable> {
  $$SyncStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get accountId =>
      $composableBuilder(column: $table.accountId, builder: (column) => column);

  GeneratedColumn<int> get serverCursor => $composableBuilder(
    column: $table.serverCursor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => column,
  );
}

class $$SyncStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncStatesTable,
          StoredSyncState,
          $$SyncStatesTableFilterComposer,
          $$SyncStatesTableOrderingComposer,
          $$SyncStatesTableAnnotationComposer,
          $$SyncStatesTableCreateCompanionBuilder,
          $$SyncStatesTableUpdateCompanionBuilder,
          (
            StoredSyncState,
            BaseReferences<_$AppDatabase, $SyncStatesTable, StoredSyncState>,
          ),
          StoredSyncState,
          PrefetchHooks Function()
        > {
  $$SyncStatesTableTableManager(_$AppDatabase db, $SyncStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> accountId = const Value.absent(),
                Value<int> serverCursor = const Value.absent(),
                Value<DateTime?> lastSuccessfulSyncAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatesCompanion(
                accountId: accountId,
                serverCursor: serverCursor,
                lastSuccessfulSyncAt: lastSuccessfulSyncAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String accountId,
                Value<int> serverCursor = const Value.absent(),
                Value<DateTime?> lastSuccessfulSyncAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncStatesCompanion.insert(
                accountId: accountId,
                serverCursor: serverCursor,
                lastSuccessfulSyncAt: lastSuccessfulSyncAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncStatesTable,
      StoredSyncState,
      $$SyncStatesTableFilterComposer,
      $$SyncStatesTableOrderingComposer,
      $$SyncStatesTableAnnotationComposer,
      $$SyncStatesTableCreateCompanionBuilder,
      $$SyncStatesTableUpdateCompanionBuilder,
      (
        StoredSyncState,
        BaseReferences<_$AppDatabase, $SyncStatesTable, StoredSyncState>,
      ),
      StoredSyncState,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$ChaptersTableTableManager get chapters =>
      $$ChaptersTableTableManager(_db, _db.chapters);
  $$ContentBlocksTableTableManager get contentBlocks =>
      $$ContentBlocksTableTableManager(_db, _db.contentBlocks);
  $$TocEntriesTableTableManager get tocEntries =>
      $$TocEntriesTableTableManager(_db, _db.tocEntries);
  $$PaginationProfilesTableTableManager get paginationProfiles =>
      $$PaginationProfilesTableTableManager(_db, _db.paginationProfiles);
  $$BookPagesTableTableManager get bookPages =>
      $$BookPagesTableTableManager(_db, _db.bookPages);
  $$ReaderPositionsTableTableManager get readerPositions =>
      $$ReaderPositionsTableTableManager(_db, _db.readerPositions);
  $$VocabularyItemsTableTableManager get vocabularyItems =>
      $$VocabularyItemsTableTableManager(_db, _db.vocabularyItems);
  $$WordOccurrencesTableTableManager get wordOccurrences =>
      $$WordOccurrencesTableTableManager(_db, _db.wordOccurrences);
  $$SrsCardsTableTableManager get srsCards =>
      $$SrsCardsTableTableManager(_db, _db.srsCards);
  $$ReviewEventsTableTableManager get reviewEvents =>
      $$ReviewEventsTableTableManager(_db, _db.reviewEvents);
  $$LocalSettingsTableTableManager get localSettings =>
      $$LocalSettingsTableTableManager(_db, _db.localSettings);
  $$TranslationCacheEntriesTableTableManager get translationCacheEntries =>
      $$TranslationCacheEntriesTableTableManager(
        _db,
        _db.translationCacheEntries,
      );
  $$SyncOutboxEntriesTableTableManager get syncOutboxEntries =>
      $$SyncOutboxEntriesTableTableManager(_db, _db.syncOutboxEntries);
  $$SyncStatesTableTableManager get syncStates =>
      $$SyncStatesTableTableManager(_db, _db.syncStates);
}
