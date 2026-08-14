import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/dictionary/application/vocabulary_service.dart';
import 'package:selida/features/reader/application/reader_pagination_cache.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/application/reader_providers.dart';
import 'package:selida/features/reader/domain/reader_page.dart';
import 'package:selida/features/reader/domain/reader_preferences.dart';
import 'package:selida/features/reader/presentation/reader_page_surface.dart';
import 'package:selida/features/reader/presentation/word_popover_placement.dart';
import 'package:selida/features/translation/application/translation_service.dart';
import 'package:selida/features/translation/domain/word_translation.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

final class ReaderScreen extends ConsumerWidget {
  const ReaderScreen({required this.bookId, super.key});

  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final document = ref.watch(readerDocumentProvider(bookId));
    return document.when(
      data: (ReaderDocument? value) => value == null || value.chapters.isEmpty
          ? const _ReaderError()
          : _LoadedReader(document: value),
      error: (_, _) => const _ReaderError(),
      loading: _ReaderLoading.new,
    );
  }
}

final class _LoadedReader extends ConsumerStatefulWidget {
  const _LoadedReader({required this.document});

  final ReaderDocument document;

  @override
  ConsumerState<_LoadedReader> createState() => _LoadedReaderState();
}

final class _LoadedReaderState extends ConsumerState<_LoadedReader> {
  static const double _readerTopInset = 60;
  static const double _readerBottomInset = 52;

  late final PageController _pageController;
  late final AppDatabase _database;
  late final ReaderPaginationCache _paginationCache;
  late String _bookLanguage;
  late int _chapterIndex;
  var _currentPageIndex = 0;
  var _currentTextOffset = 0;
  var _paginationComplete = false;
  var _paginationGeneration = 0;
  ReaderTextRange? _activeSelection;
  ReaderTextRange? _focusedWordRange;
  var _selectionActionsVisible = false;
  final List<_ReaderLocation> _navigationHistory = <_ReaderLocation>[];
  int? _brightnessPointer;
  double? _lastBrightnessY;
  String? _layoutKey;
  String? _pendingLayoutKey;
  List<ReaderPage>? _pages;
  OverlayEntry? _wordPopover;
  double _boundarySwipeDistance = 0;
  int _boundarySwipeDirection = 0;

  StoredChapter get _chapter => widget.document.chapters[_chapterIndex];

  @override
  void initState() {
    super.initState();
    _database = ref.read(databaseProvider);
    _paginationCache = ReaderPaginationCache(_database);
    _bookLanguage = _translationLanguage(widget.document.book.language);
    final savedPosition = widget.document.position;
    final savedChapterIndex = savedPosition == null
        ? -1
        : widget.document.chapters.indexWhere(
            (StoredChapter chapter) => chapter.id == savedPosition.chapterId,
          );
    _chapterIndex = savedChapterIndex < 0 ? 0 : savedChapterIndex;
    _currentTextOffset = _chapterIndex == savedChapterIndex
        ? savedPosition?.textOffset ?? 0
        : 0;
    _pageController = PageController();
    unawaited(_database.markBookOpened(widget.document.book.id));
  }

  @override
  void dispose() {
    _paginationGeneration += 1;
    _wordPopover?.remove();
    unawaited(_persistReaderPosition());
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = ref.watch(readerPreferencesProvider);
    final palette = ReaderPalette.forTheme(preferences.theme);
    final blocks = ref.watch(chapterBlocksProvider(_chapter.id));
    final savedOccurrences = ref.watch(
      chapterVocabularyOccurrencesProvider(
        ChapterVocabularyQuery(
          bookId: widget.document.book.id,
          chapterId: _chapter.id,
          chapterTitle: _chapter.title,
        ),
      ),
    );
    final isDark = preferences.theme == ReaderTheme.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: palette.background,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: palette.background,
        body: blocks.when(
          data: (List<ReaderBlock> value) => _buildReader(
            context: context,
            blocks: value,
            savedOccurrences:
                savedOccurrences.value ?? const <StoredWordOccurrence>[],
            preferences: preferences,
            palette: palette,
          ),
          error: (_, _) => const _ReaderError(),
          loading: () => _ReaderLoading(backgroundColor: palette.background),
        ),
      ),
    );
  }

  Widget _buildReader({
    required BuildContext context,
    required List<ReaderBlock> blocks,
    required List<StoredWordOccurrence> savedOccurrences,
    required ReaderPreferences preferences,
    required ReaderPalette palette,
  }) {
    final media = MediaQuery.of(context);
    final effectiveFontSize = media.textScaler.scale(preferences.fontSize);
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _onBrightnessPointerDown,
      onPointerMove: _onBrightnessPointerMove,
      onPointerUp: _onBrightnessPointerEnd,
      onPointerCancel: _onBrightnessPointerEnd,
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                preferences.horizontalMargin,
                _readerTopInset,
                preferences.horizontalMargin,
                _readerBottomInset,
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final spec = ReaderLayoutSpec(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    fontSize: effectiveFontSize,
                    lineHeight: preferences.lineHeight,
                    locale: Locale(_bookLanguage),
                    textColor: palette.text,
                    paragraphStyle: preferences.paragraphStyle,
                  );
                  final identity = _paginationCache.identityFor(spec);
                  final key = '${_chapter.id}:${identity.fingerprint}';
                  _schedulePagination(
                    blocks: blocks,
                    spec: spec,
                    identity: identity,
                    key: key,
                  );
                  final pages = _layoutKey == key ? _pages : null;
                  if (pages == null || pages.isEmpty) {
                    return _ReaderPageSkeleton(color: palette.skeleton);
                  }
                  return NotificationListener<ScrollNotification>(
                    onNotification: _onPageScrollNotification,
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const PageScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: pages.length,
                      onPageChanged: (int index) =>
                          _onPageChanged(pages, index),
                      itemBuilder: (BuildContext context, int index) {
                        return ReaderPageSurface(
                          page: pages[index],
                          spec: spec,
                          activeSelection: _activeSelection,
                          selectionIsControlled: true,
                          selectionHandlesVisible: _selectionActionsVisible,
                          focusedRange: _focusedWordRange,
                          focusedColor: palette.accent.withValues(alpha: 0.16),
                          savedRanges: <ReaderTextRange>[
                            for (final occurrence in savedOccurrences)
                              if (occurrence.sourceOffset case final offset?)
                                ReaderTextRange(
                                  startOffset: offset,
                                  endOffset:
                                      offset + occurrence.surfaceForm.length,
                                ),
                          ],
                          selectionColor: palette.accent.withValues(alpha: 0.2),
                          savedUnderlineColor: palette.savedUnderline,
                          onWordTap: (ReaderWordHit hit) => _showWordPopover(
                            hit: hit,
                            horizontalMargin: preferences.horizontalMargin,
                            palette: palette,
                            savedOccurrence: _occurrenceAt(
                              savedOccurrences,
                              hit.startOffset,
                            ),
                            savedOccurrences: savedOccurrences,
                          ),
                          onTextSelected: (ReaderTextSelection selection) =>
                              unawaited(
                                _showTextAssistance(
                                  selection,
                                  savedOccurrences: savedOccurrences,
                                  canSavePhrase: true,
                                ),
                              ),
                          onSelectionChanged: (ReaderTextRange? selection) {
                            setState(() {
                              _activeSelection = selection;
                              _selectionActionsVisible = selection != null;
                            });
                          },
                          onSelectionReady: () => setState(() {
                            _selectionActionsVisible = _activeSelection != null;
                          }),
                          onSelectionEdgeRequested: (int direction) =>
                              _extendSelectionAcrossPage(
                                pages: pages,
                                direction: direction,
                                animate: preferences.pageAnimationEnabled,
                              ),
                          onBlankTap: (_) => _onBlankTap(),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: ColoredBox(
                color: Colors.black.withValues(
                  alpha: (1 - preferences.brightness) * 0.72,
                ),
              ),
            ),
          ),
          _SelectionActions(
            visible: _selectionActionsVisible && _activeSelection != null,
            palette: palette,
            onTranslate: () {
              final selection = _activeSelection;
              if (selection != null) {
                unawaited(
                  _showTextAssistance(
                    ReaderTextSelection(
                      startOffset: selection.startOffset,
                      endOffset: selection.endOffset,
                    ),
                    savedOccurrences: savedOccurrences,
                    canSavePhrase: true,
                  ),
                );
              }
            },
            onClose: _clearSelection,
          ),
          _ReaderChrome(
            title: widget.document.book.title,
            chapterTitle: _chapter.title,
            progress: _bookProgress(_currentTextOffset),
            pageNumber: _currentPageIndex + 1,
            pageCount: _paginationComplete ? _pages?.length : null,
            chapterNumber: _chapterIndex + 1,
            chapterCount: widget.document.chapters.length,
            canReturnToPreviousLocation: _navigationHistory.isNotEmpty,
            palette: palette,
            onBack: () {
              _dismissWordPopover();
              context.pop();
            },
            onReturnToPreviousLocation: _returnToPreviousLocation,
            onContents: () {
              _dismissWordPopover();
              unawaited(_showContents());
            },
            onSettings: () {
              _dismissWordPopover();
              unawaited(_showSettings());
            },
            onProgressChanged: _seekToBookProgress,
            chapterForProgress: _chapterNumberForBookProgress,
          ),
        ],
      ),
    );
  }

  void _schedulePagination({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required String key,
  }) {
    if ((_layoutKey == key && _paginationComplete) ||
        _pendingLayoutKey == key) {
      return;
    }
    final generation = ++_paginationGeneration;
    _pendingLayoutKey = key;
    _paginationComplete = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      unawaited(
        _paginateIncrementally(
          blocks: blocks,
          spec: spec,
          identity: identity,
          key: key,
          chapterId: _chapter.id,
          chapterLength: _chapter.lengthUtf16,
          generation: generation,
        ),
      );
    });
  }

  Future<void> _paginateIncrementally({
    required List<ReaderBlock> blocks,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required String key,
    required String chapterId,
    required int chapterLength,
    required int generation,
  }) async {
    final restored = await _restoreCachedPagination(
      blocks: blocks,
      spec: spec,
      identity: identity,
      key: key,
      chapterId: chapterId,
      chapterLength: chapterLength,
      generation: generation,
    );
    if (restored || !mounted || generation != _paginationGeneration) {
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

      if (!mounted || generation != _paginationGeneration) {
        return;
      }

      final targetPage = generated.indexWhere(
        (ReaderPage page) =>
            _currentTextOffset >= page.startOffset &&
            _currentTextOffset < page.endOffset,
      );
      final shouldPublish = published || targetPage >= 0 || cursor.isComplete;
      if (shouldPublish) {
        final firstPublication = !published;
        published = true;
        setState(() {
          _pages = List<ReaderPage>.unmodifiable(generated);
          _layoutKey = key;
          _paginationComplete = cursor.isComplete;
          if (cursor.isComplete) {
            _pendingLayoutKey = null;
          }
          if (firstPublication) {
            _currentPageIndex = targetPage < 0 ? 0 : targetPage;
          }
        });
        if (firstPublication) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted &&
                generation == _paginationGeneration &&
                _pageController.hasClients &&
                generated.isNotEmpty) {
              _pageController.jumpToPage(_currentPageIndex);
            }
          });
        }
      }

      if (!cursor.isComplete) {
        await WidgetsBinding.instance.endOfFrame;
      }
    }

    if (!published && mounted && generation == _paginationGeneration) {
      setState(() {
        _pages = const <ReaderPage>[];
        _layoutKey = key;
        _pendingLayoutKey = null;
        _paginationComplete = true;
      });
    }
    if (generated.isNotEmpty && generation == _paginationGeneration) {
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
    required int generation,
  }) async {
    List<CachedReaderPageRange>? ranges;
    try {
      ranges = await _paginationCache.load(
        bookId: widget.document.book.id,
        chapterId: chapterId,
        identity: identity,
        maximumOffset: chapterLength,
      );
    } on Object {
      return false;
    }
    if (ranges == null || !mounted || generation != _paginationGeneration) {
      return false;
    }

    final pages = <ReaderPage>[];
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
        pages.add(page);
        rangeIndex += 1;
      } while (rangeIndex < ranges.length && budget.elapsedMicroseconds < 4000);
      if (!mounted || generation != _paginationGeneration) {
        return false;
      }
      if (rangeIndex < ranges.length) {
        await WidgetsBinding.instance.endOfFrame;
      }
    }

    final targetPage = pages.indexWhere(
      (ReaderPage page) =>
          _currentTextOffset >= page.startOffset &&
          _currentTextOffset < page.endOffset,
    );
    setState(() {
      _pages = List<ReaderPage>.unmodifiable(pages);
      _layoutKey = key;
      _pendingLayoutKey = null;
      _paginationComplete = true;
      _currentPageIndex = targetPage < 0 ? 0 : targetPage;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted &&
          generation == _paginationGeneration &&
          _pageController.hasClients) {
        _pageController.jumpToPage(_currentPageIndex);
      }
    });
    return true;
  }

  Future<void> _storePaginationSafely({
    required String chapterId,
    required ReaderLayoutSpec spec,
    required ReaderPaginationIdentity identity,
    required List<ReaderPage> pages,
  }) async {
    try {
      await _paginationCache.store(
        bookId: widget.document.book.id,
        chapterId: chapterId,
        spec: spec,
        identity: identity,
        pages: pages,
      );
    } on Object catch (error) {
      debugPrint('Could not cache reader pagination: $error');
    }
  }

  void _onPageChanged(List<ReaderPage> pages, int index) {
    _dismissWordPopover();
    final offset = pages[index].startOffset;
    setState(() {
      _currentPageIndex = index;
      _currentTextOffset = offset;
    });
    final progress = _bookProgress(offset);
    unawaited(_persistReaderPosition(progress: progress));
  }

  bool _onPageScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      _boundarySwipeDistance = 0;
      _boundarySwipeDirection = 0;
      _dismissWordPopover();
      return false;
    }
    if (notification is OverscrollNotification &&
        notification.dragDetails != null) {
      final direction = notification.overscroll > 0 ? 1 : -1;
      final pages = _pages;
      final atPageBoundary =
          pages != null &&
          pages.isNotEmpty &&
          (direction > 0
              ? _currentPageIndex == pages.length - 1 && _paginationComplete
              : _currentPageIndex == 0);
      final hasAdjacentChapter =
          _chapterIndex + direction >= 0 &&
          _chapterIndex + direction < widget.document.chapters.length;
      if (atPageBoundary && hasAdjacentChapter) {
        if (_boundarySwipeDirection != direction) {
          _boundarySwipeDistance = 0;
        }
        _boundarySwipeDirection = direction;
        _boundarySwipeDistance += notification.overscroll.abs();
      }
      return false;
    }
    if (notification is ScrollEndNotification) {
      final direction = _boundarySwipeDirection;
      final shouldChangeChapter =
          direction != 0 &&
          _boundarySwipeDistance >= 32 &&
          _chapterIndex + direction >= 0 &&
          _chapterIndex + direction < widget.document.chapters.length;
      _boundarySwipeDistance = 0;
      _boundarySwipeDirection = 0;
      if (shouldChangeChapter) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final target = _chapterIndex + direction;
            final targetChapter = widget.document.chapters[target];
            _openChapter(
              target,
              textOffset: direction < 0
                  ? math.max(0, targetChapter.lengthUtf16 - 1)
                  : 0,
            );
          }
        });
      }
    }
    return false;
  }

  void _onBlankTap() {
    _dismissWordPopover();
    if (_activeSelection != null) {
      _clearSelection();
    }
  }

  void _openChapter(
    int target, {
    int textOffset = 0,
    bool rememberCurrentLocation = false,
  }) {
    if (target < 0 || target >= widget.document.chapters.length) {
      return;
    }
    if (rememberCurrentLocation) {
      _navigationHistory.add(
        _ReaderLocation(
          chapterIndex: _chapterIndex,
          textOffset: _currentTextOffset,
        ),
      );
    }
    final chapter = widget.document.chapters[target];
    _dismissWordPopover();
    setState(() {
      _chapterIndex = target;
      _currentPageIndex = 0;
      _currentTextOffset = textOffset.clamp(0, chapter.lengthUtf16);
      _pages = null;
      _layoutKey = null;
      _pendingLayoutKey = null;
      _paginationComplete = false;
      _paginationGeneration += 1;
      _activeSelection = null;
      _selectionActionsVisible = false;
    });
    unawaited(_persistReaderPosition());
  }

  void _returnToPreviousLocation() {
    if (_navigationHistory.isEmpty) {
      return;
    }
    final location = _navigationHistory.removeLast();
    _openChapter(location.chapterIndex, textOffset: location.textOffset);
  }

  void _turnToPage(int page, {required bool animate}) {
    if (!_pageController.hasClients) {
      return;
    }
    if (animate) {
      unawaited(
        _pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 125),
          curve: Curves.easeOutCubic,
        ),
      );
    } else {
      _pageController.jumpToPage(page);
    }
  }

  void _clearSelection() {
    if (!mounted) {
      return;
    }
    setState(() {
      _activeSelection = null;
      _selectionActionsVisible = false;
    });
  }

  void _extendSelectionAcrossPage({
    required List<ReaderPage> pages,
    required int direction,
    required bool animate,
  }) {
    final selection = _activeSelection;
    final targetIndex = _currentPageIndex + direction;
    if (selection == null || targetIndex < 0 || targetIndex >= pages.length) {
      return;
    }
    final page = pages[targetIndex];
    final boundary = _wordAtPageBoundary(page, fromStart: direction > 0);
    if (boundary == null) {
      return;
    }
    final updated = direction > 0
        ? ReaderTextRange(
            startOffset: selection.startOffset,
            endOffset: math.min(
              math.max(selection.endOffset, boundary.endOffset),
              selection.startOffset + 1000,
            ),
          )
        : ReaderTextRange(
            startOffset: math.max(
              math.min(selection.startOffset, boundary.startOffset),
              selection.endOffset - 1000,
            ),
            endOffset: selection.endOffset,
          );
    setState(() {
      _activeSelection = updated;
      _selectionActionsVisible = true;
    });
    _turnToPage(targetIndex, animate: animate);
  }

  ReaderTextRange? _wordAtPageBoundary(
    ReaderPage page, {
    required bool fromStart,
  }) {
    final text = _chapter.plainText;
    if (text.isEmpty) {
      return null;
    }
    if (fromStart) {
      var start = page.startOffset.clamp(0, text.length);
      final endLimit = page.endOffset.clamp(start, text.length);
      while (start < endLimit && !_isWordRune(text.codeUnitAt(start))) {
        start += 1;
      }
      var end = start;
      while (end < endLimit && _isWordRune(text.codeUnitAt(end))) {
        end += 1;
      }
      return end > start
          ? ReaderTextRange(startOffset: start, endOffset: end)
          : null;
    }
    var end = page.endOffset.clamp(0, text.length);
    final startLimit = page.startOffset.clamp(0, end);
    while (end > startLimit && !_isWordRune(text.codeUnitAt(end - 1))) {
      end -= 1;
    }
    var start = end;
    while (start > startLimit && _isWordRune(text.codeUnitAt(start - 1))) {
      start -= 1;
    }
    return end > start
        ? ReaderTextRange(startOffset: start, endOffset: end)
        : null;
  }

  bool _isWordRune(int rune) {
    return (rune >= 0x0041 && rune <= 0x005a) ||
        (rune >= 0x0061 && rune <= 0x007a) ||
        (rune >= 0x0370 && rune <= 0x03ff) ||
        (rune >= 0x1f00 && rune <= 0x1fff) ||
        (rune >= 0x0400 && rune <= 0x052f) ||
        rune == 0x0027 ||
        rune == 0x2019 ||
        rune == 0x002d;
  }

  StoredWordOccurrence? _occurrenceAt(
    List<StoredWordOccurrence> occurrences,
    int offset,
  ) {
    for (final occurrence in occurrences) {
      if (occurrence.sourceOffset == offset) {
        return occurrence;
      }
    }
    return null;
  }

  StoredWordOccurrence? _occurrenceMatching(
    List<StoredWordOccurrence> occurrences,
    int offset,
    String surface,
  ) {
    for (final occurrence in occurrences) {
      if (occurrence.sourceOffset == offset &&
          occurrence.surfaceForm == surface) {
        return occurrence;
      }
    }
    return null;
  }

  void _onBrightnessPointerDown(PointerDownEvent event) {
    final width = MediaQuery.sizeOf(context).width;
    if (event.position.dx >= width - 30) {
      _brightnessPointer = event.pointer;
      _lastBrightnessY = event.position.dy;
    }
  }

  void _onBrightnessPointerMove(PointerMoveEvent event) {
    if (_brightnessPointer != event.pointer || _lastBrightnessY == null) {
      return;
    }
    final delta = (_lastBrightnessY! - event.position.dy) / 260;
    if (delta.abs() < 0.002) {
      return;
    }
    _lastBrightnessY = event.position.dy;
    final notifier = ref.read(readerPreferencesProvider.notifier);
    final current = ref.read(readerPreferencesProvider).brightness;
    notifier.setBrightness(current + delta);
  }

  void _onBrightnessPointerEnd(PointerEvent event) {
    if (_brightnessPointer == event.pointer) {
      _brightnessPointer = null;
      _lastBrightnessY = null;
    }
  }

  Future<void> _persistReaderPosition({double? progress}) async {
    await _database.saveReaderPosition(
      bookId: widget.document.book.id,
      chapterId: _chapter.id,
      textOffset: _currentTextOffset,
      progress: progress ?? _bookProgress(_currentTextOffset),
    );
    if (mounted) {
      ref.invalidate(readerPositionProvider(widget.document.book.id));
    }
  }

  double _bookProgress(int chapterOffset) {
    var consumed = chapterOffset;
    for (var index = 0; index < _chapterIndex; index += 1) {
      consumed += widget.document.chapters[index].lengthUtf16;
    }
    final total = _totalBookLength;
    return total <= 0 ? 0 : (consumed / total).clamp(0, 1);
  }

  int get _totalBookLength => widget.document.chapters.fold<int>(
    0,
    (int total, StoredChapter chapter) => total + chapter.lengthUtf16,
  );

  _ReaderLocation _locationForBookProgress(double progress) {
    final chapters = widget.document.chapters;
    if (chapters.isEmpty) {
      return const _ReaderLocation(chapterIndex: 0, textOffset: 0);
    }
    final total = _totalBookLength;
    if (total <= 0) {
      return _ReaderLocation(chapterIndex: _chapterIndex, textOffset: 0);
    }
    final target = (progress.clamp(0, 1) * math.max(0, total - 1)).round();
    var consumed = 0;
    for (var index = 0; index < chapters.length; index += 1) {
      final chapterLength = chapters[index].lengthUtf16;
      final isLast = index == chapters.length - 1;
      if (target < consumed + chapterLength || isLast) {
        return _ReaderLocation(
          chapterIndex: index,
          textOffset: (target - consumed).clamp(
            0,
            math.max(0, chapterLength - 1),
          ),
        );
      }
      consumed += chapterLength;
    }
    return _ReaderLocation(
      chapterIndex: chapters.length - 1,
      textOffset: math.max(0, chapters.last.lengthUtf16 - 1),
    );
  }

  int _chapterNumberForBookProgress(double progress) {
    return _locationForBookProgress(progress).chapterIndex + 1;
  }

  void _seekToBookProgress(double progress) {
    final location = _locationForBookProgress(progress);
    unawaited(HapticFeedback.selectionClick());
    if (location.chapterIndex != _chapterIndex) {
      _openChapter(
        location.chapterIndex,
        textOffset: location.textOffset,
        rememberCurrentLocation: true,
      );
      return;
    }

    final pages = _pages;
    final pageIndex = pages?.indexWhere(
      (ReaderPage page) =>
          location.textOffset >= page.startOffset &&
          location.textOffset < page.endOffset,
    );
    _dismissWordPopover();
    _clearSelection();
    if (pageIndex == null || pageIndex < 0) {
      setState(() {
        _currentPageIndex = 0;
        _currentTextOffset = location.textOffset;
        _pages = null;
        _layoutKey = null;
        _pendingLayoutKey = null;
        _paginationComplete = false;
        _paginationGeneration += 1;
      });
      unawaited(_persistReaderPosition());
      return;
    }
    setState(() {
      _currentTextOffset = location.textOffset;
      _currentPageIndex = pageIndex;
    });
    _turnToPage(
      pageIndex,
      animate: ref.read(readerPreferencesProvider).pageAnimationEnabled,
    );
    unawaited(_persistReaderPosition());
  }

  void _showWordPopover({
    required ReaderWordHit hit,
    required double horizontalMargin,
    required ReaderPalette palette,
    required StoredWordOccurrence? savedOccurrence,
    required List<StoredWordOccurrence> savedOccurrences,
  }) {
    _wordPopover?.remove();
    _wordPopover = null;
    setState(() {
      _focusedWordRange = ReaderTextRange(
        startOffset: hit.startOffset,
        endOffset: hit.endOffset,
      );
    });
    final overlay = Overlay.of(context);
    final media = MediaQuery.of(context);
    final wordRect = hit.rect.shift(
      Offset(horizontalMargin, media.padding.top + _readerTopInset),
    );
    final placement = calculateWordPopoverPlacement(
      screenSize: media.size,
      safePadding: media.padding,
      wordRect: wordRect,
    );
    final sentence = sentenceContextAround(
      text: _chapter.plainText,
      startOffset: hit.startOffset,
      endOffset: hit.endOffset,
    );
    final request = WordTranslationRequest(
      sourceLanguage: _bookLanguage,
      targetLanguage: 'ru',
      interfaceLanguage: Localizations.localeOf(context).languageCode == 'en'
          ? 'en'
          : 'ru',
      source: hit.word,
      context: sentence.text,
    );
    _wordPopover = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: media.padding.top + 66,
            bottom: media.padding.bottom + 50,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _dismissWordPopover,
              child: const ColoredBox(color: Colors.transparent),
            ),
          ),
          Positioned.fill(
            child: CustomSingleChildLayout(
              delegate: _WordPopoverLayoutDelegate(
                placement: placement,
                wordRect: wordRect,
                safePadding: media.padding,
              ),
              child: Material(
                color: Colors.transparent,
                child: _AnchoredWordPopover(
                  showBelow: placement.showBelow,
                  caretX: placement.caretX,
                  palette: palette,
                  child: _WordTranslationPopover(
                    request: request,
                    surfaceForm: hit.word,
                    contextWordStart: hit.startOffset - sentence.startOffset,
                    sourceBookId: widget.document.book.id,
                    sourceBookTitle: widget.document.book.title,
                    sourceChapterId: _chapter.id,
                    sourceChapterTitle: _chapter.title,
                    sourceOffset: hit.startOffset,
                    palette: palette,
                    savedOccurrence: savedOccurrence,
                    onTranslateSentence: () => unawaited(
                      _showTextAssistance(
                        ReaderTextSelection(
                          startOffset: sentence.startOffset,
                          endOffset: sentence.endOffset,
                        ),
                        savedOccurrences: savedOccurrences,
                        canSavePhrase: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    overlay.insert(_wordPopover!);
  }

  String _translationLanguage(String language) {
    final normalized = language.toLowerCase();
    return normalized.startsWith('el') || normalized.startsWith('gr')
        ? 'el'
        : 'en';
  }

  void _dismissWordPopover() {
    _wordPopover?.remove();
    _wordPopover = null;
    if (mounted && _focusedWordRange != null) {
      setState(() => _focusedWordRange = null);
    }
  }

  Future<void> _showTextAssistance(
    ReaderTextSelection selection, {
    required List<StoredWordOccurrence> savedOccurrences,
    bool canSavePhrase = false,
  }) async {
    _dismissWordPopover();
    final chapterText = _chapter.plainText;
    final start = selection.startOffset.clamp(0, chapterText.length);
    final end = selection.endOffset.clamp(start, chapterText.length);
    if (end <= start) {
      return;
    }
    final source = chapterText.substring(start, end).trim();
    if (source.isEmpty) {
      return;
    }
    final sentenceContext = sentenceContextAround(
      text: chapterText,
      startOffset: start,
      endOffset: end,
    );
    final contextSentence = sentenceContext.text;
    final request = TextAssistanceRequest(
      sourceLanguage: _bookLanguage,
      targetLanguage: 'ru',
      interfaceLanguage: Localizations.localeOf(context).languageCode == 'en'
          ? 'en'
          : 'ru',
      source: source.length > 1000 ? source.substring(0, 1000) : source,
      context: contextSentence,
    );
    final savedOccurrence = _occurrenceMatching(
      savedOccurrences,
      start,
      request.source,
    );
    final savesAsWord = isSingleVocabularyItem(request.source);
    if (mounted) {
      setState(() => _selectionActionsVisible = false);
    }
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: false,
      builder: (BuildContext context) => _TextAssistanceSheet(
        request: request,
        sourceText: request.source,
        savesAsWord: savesAsWord,
        savedOccurrence: savedOccurrence,
        onSave: canSavePhrase
            ? (FragmentTranslation translation) async {
                final service = ref.read(vocabularyServiceProvider);
                final vocabularyId = await service.savePhrase(
                  request: request,
                  translation: translation,
                  contextSentence: contextSentence,
                  contextPhraseStart: start - sentenceContext.startOffset,
                  sourceBookId: widget.document.book.id,
                  sourceBookTitle: widget.document.book.title,
                  sourceChapterId: _chapter.id,
                  sourceChapterTitle: _chapter.title,
                  sourceOffset: start,
                  savesAsWord: savesAsWord,
                );
                return service.occurrenceAt(
                  vocabularyId: vocabularyId,
                  sourceBookId: widget.document.book.id,
                  sourceOffset: start,
                );
              }
            : null,
        onRemove: (StoredWordOccurrence occurrence) =>
            ref.read(vocabularyServiceProvider).removeOccurrence(occurrence),
      ),
    );
    _clearSelection();
  }

  Future<void> _showContents() async {
    final selected = await showModalBottomSheet<_ReaderLocation>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        final strings = AppLocalizations.of(context);
        final usableToc = widget.document.toc
            .where((StoredTocEntry entry) => entry.chapterId != null)
            .toList();
        final useToc = usableToc.isNotEmpty;
        return FractionallySizedBox(
          heightFactor: 0.62,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 4, 22, 12),
                child: Text(
                  strings.contents,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: useToc
                      ? usableToc.length
                      : widget.document.chapters.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (useToc) {
                      final entry = usableToc[index];
                      final chapterIndex = widget.document.chapters.indexWhere(
                        (StoredChapter chapter) =>
                            chapter.id == entry.chapterId,
                      );
                      return ListTile(
                        contentPadding: EdgeInsets.only(
                          left: 20 + entry.depth * 18,
                          right: 20,
                        ),
                        selected: chapterIndex == _chapterIndex,
                        title: Text(entry.title),
                        onTap: chapterIndex < 0
                            ? null
                            : () => Navigator.of(context).pop(
                                _ReaderLocation(
                                  chapterIndex: chapterIndex,
                                  textOffset: entry.textOffset,
                                ),
                              ),
                      );
                    }
                    final chapter = widget.document.chapters[index];
                    return ListTile(
                      selected: index == _chapterIndex,
                      title: Text(
                        chapter.title ?? '${strings.chapter} ${index + 1}',
                      ),
                      onTap: () => Navigator.of(context).pop(
                        _ReaderLocation(chapterIndex: index, textOffset: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    if (selected != null) {
      _openChapter(
        selected.chapterIndex,
        textOffset: selected.textOffset,
        rememberCurrentLocation: true,
      );
    }
  }

  Future<void> _showSettings() {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => _ReaderSettingsSheet(
        bookLanguage: _bookLanguage,
        onBookLanguageChanged: _changeBookLanguage,
      ),
    );
  }

  Future<void> _changeBookLanguage(String language) async {
    if (language == _bookLanguage) {
      return;
    }
    await _database.updateBookLanguage(widget.document.book.id, language);
    if (mounted) {
      setState(() {
        _bookLanguage = language;
        _pages = null;
        _layoutKey = null;
        _pendingLayoutKey = null;
        _paginationComplete = false;
        _paginationGeneration += 1;
      });
      ref.invalidate(readerDocumentProvider(widget.document.book.id));
    }
  }
}

final class _WordPopoverLayoutDelegate extends SingleChildLayoutDelegate {
  const _WordPopoverLayoutDelegate({
    required this.placement,
    required this.wordRect,
    required this.safePadding,
  });

  final WordPopoverPlacement placement;
  final Rect wordRect;
  final EdgeInsets safePadding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: placement.width,
      maxWidth: placement.width,
      maxHeight: math.max(0, constraints.maxHeight - safePadding.vertical - 12),
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return calculateWordPopoverOffset(
      screenSize: size,
      safePadding: safePadding,
      wordRect: wordRect,
      popoverSize: childSize,
      placement: placement,
    );
  }

  @override
  bool shouldRelayout(_WordPopoverLayoutDelegate oldDelegate) {
    return oldDelegate.placement.left != placement.left ||
        oldDelegate.placement.width != placement.width ||
        oldDelegate.placement.showBelow != placement.showBelow ||
        oldDelegate.wordRect != wordRect ||
        oldDelegate.safePadding != safePadding;
  }
}

final class _AnchoredWordPopover extends StatelessWidget {
  const _AnchoredWordPopover({
    required this.showBelow,
    required this.caretX,
    required this.palette,
    required this.child,
  });

  final bool showBelow;
  final double caretX;
  final ReaderPalette palette;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final caret = Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: caretX - 8),
        child: CustomPaint(
          size: const Size(16, 8),
          painter: _PopoverCaretPainter(
            pointsUp: showBelow,
            fillColor: palette.popover,
            borderColor: palette.border,
          ),
        ),
      ),
    );
    final card = DecoratedBox(
      decoration: BoxDecoration(
        color: palette.popover,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.border),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: showBelow
          ? <Widget>[
              caret,
              Transform.translate(offset: const Offset(0, -1), child: card),
            ]
          : <Widget>[
              card,
              Transform.translate(offset: const Offset(0, 1), child: caret),
            ],
    );
  }
}

final class _PopoverCaretPainter extends CustomPainter {
  const _PopoverCaretPainter({
    required this.pointsUp,
    required this.fillColor,
    required this.borderColor,
  });

  final bool pointsUp;
  final Color fillColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    if (pointsUp) {
      path
        ..moveTo(size.width / 2, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height);
    } else {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width / 2, size.height);
    }
    path.close();
    canvas
      ..drawPath(path, Paint()..color = fillColor)
      ..drawPath(
        path,
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
  }

  @override
  bool shouldRepaint(_PopoverCaretPainter oldDelegate) {
    return oldDelegate.pointsUp != pointsUp ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.borderColor != borderColor;
  }
}

final class _WordTranslationPopover extends ConsumerStatefulWidget {
  const _WordTranslationPopover({
    required this.request,
    required this.surfaceForm,
    required this.contextWordStart,
    required this.sourceBookId,
    required this.sourceBookTitle,
    required this.sourceChapterId,
    required this.sourceChapterTitle,
    required this.sourceOffset,
    required this.palette,
    required this.savedOccurrence,
    required this.onTranslateSentence,
  });

  final WordTranslationRequest request;
  final String surfaceForm;
  final int contextWordStart;
  final String sourceBookId;
  final String sourceBookTitle;
  final String sourceChapterId;
  final String? sourceChapterTitle;
  final int sourceOffset;
  final ReaderPalette palette;
  final StoredWordOccurrence? savedOccurrence;
  final VoidCallback onTranslateSentence;

  @override
  ConsumerState<_WordTranslationPopover> createState() =>
      _WordTranslationPopoverState();
}

final class _WordTranslationPopoverState
    extends ConsumerState<_WordTranslationPopover> {
  late Future<WordTranslation> _translation;
  var _saving = false;
  StoredWordOccurrence? _savedOccurrence;
  StoredVocabularyItem? _savedItem;

  bool get _saved => _savedOccurrence != null;

  @override
  void initState() {
    super.initState();
    _savedOccurrence = widget.savedOccurrence;
    _translation = _loadTranslation();
    unawaited(_loadSavedItem());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey<String>('word-translation-popover'),
      padding: const EdgeInsets.fromLTRB(15, 12, 10, 7),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        alignment: Alignment.topCenter,
        child: FutureBuilder<WordTranslation>(
          future: _translation,
          builder: (BuildContext context, AsyncSnapshot<WordTranslation> data) {
            if (data.connectionState != ConnectionState.done) {
              return _buildLoading();
            }
            if (data.hasError || data.data == null) {
              return _buildError(data.error);
            }
            return _buildTranslation(data.requireData);
          },
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.request.source,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.palette.text,
              fontFamily: 'Literata',
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 9),
          FractionallySizedBox(
            widthFactor: 0.72,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: widget.palette.border.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 7),
          FractionallySizedBox(
            widthFactor: 0.46,
            child: Container(
              height: 7,
              decoration: BoxDecoration(
                color: widget.palette.border.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(Object? error) {
    final strings = AppLocalizations.of(context);
    final message = switch (error) {
      TranslationException(failure: TranslationFailure.offline) =>
        strings.translationOffline,
      TranslationException(failure: TranslationFailure.invalidResponse) =>
        strings.translationInvalid,
      _ => strings.translationUnavailable,
    };
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            message,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: widget.palette.mutedText, fontSize: 12),
          ),
        ),
        IconButton(
          tooltip: strings.retry,
          onPressed: _retry,
          visualDensity: VisualDensity.compact,
          icon: Icon(
            Icons.refresh_rounded,
            color: widget.palette.accent,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildTranslation(WordTranslation translation) {
    final strings = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          translation.translation,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: widget.palette.text,
            fontFamily: 'Literata',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          strings.lemmaDetails(translation.lemma, translation.partOfSpeech),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: widget.palette.mutedText, fontSize: 11),
        ),
        if (translation.formAnalysis.isNotEmpty) ...<Widget>[
          const SizedBox(height: 2),
          Text(
            translation.formAnalysis,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: widget.palette.mutedText, fontSize: 11),
          ),
        ],
        if (_saved) ...<Widget>[
          const SizedBox(height: 4),
          Text(
            strings.savedVocabularyStatus(
              _statusLabel(strings, _savedItem?.status ?? 'new'),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.palette.accent,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Divider(height: 1, color: widget.palette.border),
        const SizedBox(height: 2),
        Row(
          children: <Widget>[
            Expanded(
              child: TextButton.icon(
                onPressed: widget.onTranslateSentence,
                style: TextButton.styleFrom(
                  foregroundColor: widget.palette.accent,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                ),
                icon: const Icon(Icons.subject_rounded, size: 18),
                label: Text(strings.sentenceAction),
              ),
            ),
            IconButton(
              tooltip: _saved ? strings.removeFromDictionary : strings.saveWord,
              onPressed: _saving
                  ? null
                  : _saved
                  ? _removeTranslation
                  : () => _saveTranslation(translation),
              visualDensity: VisualDensity.compact,
              icon: _saving
                  ? SizedBox.square(
                      dimension: 17,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.8,
                        color: widget.palette.accent,
                      ),
                    )
                  : Icon(
                      _saved
                          ? Icons.bookmark_remove_rounded
                          : Icons.bookmark_add_outlined,
                      color: widget.palette.accent,
                      size: 22,
                    ),
            ),
          ],
        ),
      ],
    );
  }

  Future<WordTranslation> _loadTranslation() {
    return ref.read(translationServiceProvider).translateWord(widget.request);
  }

  void _retry() {
    setState(() {
      _translation = _loadTranslation();
    });
  }

  Future<void> _saveTranslation(WordTranslation translation) async {
    setState(() => _saving = true);
    try {
      final service = ref.read(vocabularyServiceProvider);
      final vocabularyId = await service.saveTranslation(
        request: widget.request,
        translation: translation,
        surfaceForm: widget.surfaceForm,
        contextSentence: widget.request.context,
        contextWordStart: widget.contextWordStart,
        sourceBookId: widget.sourceBookId,
        sourceBookTitle: widget.sourceBookTitle,
        sourceChapterId: widget.sourceChapterId,
        sourceChapterTitle: widget.sourceChapterTitle,
        sourceOffset: widget.sourceOffset,
      );
      final occurrence = await service.occurrenceAt(
        vocabularyId: vocabularyId,
        sourceBookId: widget.sourceBookId,
        sourceOffset: widget.sourceOffset,
      );
      final item = await service.vocabularyItem(vocabularyId);
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        setState(() {
          _saving = false;
          _savedOccurrence = occurrence;
          _savedItem = item;
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _loadSavedItem() async {
    final occurrence = _savedOccurrence;
    if (occurrence == null) {
      return;
    }
    final item = await ref
        .read(vocabularyServiceProvider)
        .vocabularyItem(occurrence.vocabularyId);
    if (mounted) {
      setState(() => _savedItem = item);
    }
  }

  Future<void> _removeTranslation() async {
    final occurrence = _savedOccurrence;
    if (occurrence == null || _saving) {
      return;
    }
    setState(() => _saving = true);
    try {
      await ref.read(vocabularyServiceProvider).removeOccurrence(occurrence);
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        setState(() {
          _saving = false;
          _savedOccurrence = null;
          _savedItem = null;
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  String _statusLabel(AppLocalizations strings, String status) {
    return switch (status) {
      'learning' => strings.statusLearning,
      'learned' => strings.statusLearned,
      _ => strings.statusNew,
    };
  }
}

final class _TextAssistanceSheet extends ConsumerStatefulWidget {
  const _TextAssistanceSheet({
    required this.request,
    required this.sourceText,
    required this.savesAsWord,
    required this.savedOccurrence,
    this.onSave,
    this.onRemove,
  });

  final TextAssistanceRequest request;
  final String sourceText;
  final bool savesAsWord;
  final StoredWordOccurrence? savedOccurrence;
  final Future<StoredWordOccurrence?> Function(FragmentTranslation translation)?
  onSave;
  final Future<void> Function(StoredWordOccurrence occurrence)? onRemove;

  @override
  ConsumerState<_TextAssistanceSheet> createState() =>
      _TextAssistanceSheetState();
}

final class _TextAssistanceSheetState
    extends ConsumerState<_TextAssistanceSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  late Future<FragmentTranslation> _translation;
  Future<TextExplanation>? _explanation;
  StoredWordOccurrence? _savedOccurrence;
  var _saving = false;

  bool get _saved => _savedOccurrence != null;

  @override
  void initState() {
    super.initState();
    _savedOccurrence = widget.savedOccurrence;
    _translation = _loadTranslation();
  }

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return DraggableScrollableSheet(
      controller: _sheetController,
      expand: false,
      initialChildSize: 0.43,
      minChildSize: 0.32,
      maxChildSize: 0.82,
      builder: (BuildContext context, ScrollController scrollController) {
        return ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          children: <Widget>[
            Center(
              child: Container(
                width: 38,
                height: 5,
                decoration: BoxDecoration(
                  color: colors.onSurface.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 11),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    strings.fragmentTranslationTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontFamily: 'Literata',
                      fontSize: 19,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: () => Navigator.of(context).pop(),
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.close_rounded, size: 21),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.055),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.primary.withValues(alpha: 0.12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                child: Text(
                  widget.sourceText,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.72),
                    fontFamily: 'Literata',
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            FutureBuilder<FragmentTranslation>(
              future: _translation,
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<FragmentTranslation> snapshot,
                  ) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTranslationResult(
                        snapshot: snapshot,
                        onRetry: () => setState(() {
                          _translation = _loadTranslation();
                        }),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontFamily: 'Literata',
                          fontSize: 19,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          if (widget.onSave != null) ...<Widget>[
                            Expanded(
                              child: _AssistanceActionButton(
                                key: const ValueKey<String>(
                                  'save-selection-action',
                                ),
                                selected: _saved,
                                onPressed: _saving || !snapshot.hasData
                                    ? null
                                    : _saved
                                    ? _removeSelection
                                    : () =>
                                          _saveSelection(snapshot.requireData),
                                icon: _saving
                                    ? const SizedBox.square(
                                        dimension: 17,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.8,
                                        ),
                                      )
                                    : Icon(
                                        _saved
                                            ? Icons.bookmark_added_rounded
                                            : Icons.bookmark_add_outlined,
                                        size: 19,
                                      ),
                                label: _saved
                                    ? strings.savedAction
                                    : widget.savesAsWord
                                    ? strings.saveWord
                                    : strings.savePhrase,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Expanded(
                            child: _AssistanceActionButton(
                              key: const ValueKey<String>(
                                'explain-selection-action',
                              ),
                              selected: _explanation != null,
                              onPressed: _showExplanation,
                              icon: const Icon(
                                Icons.auto_awesome_outlined,
                                size: 18,
                              ),
                              label: strings.explainText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            ),
            if (_explanation case final explanation?) ...<Widget>[
              const SizedBox(height: 24),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: colors.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    strings.explanationTitle,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder<TextExplanation>(
                future: explanation,
                builder:
                    (
                      BuildContext context,
                      AsyncSnapshot<TextExplanation> snapshot,
                    ) => _buildExplanationResult(
                      snapshot: snapshot,
                      onRetry: () => setState(() {
                        _explanation = _loadExplanation();
                      }),
                    ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTranslationResult({
    required AsyncSnapshot<FragmentTranslation> snapshot,
    required VoidCallback onRetry,
    TextStyle? style,
  }) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const _AssistanceSkeleton();
    }
    if (snapshot.hasError || snapshot.data == null) {
      return _buildAssistanceFailure(snapshot.error, onRetry);
    }
    return Text(
      snapshot.requireData.translation,
      style: style ?? Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildExplanationResult({
    required AsyncSnapshot<TextExplanation> snapshot,
    required VoidCallback onRetry,
  }) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const _AssistanceSkeleton();
    }
    if (snapshot.hasError || snapshot.data == null) {
      return _buildAssistanceFailure(snapshot.error, onRetry);
    }
    final explanation = snapshot.requireData;
    final strings = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _ExplanationSection(
          label: strings.explanationSummaryLabel,
          content: explanation.summary,
          emphasized: true,
        ),
        _ExplanationSection(
          label: strings.explanationMeaningLabel,
          content: explanation.meaningInContext,
        ),
        _ExplanationSection(
          label: strings.explanationBreakdownLabel,
          content: explanation.breakdown,
        ),
        if (explanation.literalTranslation.isNotEmpty)
          _ExplanationSection(
            label: strings.explanationLiteralLabel,
            content: explanation.literalTranslation,
          ),
        _ExplanationSection(
          label: strings.explanationNaturalLabel,
          content: explanation.naturalTranslation,
        ),
        if (explanation.examples.isNotEmpty)
          _ExplanationSection(
            label: strings.explanationExamplesLabel,
            content: explanation.examples
                .map(
                  (TextExplanationExample example) =>
                      '${example.source}\n${example.translation}',
                )
                .join('\n\n'),
          ),
        if (explanation.commonMistake.isNotEmpty)
          _ExplanationSection(
            label: strings.explanationCommonMistakeLabel,
            content: explanation.commonMistake,
          ),
      ],
    );
  }

  Widget _buildAssistanceFailure(Object? error, VoidCallback onRetry) {
    final strings = AppLocalizations.of(context);
    final message = switch (error) {
      TranslationException(failure: TranslationFailure.offline) =>
        strings.translationOffline,
      TranslationException(failure: TranslationFailure.invalidResponse) =>
        strings.translationInvalid,
      _ => strings.translationUnavailable,
    };
    return Row(
      children: <Widget>[
        Expanded(child: Text(message)),
        IconButton(
          tooltip: strings.retry,
          onPressed: onRetry,
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
    );
  }

  void _showExplanation() {
    if (_explanation == null) {
      setState(() {
        _explanation = _loadExplanation();
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _sheetController.isAttached) {
        unawaited(
          _sheetController.animateTo(
            0.76,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
          ),
        );
      }
    });
  }

  Future<void> _saveSelection(FragmentTranslation translation) async {
    final onSave = widget.onSave;
    if (onSave == null) {
      return;
    }
    setState(() => _saving = true);
    try {
      final occurrence = await onSave(translation);
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        setState(() {
          _saving = false;
          _savedOccurrence = occurrence;
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _removeSelection() async {
    final onRemove = widget.onRemove;
    final occurrence = _savedOccurrence;
    if (onRemove == null || occurrence == null) {
      return;
    }
    setState(() => _saving = true);
    try {
      await onRemove(occurrence);
      unawaited(HapticFeedback.lightImpact());
      if (mounted) {
        setState(() {
          _saving = false;
          _savedOccurrence = null;
        });
      }
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<FragmentTranslation> _loadTranslation() =>
      ref.read(textAssistantProvider).translateFragment(widget.request);

  Future<TextExplanation> _loadExplanation() =>
      ref.read(textAssistantProvider).explainText(widget.request);
}

final class _ExplanationSection extends StatelessWidget {
  const _ExplanationSection({
    required this.label,
    required this.content,
    this.emphasized = false,
  });

  final String label;
  final String content;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: emphasized
              ? colors.secondaryContainer.withValues(alpha: 0.48)
              : colors.surfaceContainerHighest.withValues(alpha: 0.34),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 11, 14, 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                content,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.45),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _AssistanceActionButton extends StatelessWidget {
  const _AssistanceActionButton({
    required this.selected,
    required this.onPressed,
    required this.icon,
    required this.label,
    super.key,
  });

  final bool selected;
  final VoidCallback? onPressed;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 48),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        backgroundColor: selected ? colors.primary : Colors.transparent,
        foregroundColor: selected ? colors.onPrimary : colors.primary,
        disabledBackgroundColor: colors.onSurface.withValues(alpha: 0.045),
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.35),
        side: BorderSide(
          color: selected
              ? colors.primary
              : colors.onSurface.withValues(alpha: 0.16),
        ),
      ),
      icon: icon,
      label: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}

final class _AssistanceSkeleton extends StatelessWidget {
  const _AssistanceSkeleton();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final width in <double>[1, 0.92, 0.68])
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: FractionallySizedBox(
              widthFactor: width,
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

final class _ReaderLocation {
  const _ReaderLocation({required this.chapterIndex, required this.textOffset});

  final int chapterIndex;
  final int textOffset;
}

final class _ReaderChrome extends StatelessWidget {
  const _ReaderChrome({
    required this.title,
    required this.chapterTitle,
    required this.progress,
    required this.pageNumber,
    required this.pageCount,
    required this.chapterNumber,
    required this.chapterCount,
    required this.canReturnToPreviousLocation,
    required this.palette,
    required this.onBack,
    required this.onReturnToPreviousLocation,
    required this.onContents,
    required this.onSettings,
    required this.onProgressChanged,
    required this.chapterForProgress,
  });

  final String title;
  final String? chapterTitle;
  final double progress;
  final int pageNumber;
  final int? pageCount;
  final int chapterNumber;
  final int chapterCount;
  final bool canReturnToPreviousLocation;
  final ReaderPalette palette;
  final VoidCallback onBack;
  final VoidCallback onReturnToPreviousLocation;
  final VoidCallback onContents;
  final VoidCallback onSettings;
  final ValueChanged<double> onProgressChanged;
  final int Function(double progress) chapterForProgress;

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.paddingOf(context);
    final strings = AppLocalizations.of(context);
    final chapterName = chapterTitle?.trim().isNotEmpty ?? false
        ? chapterTitle!
        : '${strings.chapter} $chapterNumber';
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16,
            right: 16,
            top: safePadding.top + 4,
            child: DecoratedBox(
              key: const ValueKey<String>('reader-top-chrome'),
              decoration: BoxDecoration(
                color: palette.chrome.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: palette.border.withValues(alpha: 0.62),
                ),
              ),
              child: SizedBox(
                height: 44,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 88,
                      child: Row(
                        children: <Widget>[
                          _ChromeButton(
                            tooltip: MaterialLocalizations.of(
                              context,
                            ).backButtonTooltip,
                            onTap: onBack,
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: palette.text,
                            ),
                          ),
                          if (canReturnToPreviousLocation)
                            _ChromeButton(
                              tooltip: strings.returnToPreviousLocation,
                              onTap: onReturnToPreviousLocation,
                              child: Icon(
                                Icons.history_rounded,
                                color: palette.text,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Semantics(
                        button: true,
                        label: strings.contents,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: onContents,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: palette.text,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '$chapterName · $chapterNumber/$chapterCount',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: palette.mutedText,
                                        fontSize: 9.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: palette.mutedText,
                                    size: 13,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 88,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: _ChromeButton(
                          tooltip: strings.readerSettings,
                          onTap: onSettings,
                          child: Text(
                            'Aa',
                            style: TextStyle(
                              color: palette.text,
                              fontFamily: 'Literata',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 22,
            right: 22,
            bottom: safePadding.bottom + 8,
            child: _ReaderProgress(
              progress: progress,
              pageNumber: pageNumber,
              pageCount: pageCount,
              chapterCount: chapterCount,
              chapterForProgress: chapterForProgress,
              palette: palette,
              onChanged: onProgressChanged,
            ),
          ),
        ],
      ),
    );
  }
}

final class _ChromeButton extends StatelessWidget {
  const _ChromeButton({
    required this.child,
    required this.tooltip,
    required this.onTap,
  });

  final Widget child;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 44,
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        visualDensity: VisualDensity.compact,
        iconSize: 19,
        icon: child,
      ),
    );
  }
}

final class _ReaderProgress extends StatefulWidget {
  const _ReaderProgress({
    required this.progress,
    required this.pageNumber,
    required this.pageCount,
    required this.chapterCount,
    required this.chapterForProgress,
    required this.palette,
    required this.onChanged,
  });

  final double progress;
  final int pageNumber;
  final int? pageCount;
  final int chapterCount;
  final int Function(double progress) chapterForProgress;
  final ReaderPalette palette;
  final ValueChanged<double> onChanged;

  @override
  State<_ReaderProgress> createState() => _ReaderProgressState();
}

final class _ReaderProgressState extends State<_ReaderProgress> {
  double? _dragProgress;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final value = (_dragProgress ?? widget.progress).clamp(0.0, 1.0);
    final percent = (value * 100).round();
    final pageCount = widget.pageCount?.toString() ?? '…';
    final preview = strings.readerProgressPreview(
      percent,
      widget.chapterForProgress(value),
      widget.chapterCount,
    );
    final label = _dragProgress == null
        ? strings.readerCompactProgress(widget.pageNumber, pageCount, percent)
        : preview;
    return DecoratedBox(
      key: const ValueKey<String>('reader-bottom-progress'),
      decoration: BoxDecoration(
        color: widget.palette.chrome.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: widget.palette.border.withValues(alpha: 0.52),
        ),
      ),
      child: SizedBox(
        height: 36,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2,
                    activeTrackColor: widget.palette.accent,
                    inactiveTrackColor: widget.palette.border,
                    thumbColor: widget.palette.accent,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 5,
                    ),
                    overlayColor: widget.palette.accent.withValues(alpha: 0.1),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 14,
                    ),
                    valueIndicatorColor: widget.palette.popover,
                    valueIndicatorTextStyle: TextStyle(
                      color: widget.palette.text,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    showValueIndicator: ShowValueIndicator.onlyForContinuous,
                  ),
                  child: Slider(
                    value: value,
                    label: preview,
                    onChanged: (double next) {
                      setState(() => _dragProgress = next);
                    },
                    onChangeEnd: (double next) {
                      setState(() => _dragProgress = null);
                      widget.onChanged(next);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: widget.palette.mutedText,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _ReaderSettingsSheet extends ConsumerWidget {
  const _ReaderSettingsSheet({
    required this.bookLanguage,
    required this.onBookLanguageChanged,
  });

  final String bookLanguage;
  final Future<void> Function(String language) onBookLanguageChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final preferences = ref.watch(readerPreferencesProvider);
    final notifier = ref.read(readerPreferencesProvider.notifier);
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(22, 4, 22, 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              strings.readerSettings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 18),
            Text(
              strings.paragraphStyle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            SegmentedButton<ReaderParagraphStyle>(
              segments: <ButtonSegment<ReaderParagraphStyle>>[
                ButtonSegment<ReaderParagraphStyle>(
                  value: ReaderParagraphStyle.book,
                  label: Text(strings.bookParagraphStyle),
                ),
                ButtonSegment<ReaderParagraphStyle>(
                  value: ReaderParagraphStyle.modern,
                  label: Text(strings.modernParagraphStyle),
                ),
              ],
              selected: <ReaderParagraphStyle>{preferences.paragraphStyle},
              onSelectionChanged: (Set<ReaderParagraphStyle> value) {
                notifier.setParagraphStyle(value.single);
              },
              showSelectedIcon: false,
            ),
            const SizedBox(height: 12),
            _SettingSlider(
              label: strings.fontSize,
              value: preferences.fontSize,
              min: 15,
              max: 24,
              divisions: 9,
              onChanged: notifier.setFontSize,
            ),
            _SettingSlider(
              label: strings.lineHeight,
              value: preferences.lineHeight,
              min: 1.3,
              max: 1.8,
              divisions: 5,
              onChanged: notifier.setLineHeight,
            ),
            _SettingSlider(
              label: strings.margins,
              value: preferences.horizontalMargin,
              min: 16,
              max: 36,
              divisions: 10,
              onChanged: notifier.setHorizontalMargin,
            ),
            _SettingSlider(
              label: strings.readerBrightness,
              value: preferences.brightness,
              min: 0.25,
              max: 1,
              divisions: 15,
              onChanged: notifier.setBrightness,
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(strings.pageAnimation),
              value: preferences.pageAnimationEnabled,
              onChanged: (bool value) =>
                  notifier.setPageAnimationEnabled(value: value),
            ),
            const SizedBox(height: 8),
            Text(
              strings.bookLanguage,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            SegmentedButton<String>(
              segments: <ButtonSegment<String>>[
                ButtonSegment<String>(
                  value: 'en',
                  label: Text(strings.englishLanguage),
                ),
                ButtonSegment<String>(
                  value: 'el',
                  label: Text(strings.greekLanguage),
                ),
              ],
              selected: <String>{bookLanguage},
              onSelectionChanged: (Set<String> value) {
                unawaited(onBookLanguageChanged(value.single));
              },
              showSelectedIcon: false,
            ),
            const SizedBox(height: 18),
            Text(strings.theme, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            SegmentedButton<ReaderTheme>(
              segments: <ButtonSegment<ReaderTheme>>[
                ButtonSegment<ReaderTheme>(
                  value: ReaderTheme.light,
                  label: Text(strings.lightTheme),
                ),
                ButtonSegment<ReaderTheme>(
                  value: ReaderTheme.sepia,
                  label: Text(strings.sepiaTheme),
                ),
                ButtonSegment<ReaderTheme>(
                  value: ReaderTheme.dark,
                  label: Text(strings.darkTheme),
                ),
              ],
              selected: <ReaderTheme>{preferences.theme},
              onSelectionChanged: (Set<ReaderTheme> value) {
                notifier.setTheme(value.single);
              },
              showSelectedIcon: false,
            ),
          ],
        ),
      ),
    );
  }
}

final class _SettingSlider extends StatelessWidget {
  const _SettingSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 92, child: Text(label)),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

final class _SelectionActions extends StatelessWidget {
  const _SelectionActions({
    required this.visible,
    required this.palette,
    required this.onTranslate,
    required this.onClose,
  });

  final bool visible;
  final ReaderPalette palette;
  final VoidCallback onTranslate;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: MediaQuery.paddingOf(context).bottom + 52,
      child: IgnorePointer(
        ignoring: !visible,
        child: AnimatedSlide(
          offset: visible ? Offset.zero : const Offset(0, 0.4),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            opacity: visible ? 1 : 0,
            duration: const Duration(milliseconds: 150),
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.popover,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: palette.border),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton.icon(
                      onPressed: onTranslate,
                      icon: const Icon(Icons.translate_rounded, size: 18),
                      label: Text(
                        AppLocalizations.of(context).translateSelection,
                      ),
                    ),
                    IconButton(
                      tooltip: MaterialLocalizations.of(
                        context,
                      ).closeButtonTooltip,
                      onPressed: onClose,
                      icon: const Icon(Icons.close_rounded, size: 19),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _ReaderLoading extends StatelessWidget {
  const _ReaderLoading({this.backgroundColor});

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? const Color(0xfff7f3ea),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: _ReaderPageSkeleton(color: Color(0xffe5dfd2)),
        ),
      ),
    );
  }
}

final class _ReaderPageSkeleton extends StatelessWidget {
  const _ReaderPageSkeleton({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final width in <double>[0.92, 1, 0.88, 0.97, 0.72, 1, 0.94, 0.81])
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FractionallySizedBox(
              widthFactor: width,
              child: Container(height: 12, color: color),
            ),
          ),
      ],
    );
  }
}

final class _ReaderError extends StatelessWidget {
  const _ReaderError();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(AppLocalizations.of(context).bookLoadError),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: context.pop,
                  child: const Icon(Icons.arrow_back_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
final class ReaderPalette {
  const ReaderPalette({
    required this.background,
    required this.text,
    required this.mutedText,
    required this.accent,
    required this.border,
    required this.chrome,
    required this.popover,
    required this.skeleton,
    required this.savedUnderline,
  });

  factory ReaderPalette.forTheme(ReaderTheme theme) {
    return switch (theme) {
      ReaderTheme.light => const ReaderPalette(
        background: Color(0xfff5eee1),
        text: Color(0xff1d251f),
        mutedText: Color(0xff696b62),
        accent: Color(0xffa9573f),
        border: Color(0xffd8cdbc),
        chrome: Color(0xfffffaf0),
        popover: Color(0xfffffaf0),
        skeleton: Color(0xffe3dacb),
        savedUnderline: Color(0xff55715e),
      ),
      ReaderTheme.sepia => const ReaderPalette(
        background: Color(0xffeadbbc),
        text: Color(0xff382d23),
        mutedText: Color(0xff746554),
        accent: Color(0xff98533f),
        border: Color(0xffcdb890),
        chrome: Color(0xfff3e5c8),
        popover: Color(0xfff6e8cb),
        skeleton: Color(0xffd6c3a0),
        savedUnderline: Color(0xff66745b),
      ),
      ReaderTheme.dark => const ReaderPalette(
        background: Color(0xff1d211d),
        text: Color(0xffe9e2d5),
        mutedText: Color(0xffa9a397),
        accent: Color(0xffd08061),
        border: Color(0xff3d433d),
        chrome: Color(0xff272c27),
        popover: Color(0xff2b302b),
        skeleton: Color(0xff343a34),
        savedUnderline: Color(0xff8ca28d),
      ),
    };
  }

  final Color background;
  final Color text;
  final Color mutedText;
  final Color accent;
  final Color border;
  final Color chrome;
  final Color popover;
  final Color skeleton;
  final Color savedUnderline;
}
