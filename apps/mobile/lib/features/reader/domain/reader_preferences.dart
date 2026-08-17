import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/reader/domain/reader_page.dart';

enum ReaderTheme { light, sepia, dark }

enum ReaderAssistanceLanguage { russian, english }

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
    this.textAlignment = ReaderTextAlignment.justified,
    this.fontFamily = ReaderFontFamily.literata,
    this.assistanceLanguage = ReaderAssistanceLanguage.russian,
  });

  final double fontSize;
  final double lineHeight;
  final double horizontalMargin;
  final double brightness;
  final bool pageAnimationEnabled;
  final ReaderTheme theme;
  final ReaderParagraphStyle paragraphStyle;
  final ReaderTextAlignment textAlignment;
  final ReaderFontFamily fontFamily;
  final ReaderAssistanceLanguage assistanceLanguage;

  ReaderPreferences copyWith({
    double? fontSize,
    double? lineHeight,
    double? horizontalMargin,
    double? brightness,
    bool? pageAnimationEnabled,
    ReaderTheme? theme,
    ReaderParagraphStyle? paragraphStyle,
    ReaderTextAlignment? textAlignment,
    ReaderFontFamily? fontFamily,
    ReaderAssistanceLanguage? assistanceLanguage,
  }) {
    return ReaderPreferences(
      fontSize: fontSize ?? this.fontSize,
      lineHeight: lineHeight ?? this.lineHeight,
      horizontalMargin: horizontalMargin ?? this.horizontalMargin,
      brightness: brightness ?? this.brightness,
      pageAnimationEnabled: pageAnimationEnabled ?? this.pageAnimationEnabled,
      theme: theme ?? this.theme,
      paragraphStyle: paragraphStyle ?? this.paragraphStyle,
      textAlignment: textAlignment ?? this.textAlignment,
      fontFamily: fontFamily ?? this.fontFamily,
      assistanceLanguage: assistanceLanguage ?? this.assistanceLanguage,
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
  static const _schemaVersion = 3;

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

  void setTextAlignment(ReaderTextAlignment value) {
    _set(state.copyWith(textAlignment: value));
  }

  void setFontFamily(ReaderFontFamily value) {
    _set(state.copyWith(fontFamily: value));
  }

  void setAssistanceLanguage(ReaderAssistanceLanguage value) {
    _set(state.copyWith(assistanceLanguage: value));
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
      final schemaVersion = json['schemaVersion'] is num
          ? (json['schemaVersion']! as num).toInt()
          : 1;
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
      final textAlignmentName = json['textAlignment'] as String?;
      final textAlignment = ReaderTextAlignment.values
          .where((ReaderTextAlignment value) => value.name == textAlignmentName)
          .firstOrNull;
      final fontFamilyName = json['fontFamily'] as String?;
      final fontFamily = ReaderFontFamily.values
          .where((ReaderFontFamily value) => value.name == fontFamilyName)
          .firstOrNull;
      final assistanceLanguageName = json['assistanceLanguage'] as String?;
      final assistanceLanguage = ReaderAssistanceLanguage.values
          .where(
            (ReaderAssistanceLanguage value) =>
                value.name == assistanceLanguageName,
          )
          .firstOrNull;
      state = ReaderPreferences(
        fontSize: _numberInRange(json['fontSize'], 15, 24, 18),
        lineHeight: _numberInRange(json['lineHeight'], 1.3, 1.8, 1.55),
        horizontalMargin: _numberInRange(json['horizontalMargin'], 16, 36, 24),
        brightness: schemaVersion < 3
            ? 1
            : _numberInRange(json['brightness'], 0.25, 1, 1),
        pageAnimationEnabled: json['pageAnimationEnabled'] is bool
            ? json['pageAnimationEnabled']! as bool
            : true,
        theme: theme ?? ReaderTheme.light,
        paragraphStyle: paragraphStyle ?? ReaderParagraphStyle.book,
        textAlignment: schemaVersion < _schemaVersion
            ? ReaderTextAlignment.justified
            : textAlignment ?? ReaderTextAlignment.justified,
        fontFamily: fontFamily ?? ReaderFontFamily.literata,
        assistanceLanguage:
            assistanceLanguage ?? ReaderAssistanceLanguage.russian,
      );
      if (schemaVersion < _schemaVersion) {
        unawaited(_persist(state));
      }
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
        'schemaVersion': _schemaVersion,
        'fontSize': value.fontSize,
        'lineHeight': value.lineHeight,
        'horizontalMargin': value.horizontalMargin,
        'brightness': value.brightness,
        'pageAnimationEnabled': value.pageAnimationEnabled,
        'theme': value.theme.name,
        'paragraphStyle': value.paragraphStyle.name,
        'textAlignment': value.textAlignment.name,
        'fontFamily': value.fontFamily.name,
        'assistanceLanguage': value.assistanceLanguage.name,
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
