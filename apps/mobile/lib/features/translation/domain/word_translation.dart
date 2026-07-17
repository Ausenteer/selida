import 'package:flutter/foundation.dart';

@immutable
final class WordTranslationRequest {
  const WordTranslationRequest({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.interfaceLanguage,
    required this.source,
    required this.context,
  });

  final String sourceLanguage;
  final String targetLanguage;
  final String interfaceLanguage;
  final String source;
  final String context;

  Map<String, Object> toJson() => <String, Object>{
    'sourceLanguage': sourceLanguage,
    'targetLanguage': targetLanguage,
    'interfaceLanguage': interfaceLanguage,
    'source': source,
    'context': context,
  };
}

@immutable
final class WordTranslation {
  const WordTranslation({
    required this.translation,
    required this.lemma,
    required this.partOfSpeech,
    required this.formAnalysis,
    required this.fromCache,
  });

  factory WordTranslation.fromJson(Map<String, Object?> json) {
    String requiredString(String key) {
      final value = json[key];
      if (value is! String || value.trim().isEmpty) {
        throw const FormatException('Invalid translation response');
      }
      return value;
    }

    return WordTranslation(
      translation: requiredString('translation'),
      lemma: requiredString('lemma'),
      partOfSpeech: requiredString('partOfSpeech'),
      formAnalysis: requiredString('formAnalysis'),
      fromCache: json['cached'] == true,
    );
  }

  final String translation;
  final String lemma;
  final String partOfSpeech;
  final String formAnalysis;
  final bool fromCache;

  WordTranslation asCached() => WordTranslation(
    translation: translation,
    lemma: lemma,
    partOfSpeech: partOfSpeech,
    formAnalysis: formAnalysis,
    fromCache: true,
  );

  Map<String, Object> toJson() => <String, Object>{
    'translation': translation,
    'lemma': lemma,
    'partOfSpeech': partOfSpeech,
    'formAnalysis': formAnalysis,
  };
}

enum TranslationFailure { offline, unavailable, invalidResponse }

final class TranslationException implements Exception {
  const TranslationException(this.failure);

  final TranslationFailure failure;
}

enum TextAssistanceKind { fragmentTranslation, explanation }

@immutable
final class TextAssistanceRequest {
  const TextAssistanceRequest({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.interfaceLanguage,
    required this.source,
    required this.context,
  });

  final String sourceLanguage;
  final String targetLanguage;
  final String interfaceLanguage;
  final String source;
  final String context;

  Map<String, Object> toJson() => <String, Object>{
    'sourceLanguage': sourceLanguage,
    'targetLanguage': targetLanguage,
    'interfaceLanguage': interfaceLanguage,
    'source': source,
    'context': context,
  };
}

@immutable
final class TextAssistance {
  const TextAssistance({required this.content, required this.fromCache});

  factory TextAssistance.fromJson(Map<String, Object?> json) {
    final content = json['content'];
    if (content is! String || content.trim().isEmpty) {
      throw const FormatException('Invalid text assistance response');
    }
    return TextAssistance(
      content: content.trim(),
      fromCache: json['cached'] == true,
    );
  }

  final String content;
  final bool fromCache;

  TextAssistance asCached() =>
      TextAssistance(content: content, fromCache: true);

  Map<String, Object> toJson() => <String, Object>{'content': content};
}
