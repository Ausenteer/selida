import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

enum ReaderTheme { light, sepia, dark }

@immutable
final class ReaderPreferences {
  const ReaderPreferences({
    this.fontSize = 18,
    this.lineHeight = 1.55,
    this.horizontalMargin = 24,
    this.brightness = 1,
    this.pageAnimationEnabled = true,
    this.theme = ReaderTheme.light,
    this.paragraphStyle = ReaderParagraphStyle.book,
  });

  final double fontSize;
  final double lineHeight;
  final double horizontalMargin;
  final double brightness;
  final bool pageAnimationEnabled;
  final ReaderTheme theme;
  final ReaderParagraphStyle paragraphStyle;

  ReaderPreferences copyWith({
    double? fontSize,
    double? lineHeight,
    double? horizontalMargin,
    double? brightness,
    bool? pageAnimationEnabled,
    ReaderTheme? theme,
    ReaderParagraphStyle? paragraphStyle,
  }) {
    return ReaderPreferences(
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      horizontalMargin: horizontalMargin ?? this.horizontalMargin,
      brightness: brightness ?? this.brightness,
      pageAnimationEnabled: pageAnimationEnabled ?? this.pageAnimationEnabled,
      theme: theme ?? this.theme,
      paragraphStyle: paragraphStyle ?? this.paragraphStyle,
    );
  }
}

final NotifierProvider<ReaderPreferencesNotifier, ReaderPreferences>
readerPreferencesProvider =
    NotifierProvider<ReaderPreferencesNotifier, ReaderPreferences>(
      ReaderPreferencesNotifier.new,
    );

final class ReaderPreferencesNotifier extends Notifier<ReaderPreferences> {
  static const _storageKey = 'reader.preferences';

  late AppDatabase _database;
  var _revision = 0;

  @override
  ReaderPreferences build() {
    _database = ref.watch(databaseProvider);
    unawaited(_restore(_database, _revision));
    return const ReaderPreferences();
  }

  void setFontSize(double value) {
    _set(state.copyWith(fontSize: value));
  }

  void setLineHeight(double value) {
    _set(state.copyWith(lineHeight: value));
  }

  void setHorizontalMargin(double value) {
    _set(state.copyWith(horizontalMargin: value));
  }

  void setBrightness(double value) {
    _set(state.copyWith(brightness: value.clamp(0.25, 1)));
  }

  void setPageAnimationEnabled({required bool value}) {
    _set(state.copyWith(pageAnimationEnabled: value));
  }

  void setTheme(ReaderTheme value) {
    _set(state.copyWith(theme: value));
  }

  void setParagraphStyle(ReaderParagraphStyle value) {
    _set(state.copyWith(paragraphStyle: value));
  }

  void _set(ReaderPreferences value) {
    _revision += 1;
    state = value;
    unawaited(_persist(value));
  }

  Future<void> _restore(AppDatabase database, int revision) async {
    final stored = await database.localSettingValue(_storageKey);
    if (stored == null || revision != _revision) {
      return;
    }
    try {
      final json = jsonDecode(stored) as Map<String, Object?>;
      final themeName = json['theme'] as String?;
      final theme = ReaderTheme.values
          .where((ReaderTheme value) => value.name == themeName)
          .firstOrNull;
      final paragraphStyleName = json['paragraphStyle'] as String?;
      final paragraphStyle = ReaderParagraphStyle.values
          .where(
            (ReaderParagraphStyle value) => value.name == paragraphStyleName,
          )
          .firstOrNull;
      state = ReaderPreferences(
        fontSize: _numberInRange(json['fontSize'], 15, 24, 18),
        lineHeight: _numberInRange(json['lineHeight'], 1.3, 1.8, 1.55),
        horizontalMargin: _numberInRange(json['horizontalMargin'], 16, 36, 24),
        brightness: _numberInRange(json['brightness'], 0.25, 1, 1),
        pageAnimationEnabled: json['pageAnimationEnabled'] is bool
            ? json['pageAnimationEnabled']! as bool
            : true,
        theme: theme ?? ReaderTheme.light,
        paragraphStyle: paragraphStyle ?? ReaderParagraphStyle.book,
      );
    } on FormatException {
      return;
    } on TypeError {
      return;
    }
  }

  Future<void> _persist(ReaderPreferences value) {
    return _database.saveLocalSettingValue(
      key: _storageKey,
      valueJson: jsonEncode(<String, Object>{
        'fontSize': value.fontSize,
        'lineHeight': value.lineHeight,
        'horizontalMargin': value.horizontalMargin,
        'brightness': value.brightness,
        'pageAnimationEnabled': value.pageAnimationEnabled,
        'theme': value.theme.name,
        'paragraphStyle': value.paragraphStyle.name,
      }),
    );
  }

  double _numberInRange(
    Object? value,
    double minimum,
    double maximum,
    double fallback,
  ) {
    if (value is! num) {
      return fallback;
    }
    return value.toDouble().clamp(minimum, maximum);
  }
}
