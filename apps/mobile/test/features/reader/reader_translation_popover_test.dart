import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/app/selida_theme.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/reader/application/reader_paginator.dart';
import 'package:selida/features/reader/presentation/reader_page_surface.dart';
import 'package:selida/features/reader/presentation/reader_screen.dart';
import 'package:selida/features/translation/application/translation_service.dart';
import 'package:selida/features/translation/domain/word_translation.dart';
import 'package:selida/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('word popover appears before the network response arrives', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    await _seedReader(database);
    final translator = _DelayedTranslator();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          translationServiceProvider.overrideWithValue(translator),
        ],
        child: MaterialApp(
          theme: SelidaTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ReaderScreen(bookId: 'book-1'),
        ),
      ),
    );
    await _pumpFrames(tester);
    final surface = find.byType(ReaderPageSurface);
    final origin = tester.getTopLeft(surface);
    await tester.tapAt(origin + const Offset(95, 20));
    await tester.pump();

    expect(
      find.byKey(const ValueKey<String>('word-translation-popover')),
      findsOneWidget,
    );
    expect(find.text('walked'), findsOneWidget);
    expect(
      tester.widget<ReaderPageSurface>(surface).focusedRange != null,
      isTrue,
    );

    translator.complete();
    await _pumpFrames(tester);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await database.close();
  });

  testWidgets('word popover translates and saves a vocabulary item', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    await _seedReader(database);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          translationServiceProvider.overrideWithValue(const _FakeTranslator()),
          textAssistantProvider.overrideWithValue(const _FakeTextAssistant()),
        ],
        child: MaterialApp(
          theme: SelidaTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ReaderScreen(bookId: 'book-1'),
        ),
      ),
    );
    await _pumpFrames(tester);

    final surface = find.byType(ReaderPageSurface);
    expect(surface, findsOneWidget);
    final origin = tester.getTopLeft(surface);
    await tester.tapAt(origin + const Offset(95, 20));
    await _pumpFrames(tester);

    expect(find.text('ходить'), findsOneWidget);
    expect(find.text('walked'), findsOneWidget);
    expect(find.text('Sentence'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Explain'), findsOneWidget);
    final surfaceSize = tester.getSize(surface);
    await tester.tapAt(
      origin + Offset(surfaceSize.width / 2, surfaceSize.height - 20),
    );
    await tester.pump();
    expect(find.text('ходить'), findsNothing);
    expect(
      tester.widget<ReaderPageSurface>(surface).focusedRange == null,
      isTrue,
    );

    await tester.tapAt(origin + const Offset(95, 20));
    await _pumpFrames(tester);
    expect(find.text('ходить'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.bookmark_add_outlined));
    await _pumpFrames(tester);

    expect(find.byIcon(Icons.bookmark_remove_rounded), findsOneWidget);
    expect(find.text('Already in dictionary · New'), findsOneWidget);
    final words = await database.select(database.vocabularyItems).get();
    final occurrences = await database.select(database.wordOccurrences).get();
    expect(words.single.lemma, 'walk');
    expect(words.single.translation, 'ходить');
    expect(occurrences.single.surfaceForm, 'walked');
    expect(occurrences.single.contextSentence, 'She walked home.');
    expect(occurrences.single.sourceChapterId, 'chapter-1');

    await tester.tap(find.byIcon(Icons.bookmark_remove_rounded));
    await _pumpFrames(tester);
    expect(find.byIcon(Icons.bookmark_add_outlined), findsOneWidget);
    expect(await database.select(database.wordOccurrences).get(), isEmpty);
    expect(
      (await database.select(database.vocabularyItems).get()).single.deletedAt,
      isA<DateTime>(),
    );

    await tester.tap(
      find.byKey(const ValueKey<String>('translate-word-sentence-action')),
    );
    await _pumpFrames(tester);
    expect(find.text('She walked home.'), findsOneWidget);
    expect(find.text('Она пошла домой.'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await database.close();
  });

  testWidgets('long press selection translates and explains a fragment', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    await _seedReader(database);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          translationServiceProvider.overrideWithValue(const _FakeTranslator()),
          textAssistantProvider.overrideWithValue(const _FakeTextAssistant()),
        ],
        child: MaterialApp(
          theme: SelidaTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ReaderScreen(bookId: 'book-1'),
        ),
      ),
    );
    await _pumpFrames(tester);

    final surface = find.byType(ReaderPageSurface);
    final origin = tester.getTopLeft(surface);
    final surfaceWidget = tester.widget<ReaderPageSurface>(surface);
    final segment = surfaceWidget.page.segments.single;
    final prefix = segment.indentFirstLine
        ? ReaderPaginator.paragraphIndent
        : '';
    final painter = ReaderPaginator.createPainter(
      text: '$prefix${segment.text}',
      kind: segment.kind,
      spec: surfaceWidget.spec,
    )..layout(maxWidth: surfaceWidget.spec.width);
    final walkedBox = painter
        .getBoxesForSelection(
          TextSelection(
            baseOffset: prefix.length + 4,
            extentOffset: prefix.length + 10,
          ),
        )
        .single
        .toRect();
    final homeBox = painter
        .getBoxesForSelection(
          TextSelection(
            baseOffset: prefix.length + 11,
            extentOffset: prefix.length + 15,
          ),
        )
        .single
        .toRect();
    painter.dispose();
    final gesture = await tester.startGesture(
      origin + walkedBox.center + Offset(0, segment.top),
    );
    await tester.pump(const Duration(milliseconds: 600));
    await gesture.moveTo(origin + homeBox.center + Offset(0, segment.top));
    await tester.pump();
    await gesture.up();
    await _pumpFrames(tester);

    expect(
      find.byKey(const ValueKey<String>('phrase-translation-popover')),
      findsOneWidget,
    );
    expect(find.text('пошла домой'), findsOneWidget);
    expect(find.text('Sentence'), findsOneWidget);
    expect(find.text('Explain'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey<String>('save-popover-action')));
    await _pumpFrames(tester);
    final phrases = await database.select(database.vocabularyItems).get();
    expect(phrases.single.kind, 'phrase');
    expect(phrases.single.lemma, 'walked home');
    await tester.tap(find.text('Explain'));
    await _pumpFrames(tester);
    await tester.drag(find.byType(ListView).last, const Offset(0, -300));
    await _pumpFrames(tester);
    expect(
      find.text('Past tense describes a completed action.'),
      findsOneWidget,
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await database.close();
  });

  testWidgets('a single selected expression uses the compact word flow', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    await _seedReader(database);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          translationServiceProvider.overrideWithValue(const _FakeTranslator()),
          textAssistantProvider.overrideWithValue(const _FakeTextAssistant()),
        ],
        child: MaterialApp(
          theme: SelidaTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ReaderScreen(bookId: 'book-1'),
        ),
      ),
    );
    await _pumpFrames(tester);

    final surface = find.byType(ReaderPageSurface);
    final origin = tester.getTopLeft(surface);
    await tester.longPressAt(origin + const Offset(95, 20));
    await _pumpFrames(tester);
    expect(
      find.byKey(const ValueKey<String>('word-translation-popover')),
      findsOneWidget,
    );
    expect(find.text('walked'), findsOneWidget);
    expect(find.text('ходить'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Save phrase'), findsNothing);
    expect(
      find.byKey(const ValueKey<String>('selection-start-handle')),
      findsNothing,
    );

    await tester.tap(find.text('Explain'));
    await _pumpFrames(tester);
    expect(
      find.text('Past tense describes a completed action.'),
      findsOneWidget,
    );
    expect(find.text('Grammar'), findsOneWidget);
    final focusText = tester.widget<Text>(
      find.byKey(const ValueKey<String>('explanation-focus-text')),
    );
    expect(focusText.data, 'walked');
    expect(find.text('Past Simple'), findsOneWidget);
    expect(find.text('verb + -ed'), findsOneWidget);
    expect(find.text('Literally'), findsNothing);
    expect(find.text('Examples'), findsNothing);
    expect(find.text('Common mistake'), findsNothing);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await database.close();
  });

  testWidgets('chrome stays visible, clear of text, and works over a popover', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    await _seedReader(database);
    await _seedSecondChapter(database);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          translationServiceProvider.overrideWithValue(const _FakeTranslator()),
        ],
        child: MaterialApp(
          theme: SelidaTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ReaderScreen(bookId: 'book-1'),
        ),
      ),
    );
    await _pumpFrames(tester);

    final surface = find.byType(ReaderPageSurface);
    final origin = tester.getTopLeft(surface);
    final surfaceRect = tester.getRect(surface);
    final topChrome = find.byKey(const ValueKey<String>('reader-top-chrome'));
    final bottomProgress = find.byKey(
      const ValueKey<String>('reader-bottom-progress'),
    );
    expect(tester.getRect(topChrome).bottom, lessThan(surfaceRect.top));
    expect(tester.getRect(bottomProgress).top, greaterThan(surfaceRect.bottom));
    expect(tester.getSize(topChrome).height, 44);
    expect(tester.getSize(bottomProgress).height, 36);
    expect(find.text('Page 1 of 1 · 0%'), findsOneWidget);
    expect(find.text('Aa'), findsOneWidget);
    expect(find.textContaining('min left'), findsNothing);

    await tester.pump(const Duration(seconds: 4));
    expect(topChrome, findsOneWidget);
    expect(bottomProgress, findsOneWidget);

    await tester.tapAt(origin + const Offset(95, 20));
    await _pumpFrames(tester);
    expect(
      find.byKey(const ValueKey<String>('word-translation-popover')),
      findsOneWidget,
    );
    await tester.tap(find.textContaining('One · 1/2'));
    await _pumpFrames(tester);
    expect(
      find.byKey(const ValueKey<String>('word-translation-popover')),
      findsNothing,
    );
    await tester.tap(find.text('Two'));
    await _pumpFrames(tester);

    expect(find.byIcon(Icons.history_rounded), findsOneWidget);
    expect(find.textContaining('Two · 2/2'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.history_rounded));
    await _pumpFrames(tester);
    expect(find.textContaining('One · 1/2'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await database.close();
  });

  testWidgets('progress scrubber jumps to the target chapter', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    await _seedReader(database);
    await _seedSecondChapter(database);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: SelidaTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ReaderScreen(bookId: 'book-1'),
        ),
      ),
    );
    await _pumpFrames(tester);

    final slider = find.byType(Slider);
    final sliderRect = tester.getRect(slider);
    await tester.tapAt(Offset(sliderRect.right - 3, sliderRect.center.dy));
    await _pumpFrames(tester);

    expect(
      tester
          .widget<ReaderPageSurface>(find.byType(ReaderPageSurface))
          .page
          .segments
          .single
          .text,
      'A second chapter.',
    );
    expect(find.byIcon(Icons.history_rounded), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await database.close();
  });

  testWidgets('a page swipe crosses the chapter boundary', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    await _seedReader(database);
    await _seedSecondChapter(database);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: SelidaTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ReaderScreen(bookId: 'book-1'),
        ),
      ),
    );
    await _pumpFrames(tester);
    expect(
      tester
          .widget<ReaderPageSurface>(find.byType(ReaderPageSurface))
          .page
          .segments
          .single
          .text,
      'She walked home.',
    );

    await tester.fling(find.byType(PageView), const Offset(-300, 0), 1200);
    await _pumpFrames(tester);

    expect(
      tester
          .widget<ReaderPageSurface>(find.byType(ReaderPageSurface))
          .page
          .segments
          .single
          .text,
      'A second chapter.',
    );

    await tester.fling(find.byType(PageView), const Offset(300, 0), 1200);
    await _pumpFrames(tester);
    expect(
      tester
          .widget<ReaderPageSurface>(find.byType(ReaderPageSurface))
          .page
          .segments
          .single
          .text,
      'She walked home.',
    );

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    await database.close();
  });
}

Future<void> _pumpFrames(WidgetTester tester) async {
  for (var index = 0; index < 8; index += 1) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _seedReader(AppDatabase database) async {
  final now = DateTime.utc(2026, 1, 1);
  await database
      .into(database.books)
      .insert(
        BooksCompanion.insert(
          id: 'book-1',
          format: 'txt',
          title: 'Example',
          language: 'en',
          contentHash: 'hash',
          totalLength: 16,
          lastOpenedAt: now,
          filePath: const Value<String>('example.txt'),
        ),
      );
  await database
      .into(database.chapters)
      .insert(
        ChaptersCompanion.insert(
          id: 'chapter-1',
          bookId: 'book-1',
          ordinal: 0,
          plainText: 'She walked home.',
          lengthUtf16: 16,
          title: const Value<String>('One'),
        ),
      );
  await database
      .into(database.contentBlocks)
      .insert(
        ContentBlocksCompanion.insert(
          id: 'block-1',
          chapterId: 'chapter-1',
          ordinal: 0,
          kind: 'paragraph',
          textContent: 'She walked home.',
          startOffset: 0,
          endOffset: 16,
        ),
      );
}

Future<void> _seedSecondChapter(AppDatabase database) async {
  await database
      .into(database.chapters)
      .insert(
        ChaptersCompanion.insert(
          id: 'chapter-2',
          bookId: 'book-1',
          ordinal: 1,
          plainText: 'A second chapter.',
          lengthUtf16: 17,
          title: const Value<String>('Two'),
        ),
      );
  await database
      .into(database.contentBlocks)
      .insert(
        ContentBlocksCompanion.insert(
          id: 'block-2',
          chapterId: 'chapter-2',
          ordinal: 0,
          kind: 'paragraph',
          textContent: 'A second chapter.',
          startOffset: 0,
          endOffset: 17,
        ),
      );
}

final class _FakeTranslator implements WordTranslator {
  const _FakeTranslator();

  @override
  Future<WordTranslation> translateWord(WordTranslationRequest request) async {
    expect(request.interfaceLanguage, 'ru');
    return const WordTranslation(
      translation: 'ходить',
      lemma: 'walk',
      partOfSpeech: 'verb',
      formAnalysis: 'past tense',
      fromCache: false,
    );
  }
}

final class _DelayedTranslator implements WordTranslator {
  final Completer<WordTranslation> _completer = Completer<WordTranslation>();

  void complete() {
    _completer.complete(
      const WordTranslation(
        translation: 'ходить',
        lemma: 'walk',
        partOfSpeech: 'verb',
        formAnalysis: 'past tense',
        fromCache: false,
      ),
    );
  }

  @override
  Future<WordTranslation> translateWord(WordTranslationRequest request) {
    return _completer.future;
  }
}

final class _FakeTextAssistant implements TextAssistant {
  const _FakeTextAssistant();

  @override
  Future<FragmentTranslation> translateFragment(
    TextAssistanceRequest request,
  ) async {
    expect(request.interfaceLanguage, 'ru');
    return FragmentTranslation(
      translation: switch (request.source) {
        'walked' => 'пошла',
        'walked home' => 'пошла домой',
        _ => 'Она пошла домой.',
      },
      fromCache: false,
    );
  }

  @override
  Future<TextExplanation> explainText(TextAssistanceRequest request) async {
    expect(request.interfaceLanguage, 'ru');
    return const TextExplanation(
      focus: TextExplanationFocus.grammar,
      focusText: 'walked',
      title: 'Past Simple',
      explanation: 'Past tense describes a completed action.',
      structure: 'verb + -ed',
      literalTranslation: 'шла',
      naturalTranslation: 'пошла',
      examples: <TextExplanationExample>[
        TextExplanationExample(source: 'I walked.', translation: 'Я шёл.'),
      ],
      commonMistake: 'Do not use -ed with irregular verbs.',
      fromCache: false,
    );
  }
}
