import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/features/reader/application/reader_pagination_cache.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

typedef InitialReaderPageCallback = void Function(int pageIndex);

enum ReaderPaginationSource { cache, generated, prefetch }

@immutable
final class ReaderPaginationMetrics {
  const ReaderPaginationMetrics({
    required this.chapterId,
    required this.source,
    required this.elapsed,
    required this.pageCount,
    required this.frameSlices,
  });

  final String chapterId;
  final ReaderPaginationSource source;
  final Duration elapsed;
  final int pageCount;
  final int frameSlices;
}

final class ReaderPaginationController extends ChangeNotifier {
  ReaderPaginationController({
    required AppDatabase database,
    required this.bookId,
    this.onMetrics,
  }) : _cache = ReaderPaginationCache(database);

  final ReaderPaginationCache _cache;
  final String bookId;
  final ValueChanged<ReaderPaginationMetrics>? onMetrics;

  List<ReaderPage>? _pages;
  ReaderPaginationMetrics? _lastMetrics;
  String? _layoutKey;
  String? _pendingLayoutKey;
  final Set<String> _prefetching = <String>{};
  final Set<String> _prefetched = <String>{};
  var _complete = false;
  var _generation = 0;
  var _disposed = false;

  List<ReaderPage>? get pages => _pages;
  ReaderPaginationMetrics? get lastMetrics => _lastMetrics;
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
    final elapsed = Stopwatch()..start();
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
      elapsed: elapsed,
    );
    if (restored || !_isCurrent(generation)) {
      return;
    }

    final cursor = ReaderPaginator.start(blocks: blocks, spec: spec);
    final generated = <ReaderPage>[];
    var published = false;
    var frameSlices = 0;

    while (!cursor.isComplete) {
      frameSlices += 1;
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
    if (_isCurrent(generation)) {
      _recordMetrics(
        ReaderPaginationMetrics(
          chapterId: chapterId,
          source: ReaderPaginationSource.generated,
          elapsed: elapsed.elapsed,
          pageCount: generated.length,
          frameSlices: frameSlices,
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
    required Stopwatch elapsed,
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
    var frameSlices = 0;
    while (rangeIndex < ranges.length) {
      frameSlices += 1;
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
    _recordMetrics(
      ReaderPaginationMetrics(
        chapterId: chapterId,
        source: ReaderPaginationSource.cache,
        elapsed: elapsed.elapsed,
        pageCount: restoredPages.length,
        frameSlices: frameSlices,
      ),
    );
    return true;
  }

  Future<void> prefetch({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required String chapterId,
    required int chapterLength,
  }) async {
    final key = '$chapterId:${identity.fingerprint}';
    if (_disposed || _prefetched.contains(key) || !_prefetching.add(key)) {
      return;
    }
    final elapsed = Stopwatch()..start();
    var frameSlices = 0;
    try {
      try {
        final cached = await _cache.load(
          bookId: bookId,
          chapterId: chapterId,
          identity: identity,
          maximumOffset: chapterLength,
        );
        if (cached != null) {
          _prefetched.add(key);
          _recordMetrics(
            ReaderPaginationMetrics(
              chapterId: chapterId,
              source: ReaderPaginationSource.prefetch,
              elapsed: elapsed.elapsed,
              pageCount: cached.length,
              frameSlices: 0,
            ),
          );
          return;
        }
      } on Object {
        // A failed cache lookup should not prevent a fresh pagination pass.
      }

      final cursor = ReaderPaginator.start(blocks: blocks, spec: spec);
      final pages = <ReaderPage>[];
      while (!cursor.isComplete && !_disposed) {
        frameSlices += 1;
        final budget = Stopwatch()..start();
        do {
          final page = cursor.nextPage();
          if (page != null) {
            pages.add(page);
          }
        } while (!cursor.isComplete && budget.elapsedMicroseconds < 4000);
        if (!cursor.isComplete && !_disposed) {
          await WidgetsBinding.instance.endOfFrame;
        }
      }
      if (_disposed) {
        return;
      }
      if (pages.isNotEmpty) {
        await _storePaginationSafely(
          chapterId: chapterId,
          spec: spec,
          identity: identity,
          pages: pages,
        );
      }
      _prefetched.add(key);
      _recordMetrics(
        ReaderPaginationMetrics(
          chapterId: chapterId,
          source: ReaderPaginationSource.prefetch,
          elapsed: elapsed.elapsed,
          pageCount: pages.length,
          frameSlices: frameSlices,
        ),
      );
    } finally {
      _prefetching.remove(key);
    }
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

  void _recordMetrics(ReaderPaginationMetrics metrics) {
    if (_disposed) {
      return;
    }
    _lastMetrics = metrics;
    onMetrics?.call(metrics);
    assert(() {
      debugPrint(
        'Reader pagination ${metrics.source.name}: ${metrics.chapterId}, '
        '${metrics.pageCount} pages in ${metrics.elapsed.inMilliseconds} ms '
        'across ${metrics.frameSlices} frame slices',
      );
      return true;
    }());
  }

  bool _isCurrent(int generation) => !_disposed && generation == _generation;

  @override
  void dispose() {
    _disposed = true;
    _generation += 1;
    super.dispose();
  }
}
