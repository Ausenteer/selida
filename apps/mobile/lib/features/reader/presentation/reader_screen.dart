import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/dictionary/application/vocabulary_service.dart';
import 'package:selida/features/reader/application/reader_book_navigation.dart';
import 'package:selida/features/reader/application/reader_interaction_controller.dart';
import 'package:selida/features/reader/application/reader_pagination_controller.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/application/reader_providers.dart';
import 'package:selida/features/reader/domain/reader_page.dart';
import 'package:selida/features/reader/domain/reader_preferences.dart';
import 'package:selida/features/reader/presentation/reader_page_surface.dart';
import 'package:selida/features/reader/presentation/word_popover_placement.dart';
import 'package:selida/features/translation/application/translation_service.dart';
import 'package:selida/features/translation/domain/word_translation.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

part 'reader_chrome.dart';
part 'reader_contents_sheet.dart';
part 'reader_settings_sheet.dart';
part 'reader_support.dart';
part 'reader_text_assistance_sheet.dart';
part 'reader_word_popover.dart';

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
  static const ReaderSelectionController _selectionController =
      ReaderSelectionController();

  late final PageController _pageController;
  late final AppDatabase _database;
  late final ReaderBookNavigation _bookNavigation;
  late final ReaderPaginationController _pagination;
  late String _bookLanguage;
  late int _chapterIndex;
  var _currentPageIndex = 0;
  var _currentTextOffset = 0;
  ReaderTextRange? _activeSelection;
  ReaderTextRange? _focusedWordRange;
  var _selectionActionsVisible = false;
  final List<ReaderLocation> _navigationHistory = <ReaderLocation>[];
  int? _brightnessPointer;
  double? _lastBrightnessY;
  OverlayEntry? _wordPopover;
  final ReaderBoundarySwipeTracker _boundarySwipeTracker =
      ReaderBoundarySwipeTracker();

  StoredChapter get _chapter => widget.document.chapters[_chapterIndex];

  @override
  void initState() {
    super.initState();
    _database = ref.read(databaseProvider);
    _bookNavigation = ReaderBookNavigation(
      widget.document.chapters.map(
        (StoredChapter chapter) => chapter.lengthUtf16,
      ),
    );
    _pagination = ReaderPaginationController(
      database: _database,
      bookId: widget.document.book.id,
    )..addListener(_onPaginationChanged);
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
    _pagination
      ..removeListener(_onPaginationChanged)
      ..dispose();
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
                  final identity = _pagination.identityFor(spec);
                  final key = '${_chapter.id}:${identity.fingerprint}';
                  _pagination.schedule(
                    blocks: blocks,
                    spec: spec,
                    identity: identity,
                    key: key,
                    chapterId: _chapter.id,
                    chapterLength: _chapter.lengthUtf16,
                    currentTextOffset: _currentTextOffset,
                    onInitialPage: _onInitialPageResolved,
                  );
                  final pages = _pagination.layoutKey == key
                      ? _pagination.pages
                      : null;
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
            pageCount: _pagination.complete ? _pagination.pages?.length : null,
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

  void _onPaginationChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onInitialPageResolved(int pageIndex) {
    _currentPageIndex = pageIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted &&
          _pageController.hasClients &&
          (_pagination.pages?.isNotEmpty ?? false)) {
        _pageController.jumpToPage(_currentPageIndex);
      }
    });
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
      _boundarySwipeTracker.begin();
      _dismissWordPopover();
      return false;
    }
    if (notification is OverscrollNotification &&
        notification.dragDetails != null) {
      final direction = notification.overscroll > 0 ? 1 : -1;
      final pages = _pagination.pages;
      final atPageBoundary =
          pages != null &&
          pages.isNotEmpty &&
          (direction > 0
              ? _currentPageIndex == pages.length - 1 && _pagination.complete
              : _currentPageIndex == 0);
      final hasAdjacentChapter =
          _chapterIndex + direction >= 0 &&
          _chapterIndex + direction < widget.document.chapters.length;
      _boundarySwipeTracker.addOverscroll(
        overscroll: notification.overscroll,
        isAtPageBoundary: atPageBoundary,
        hasAdjacentChapter: hasAdjacentChapter,
      );
      return false;
    }
    if (notification is ScrollEndNotification) {
      final direction = _boundarySwipeTracker.end(
        chapterIndex: _chapterIndex,
        chapterCount: widget.document.chapters.length,
      );
      if (direction != null) {
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
        ReaderLocation(
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
      _pagination.reset(notify: false);
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
    final updated = _selectionController.extendAcrossPage(
      selection: selection,
      targetPage: pages[targetIndex],
      chapterText: _chapter.plainText,
      direction: direction,
    );
    if (updated == null) {
      return;
    }
    setState(() {
      _activeSelection = updated;
      _selectionActionsVisible = true;
    });
    _turnToPage(targetIndex, animate: animate);
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
    return _bookNavigation.progressFor(
      chapterIndex: _chapterIndex,
      textOffset: chapterOffset,
    );
  }

  ReaderLocation _locationForBookProgress(double progress) {
    return _bookNavigation.locationForProgress(
      progress: progress,
      fallbackChapterIndex: _chapterIndex,
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

    final pages = _pagination.pages;
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
        _pagination.reset(notify: false);
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
    final selected = await showModalBottomSheet<ReaderLocation>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => _ReaderContentsSheet(
        document: widget.document,
        currentChapterIndex: _chapterIndex,
      ),
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
        _pagination.reset(notify: false);
      });
      ref.invalidate(readerDocumentProvider(widget.document.book.id));
    }
  }
}
