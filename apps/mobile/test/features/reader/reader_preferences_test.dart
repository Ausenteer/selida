import 'dart:async';
import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/reader/domain/reader_page.dart';
import 'package:selida/features/reader/domain/reader_preferences.dart';

void main() {
  test('book typography defaults to justified Literata', () {
    const preferences = ReaderPreferences();

    expect(preferences.textAlignment, ReaderTextAlignment.justified);
    expect(preferences.fontFamily, ReaderFontFamily.literata);
    expect(preferences.paragraphStyle, ReaderParagraphStyle.book);
  });

  test('legacy reader preferences migrate to justified text', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await database.saveLocalSettingValue(
      key: 'reader.preferences',
      valueJson: jsonEncode(<String, Object>{
        'fontSize': 20,
        'textAlignment': ReaderTextAlignment.left.name,
      }),
    );

    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);
    container.read(readerPreferencesProvider);

    await _waitFor(
      () async => container.read(readerPreferencesProvider).fontSize == 20,
    );
    expect(
      container.read(readerPreferencesProvider).textAlignment,
      ReaderTextAlignment.justified,
    );
  });

  test('legacy edge-gesture brightness is reset once', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await database.saveLocalSettingValue(
      key: 'reader.preferences',
      valueJson: jsonEncode(<String, Object>{
        'schemaVersion': 2,
        'brightness': 0.42,
      }),
    );

    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    addTearDown(container.dispose);
    container.read(readerPreferencesProvider);

    await _waitFor(() async {
      final stored = await database.localSettingValue('reader.preferences');
      return stored != null &&
          (jsonDecode(stored) as Map<String, Object?>)['schemaVersion'] == 3;
    });
    expect(container.read(readerPreferencesProvider).brightness, 1);
  });

  test('reader preferences survive provider recreation', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final firstContainer = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    final notifier = firstContainer.read(readerPreferencesProvider.notifier);
    notifier
      ..setFontSize(23)
      ..setLineHeight(1.7)
      ..setHorizontalMargin(32)
      ..setBrightness(0.7)
      ..setPageAnimationEnabled(value: false)
      ..setTheme(ReaderTheme.dark)
      ..setParagraphStyle(ReaderParagraphStyle.modern)
      ..setTextAlignment(ReaderTextAlignment.justified)
      ..setFontFamily(ReaderFontFamily.inter)
      ..setAssistanceLanguage(ReaderAssistanceLanguage.english);

    await _waitFor(
      () async =>
          await database.localSettingValue('reader.preferences') != null,
    );
    firstContainer.dispose();

    final secondContainer = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(database)],
    );
    addTearDown(secondContainer.dispose);
    secondContainer.read(readerPreferencesProvider);

    await _waitFor(
      () async =>
          secondContainer.read(readerPreferencesProvider).theme ==
          ReaderTheme.dark,
    );
    final restored = secondContainer.read(readerPreferencesProvider);
    expect(restored.fontSize, 23);
    expect(restored.lineHeight, 1.7);
    expect(restored.horizontalMargin, 32);
    expect(restored.brightness, 0.7);
    expect(restored.pageAnimationEnabled, isFalse);
    expect(restored.theme, ReaderTheme.dark);
    expect(restored.paragraphStyle, ReaderParagraphStyle.modern);
    expect(restored.textAlignment, ReaderTextAlignment.justified);
    expect(restored.fontFamily, ReaderFontFamily.inter);
    expect(restored.assistanceLanguage, ReaderAssistanceLanguage.english);
  });
}

Future<void> _waitFor(FutureOr<bool> Function() predicate) async {
  for (var attempt = 0; attempt < 50; attempt += 1) {
    if (await predicate()) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('Condition was not met in time');
}
