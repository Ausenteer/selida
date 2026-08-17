import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/features/reader/application/reader_pagination_cache.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

typedef InitialReaderPageCallback = void Function(int pageIndex);

final class ReaderPaginationController extends ChangeNotifier {
  ReaderPaginationController({
    required AppDatabase database,
    required this.bookId,
  }) : _cache = ReaderPaginationCache(database);

  final ReaderPaginationCache _cache;
  final String bookId;

  List<ReaderPage>? _pages;
  String? _layoutKey;
  String? _pendingLayoutKey;
  var _complete = false;
  var _generation = 0;
  var _disposed = false;

  List<ReaderPage>? get pages => _pages;
  String? get layoutKey => _layoutKey;
  bool get complete => _complete;

  ReaderPaginationIdentity identityFor(ReaderLayoutSpec spec) {
    return _cache.identityFor(spec);
  }

  void schedule({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required String key,
    required String chapterId,
    required int chapterLength,
    required int currentTextOffset,
    required InitialReaderPageCallback onInitialPage,
  }) {
    if ((_layoutKey == key && _complete) || _pendingLayoutKey == key) {
      return;
    }
    final generation = ++_generation;
    _pendingLayoutKey = key;
    _complete = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isCurrent(generation)) {
        return;
      }
      unawaited(
        _paginateIncrementally(
          blocks: blocks,
          spec: spec,
          identity: identity,
          key: key,
          chapterId: chapterId,
          chapterLength: chapterLength,
          currentTextOffset: currentTextOffset,
          generation: generation,
          onInitialPage: onInitialPage,
        ),
      );
    });
  }

  void reset({bool notify = true}) {
    _generation += 1;
    _pages = null;
    _layoutKey = null;
    _pendingLayoutKey = null;
    _complete = false;
    if (notify && !_disposed) {
      notifyListeners();
    }
  }

  Future<void> _paginateIncrementally({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required String key,
    required String chapterId,
    required int chapterLength,
    required int currentTextOffset,
    required int generation,
    required InitialReaderPageCallback onInitialPage,
  }) async {
    final restored = await _restoreCachedPagination(
      blocks: blocks,
      spec: spec,
      identity: identity,
      key: key,
      chapterId: chapterId,
      chapterLength: chapterLength,
      currentTextOffset: currentTextOffset,
      generation: generation,
      onInitialPage: onInitialPage,
    );
    if (restored || !_isCurrent(generation)) {
      return;
    }

    final cursor = ReaderPaginator.start(blocks: blocks, spec: spec);
    final generated = <ReaderPage>[];
    var published = false;

    while (!cursor.isComplete) {
      final budget = Stopwatch()..start();
      do {
        final page = cursor.nextPage();
        if (page != null) {
          generated.add(page);
        }
      } while (!cursor.isComplete && budget.elapsedMicroseconds < 4000);

      if (!_isCurrent(generation)) {
        return;
      }

      final targetPage = generated.indexWhere(
        (ReaderPage page) =>
            currentTextOffset >= page.startOffset &&
            currentTextOffset < page.endOffset,
      );
      final shouldPublish = published || targetPage >= 0 || cursor.isComplete;
      if (shouldPublish) {
        final firstPublication = !published;
        published = true;
        _pages = List<ReaderPage>.unmodifiable(generated);
        _layoutKey = key;
        _complete = cursor.isComplete;
        if (cursor.isComplete) {
          _pendingLayoutKey = null;
        }
        if (firstPublication) {
          onInitialPage(targetPage < 0 ? 0 : targetPage);
        }
        notifyListeners();
      }

      if (!cursor.isComplete) {
        await WidgetsBinding.instance.endOfFrame;
      }
    }

    if (!published && _isCurrent(generation)) {
      _pages = const <ReaderPage>[];
      _layoutKey = key;
      _pendingLayoutKey = null;
      _complete = true;
      notifyListeners();
    }
    if (generated.isNotEmpty && _isCurrent(generation)) {
      unawaited(
        _storePaginationSafely(
          chapterId: chapterId,
          spec: spec,
          identity: identity,
          pages: generated,
        ),
      );
    }
  }

  Future<bool> _restoreCachedPagination({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required String key,
    required String chapterId,
    required int chapterLength,
    required int currentTextOffset,
    required int generation,
    required InitialReaderPageCallback onInitialPage,
  }) async {
    List<CachedReaderPageRange>? ranges;
    try {
      ranges = await _cache.load(
        bookId: bookId,
        chapterId: chapterId,
        identity: identity,
        maximumOffset: chapterLength,
      );
    } on Object {
      return false;
    }
    if (ranges == null || !_isCurrent(generation)) {
      return false;
    }

    final restoredPages = <ReaderPage>[];
    var rangeIndex = 0;
    while (rangeIndex < ranges.length) {
      final budget = Stopwatch()..start();
      do {
        final range = ranges[rangeIndex];
        final page = ReaderPaginator.restorePage(
          blocks: blocks,
          spec: spec,
          startOffset: range.startOffset,
          endOffset: range.endOffset,
        );
        if (page == null) {
          return false;
        }
        restoredPages.add(page);
        rangeIndex += 1;
      } while (rangeIndex < ranges.length && budget.elapsedMicroseconds < 4000);
      if (!_isCurrent(generation)) {
        return false;
      }
      if (rangeIndex < ranges.length) {
        await WidgetsBinding.instance.endOfFrame;
      }
    }

    final targetPage = restoredPages.indexWhere(
      (ReaderPage page) =>
          currentTextOffset >= page.startOffset &&
          currentTextOffset < page.endOffset,
    );
    _pages = List<ReaderPage>.unmodifiable(restoredPages);
    _layoutKey = key;
    _pendingLayoutKey = null;
    _complete = true;
    onInitialPage(targetPage < 0 ? 0 : targetPage);
    notifyListeners();
    return true;
  }

  Future<void> _storePaginationSafely({
    required String chapterId,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required List<ReaderPage> pages,
  }) async {
    try {
      await _cache.store(
        bookId: bookId,
        chapterId: chapterId,
        spec: spec,
        identity: identity,
        pages: pages,
      );
    } on Object catch (error) {
      debugPrint('Could not cache reader pagination: $error');
    }
  }

  bool _isCurrent(int generation) => !_disposed && generation == _generation;

  @override
  void dispose() {
    _disposed = true;
    _generation += 1;
    super.dispose();
  }
}
