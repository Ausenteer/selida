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
final class FragmentTranslation {
  const FragmentTranslation({
    required this.translation,
    required this.fromCache,
  });

  factory FragmentTranslation.fromJson(Map<String, Object?> json) {
    final translation = json['translation'];
    if (translation is! String || translation.trim().isEmpty) {
      throw const FormatException('Invalid fragment translation response');
    }
    return FragmentTranslation(
      translation: translation.trim(),
      fromCache: json['cached'] == true,
    );
  }

  final String translation;
  final bool fromCache;

  FragmentTranslation asCached() =>
      FragmentTranslation(translation: translation, fromCache: true);

  Map<String, Object> toJson() => <String, Object>{'translation': translation};
}

@immutable
final class TextExplanationExample {
  const TextExplanationExample({
    required this.source,
    required this.translation,
  });

  factory TextExplanationExample.fromJson(Map<String, Object?> json) {
    final source = json['source'];
    final translation = json['translation'];
    if (source is! String ||
        source.trim().isEmpty ||
        translation is! String ||
        translation.trim().isEmpty) {
      throw const FormatException('Invalid explanation example');
    }
    return TextExplanationExample(
      source: source.trim(),
      translation: translation.trim(),
    );
  }

  final String source;
  final String translation;

  Map<String, Object> toJson() => <String, Object>{
    'source': source,
    'translation': translation,
  };
}

@immutable
final class TextExplanation {
  const TextExplanation({
    required this.summary,
    required this.meaningInContext,
    required this.breakdown,
    required this.literalTranslation,
    required this.naturalTranslation,
    required this.examples,
    required this.commonMistake,
    required this.fromCache,
  });

  factory TextExplanation.fromJson(Map<String, Object?> json) {
    String requiredString(String key) {
      final value = json[key];
      if (value is! String || value.trim().isEmpty) {
        throw const FormatException('Invalid text explanation response');
      }
      return value.trim();
    }

    String optionalString(String key) {
      final value = json[key];
      if (value is! String) {
        throw const FormatException('Invalid text explanation response');
      }
      return value.trim();
    }

    final rawExamples = json['examples'];
    if (rawExamples is! List<Object?> || rawExamples.length > 2) {
      throw const FormatException('Invalid text explanation examples');
    }
    return TextExplanation(
      summary: requiredString('summary'),
      meaningInContext: requiredString('meaningInContext'),
      breakdown: requiredString('breakdown'),
      literalTranslation: optionalString('literalTranslation'),
      naturalTranslation: requiredString('naturalTranslation'),
      examples: List<TextExplanationExample>.unmodifiable(
        rawExamples.map(
          (Object? value) =>
              TextExplanationExample.fromJson(value as Map<String, Object?>),
        ),
      ),
      commonMistake: optionalString('commonMistake'),
      fromCache: json['cached'] == true,
    );
  }

  final String summary;
  final String meaningInContext;
  final String breakdown;
  final String literalTranslation;
  final String naturalTranslation;
  final List<TextExplanationExample> examples;
  final String commonMistake;
  final bool fromCache;

  TextExplanation asCached() => TextExplanation(
    summary: summary,
    meaningInContext: meaningInContext,
    breakdown: breakdown,
    literalTranslation: literalTranslation,
    naturalTranslation: naturalTranslation,
    examples: examples,
    commonMistake: commonMistake,
    fromCache: true,
  );

  Map<String, Object> toJson() => <String, Object>{
    'summary': summary,
    'meaningInContext': meaningInContext,
    'breakdown': breakdown,
    'literalTranslation': literalTranslation,
    'naturalTranslation': naturalTranslation,
    'examples': examples.map((example) => example.toJson()).toList(),
    'commonMistake': commonMistake,
  };
}
