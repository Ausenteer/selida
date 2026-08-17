import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/domain/reader_page.dart';
import 'package:uuid/uuid.dart';

@immutable
final class ReaderPaginationIdentity {
  const ReaderPaginationIdentity({
    required this.fingerprint,
    required this.settingsJson,
  });

  final String fingerprint;
  final String settingsJson;
}

@immutable
final class CachedReaderPageRange {
  const CachedReaderPageRange({
    required this.startOffset,
    required this.endOffset,
  });

  final int startOffset;
  final int endOffset;
}

final class ReaderPaginationCache {
  ReaderPaginationCache(this._database);

  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  ReaderPaginationIdentity identityFor(ReaderLayoutSpec spec) {
    final settings = <String, Object>{
      'algorithmVersion': ReaderPaginator.layoutAlgorithmVersion,
      'width': spec.width,
      'height': spec.height,
      'fontFamily': ReaderPaginator.fontFamilyFor(spec.fontFamily),
      'fontMetricsVersion': 1,
      'fontSize': spec.fontSize,
      'lineHeight': spec.lineHeight,
      'letterSpacing': 0.05,
      'locale': spec.locale.toLanguageTag(),
      'paragraphStyle': spec.paragraphStyle.name,
      'paragraphSpacing': ReaderPaginator.paragraphSpacingFor(
        spec.paragraphStyle,
      ),
      'paragraphIndent': ReaderPaginator.paragraphIndent,
      'textAlignment': spec.textAlignment.name,
    };
    final settingsJson = jsonEncode(settings);
    return ReaderPaginationIdentity(
      fingerprint: sha256.convert(utf8.encode(settingsJson)).toString(),
      settingsJson: settingsJson,
    );
  }

  Future<List<CachedReaderPageRange>?> load({
    required String bookId,
    required String chapterId,
    required ReaderPaginationIdentity identity,
    required int maximumOffset,
  }) async {
    final profile = await _database.paginationProfileFor(
      bookId: bookId,
      fingerprint: identity.fingerprint,
      algorithmVersion: ReaderPaginator.layoutAlgorithmVersion,
    );
    if (profile == null || profile.settingsJson != identity.settingsJson) {
      return null;
    }
    final rows = await _database.pagesForPaginationProfile(
      profileId: profile.id,
      chapterId: chapterId,
    );
    if (rows.isEmpty) {
      return null;
    }
    final result = <CachedReaderPageRange>[];
    var previousEnd = -1;
    for (var index = 0; index < rows.length; index += 1) {
      final row = rows[index];
      if (row.pageIndex != index ||
          row.startOffset < 0 ||
          row.endOffset <= row.startOffset ||
          row.endOffset > maximumOffset ||
          row.startOffset < previousEnd) {
        return null;
      }
      result.add(
        CachedReaderPageRange(
          startOffset: row.startOffset,
          endOffset: row.endOffset,
        ),
      );
      previousEnd = row.endOffset;
    }
    return List<CachedReaderPageRange>.unmodifiable(result);
  }

  Future<void> store({
    required String bookId,
    required String chapterId,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required List<ReaderPage> pages,
  }) {
    return _database.savePaginationPages(
      profileId: _uuid.v7(),
      bookId: bookId,
      chapterId: chapterId,
      fingerprint: identity.fingerprint,
      viewportWidth: spec.width,
      viewportHeight: spec.height,
      settingsJson: identity.settingsJson,
      algorithmVersion: ReaderPaginator.layoutAlgorithmVersion,
      pages: <({String id, int pageIndex, int startOffset, int endOffset})>[
        for (var index = 0; index < pages.length; index += 1)
          (
            id: _uuid.v7(),
            pageIndex: index,
            startOffset: pages[index].startOffset,
            endOffset: pages[index].endOffset,
          ),
      ],
    );
  }
}
