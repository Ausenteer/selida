import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/translation/domain/word_translation.dart';
import 'package:selida_api_client/api.dart' as contract;

final Provider<WordTranslator> translationServiceProvider =
    Provider<WordTranslator>((Ref ref) {
      final service = TranslationService(ref.watch(databaseProvider));
      ref.onDispose(service.close);
      return service;
    });

final Provider<TextAssistant> textAssistantProvider = Provider<TextAssistant>((
  Ref ref,
) {
  final service = TranslationService(ref.watch(databaseProvider));
  ref.onDispose(service.close);
  return service;
});

abstract interface class WordTranslator {
  Future<WordTranslation> translateWord(WordTranslationRequest request);
}

abstract interface class TextAssistant {
  Future<FragmentTranslation> translateFragment(TextAssistanceRequest request);

  Future<TextExplanation> explainText(TextAssistanceRequest request);
}

final class TranslationService implements WordTranslator, TextAssistant {
  TranslationService(this._database, {contract.ApiClient? apiClient})
    : _apiClient = apiClient ?? contract.ApiClient(basePath: _baseUrl) {
    _translationApi = contract.TranslationApi(_apiClient);
  }

  final AppDatabase _database;
  final contract.ApiClient _apiClient;
  late final contract.TranslationApi _translationApi;

  static const _configuredBaseUrl = String.fromEnvironment(
    'SELIDA_API_BASE_URL',
  );

  static String get _baseUrl {
    final defaultBase = Platform.isAndroid
        ? 'http://10.0.2.2:8787'
        : 'http://127.0.0.1:8787';
    return _configuredBaseUrl.isEmpty ? defaultBase : _configuredBaseUrl;
  }

  @override
  Future<WordTranslation> translateWord(WordTranslationRequest request) async {
    final cacheKey = wordTranslationCacheKey(request);
    final cached = await _database.translationCacheEntry(cacheKey);
    if (cached != null) {
      try {
        return WordTranslation.fromJson(
          jsonDecode(cached.resultJson) as Map<String, Object?>,
        ).asCached();
      } on FormatException {
        // Ignore a stale cache row and refresh it from the server.
      } on TypeError {
        // Ignore cache data written by an older incompatible schema.
      }
    }

    try {
      final response = await _translationApi
          .translateWord(_wordContractRequest(request))
          .timeout(const Duration(seconds: 15));
      if (response == null) {
        throw const FormatException('Empty word translation response');
      }
      final result = WordTranslation(
        translation: response.translation,
        lemma: response.lemma,
        partOfSpeech: response.partOfSpeech,
        formAnalysis: response.formAnalysis,
        fromCache: response.cached,
      );
      await _database.saveTranslationCacheEntry(
        key: cacheKey,
        requestKind: 'word',
        resultJson: jsonEncode(result.toJson()),
      );
      return result;
    } on contract.ApiException catch (error) {
      throw _translationExceptionFor(error);
    } on TimeoutException {
      throw const TranslationException(TranslationFailure.unavailable);
    } on FormatException {
      throw const TranslationException(TranslationFailure.invalidResponse);
    } on TypeError {
      throw const TranslationException(TranslationFailure.invalidResponse);
    }
  }

  @override
  Future<FragmentTranslation> translateFragment(TextAssistanceRequest request) {
    return _assistText<FragmentTranslation>(
      request: request,
      kind: TextAssistanceKind.fragmentTranslation,
      parse: FragmentTranslation.fromJson,
      asCached: (FragmentTranslation value) => value.asCached(),
      toJson: (FragmentTranslation value) => value.toJson(),
      requestRemote: () async {
        final response = await _translationApi.translateFragment(
          _textContractRequest(request),
        );
        if (response == null) {
          throw const FormatException('Empty fragment translation response');
        }
        return FragmentTranslation(
          translation: response.translation,
          fromCache: response.cached,
        );
      },
    );
  }

  @override
  Future<TextExplanation> explainText(TextAssistanceRequest request) {
    return _assistText<TextExplanation>(
      request: request,
      kind: TextAssistanceKind.explanation,
      parse: TextExplanation.fromJson,
      asCached: (TextExplanation value) => value.asCached(),
      toJson: (TextExplanation value) => value.toJson(),
      requestRemote: () async {
        final response = await _translationApi.explainText(
          _textContractRequest(request),
        );
        if (response == null) {
          throw const FormatException('Empty text explanation response');
        }
        return TextExplanation(
          focus: switch (response.focusType) {
            contract.TextExplanationResponseFocusTypeEnum.phrasalVerb =>
              TextExplanationFocus.phrasalVerb,
            contract.TextExplanationResponseFocusTypeEnum.idiom =>
              TextExplanationFocus.idiom,
            _ => TextExplanationFocus.grammar,
          },
          focusText: response.focusText,
          title: response.title,
          explanation: response.explanation,
          structure: response.structure,
          literalTranslation: response.literalTranslation,
          naturalTranslation: response.naturalTranslation,
          examples: <TextExplanationExample>[
            for (final example in response.examples)
              TextExplanationExample(
                source: example.source_,
                translation: example.translation,
              ),
          ],
          commonMistake: response.commonMistake,
          fromCache: response.cached,
        );
      },
    );
  }

  Future<T> _assistText<T>({
    required TextAssistanceRequest request,
    required TextAssistanceKind kind,
    required T Function(Map<String, Object?> json) parse,
    required T Function(T value) asCached,
    required Map<String, Object> Function(T value) toJson,
    required Future<T> Function() requestRemote,
  }) async {
    final cacheKey = textAssistanceCacheKey(request, kind);
    final cached = await _database.translationCacheEntry(cacheKey);
    if (cached != null) {
      try {
        return asCached(
          parse(jsonDecode(cached.resultJson) as Map<String, Object?>),
        );
      } on FormatException {
        // Ignore stale cache data and refresh it from the server.
      } on TypeError {
        // Ignore cache data written by an older incompatible schema.
      }
    }

    try {
      final result = await requestRemote().timeout(const Duration(seconds: 20));
      await _database.saveTranslationCacheEntry(
        key: cacheKey,
        requestKind: kind.name,
        resultJson: jsonEncode(toJson(result)),
      );
      return result;
    } on contract.ApiException catch (error) {
      throw _translationExceptionFor(error);
    } on TimeoutException {
      throw const TranslationException(TranslationFailure.unavailable);
    } on FormatException {
      throw const TranslationException(TranslationFailure.invalidResponse);
    } on TypeError {
      throw const TranslationException(TranslationFailure.invalidResponse);
    }
  }

  void close() {
    _apiClient.client.close();
  }

  contract.WordTranslationRequest _wordContractRequest(
    WordTranslationRequest request,
  ) {
    return contract.WordTranslationRequest(
      sourceLanguage: request.sourceLanguage == 'el'
          ? contract.WordTranslationRequestSourceLanguageEnum.el
          : contract.WordTranslationRequestSourceLanguageEnum.en,
      targetLanguage: contract.WordTranslationRequestTargetLanguageEnum.ru,
      interfaceLanguage: request.interfaceLanguage == 'en'
          ? contract.WordTranslationRequestInterfaceLanguageEnum.en
          : contract.WordTranslationRequestInterfaceLanguageEnum.ru,
      source_: request.source,
      context: request.context,
    );
  }

  contract.TextAssistanceRequest _textContractRequest(
    TextAssistanceRequest request,
  ) {
    return contract.TextAssistanceRequest(
      sourceLanguage: request.sourceLanguage == 'el'
          ? contract.TextAssistanceRequestSourceLanguageEnum.el
          : contract.TextAssistanceRequestSourceLanguageEnum.en,
      targetLanguage: contract.TextAssistanceRequestTargetLanguageEnum.ru,
      interfaceLanguage: request.interfaceLanguage == 'en'
          ? contract.TextAssistanceRequestInterfaceLanguageEnum.en
          : contract.TextAssistanceRequestInterfaceLanguageEnum.ru,
      source_: request.source,
      context: request.context,
    );
  }

  TranslationException _translationExceptionFor(contract.ApiException error) {
    if (error.message?.startsWith('Exception during deserialization') ??
        false) {
      return const TranslationException(TranslationFailure.invalidResponse);
    }
    if (error.innerException != null) {
      return const TranslationException(TranslationFailure.offline);
    }
    return const TranslationException(TranslationFailure.unavailable);
  }
}

String wordTranslationCacheKey(WordTranslationRequest request) {
  final contextHash = sha256.convert(utf8.encode(request.context.trim()));
  final source = request.source.trim().toLowerCase();
  return sha256
      .convert(
        utf8.encode(
          jsonEncode(<String, Object>{
            'kind': 'word',
            'sourceLanguage': request.sourceLanguage,
            'targetLanguage': request.targetLanguage,
            'source': source,
            'contextHash': contextHash.toString(),
            'schemaVersion': 1,
            'promptVersion': 1,
          }),
        ),
      )
      .toString();
}

String textAssistanceCacheKey(
  TextAssistanceRequest request,
  TextAssistanceKind kind,
) {
  return sha256
      .convert(
        utf8.encode(
          jsonEncode(<String, Object>{
            'kind': kind.name,
            'sourceLanguage': request.sourceLanguage,
            'targetLanguage': request.targetLanguage,
            'interfaceLanguage': request.interfaceLanguage,
            'source': request.source.trim(),
            'contextHash': sha256
                .convert(utf8.encode(request.context.trim()))
                .toString(),
            'schemaVersion': kind == TextAssistanceKind.explanation ? 5 : 2,
            'promptVersion': kind == TextAssistanceKind.explanation ? 7 : 3,
          }),
        ),
      )
      .toString();
}

bool isSingleVocabularyItem(String source) {
  final trimmed = source.trim();
  return trimmed.isNotEmpty && !RegExp(r'\s').hasMatch(trimmed);
}

SentenceContext sentenceContextAround({
  required String text,
  required int startOffset,
  required int endOffset,
}) {
  if (text.isEmpty) {
    return const SentenceContext(text: '', startOffset: 0, endOffset: 0);
  }
  final safeStart = startOffset.clamp(0, text.length);
  final safeEnd = endOffset.clamp(safeStart, text.length);
  const boundaries = <String>{'.', '!', '?', '·', ';', '\n'};
  var start = safeStart;
  while (start > 0 && !boundaries.contains(text[start - 1])) {
    start -= 1;
  }
  var end = safeEnd;
  while (end < text.length && !boundaries.contains(text[end])) {
    end += 1;
  }
  if (end < text.length && text[end] != '\n') {
    end += 1;
  }
  while (start < safeStart && text[start].trim().isEmpty) {
    start += 1;
  }
  while (end > safeEnd && text[end - 1].trim().isEmpty) {
    end -= 1;
  }

  if (end - start > 2000) {
    final wordCenter = (safeStart + safeEnd) ~/ 2;
    start = (wordCenter - 1000).clamp(0, text.length);
    end = (start + 2000).clamp(start, text.length);
    start = (end - 2000).clamp(0, end);
  }
  return SentenceContext(
    text: text.substring(start, end),
    startOffset: start,
    endOffset: end,
  );
}

String sentenceAround({
  required String text,
  required int startOffset,
  required int endOffset,
}) => sentenceContextAround(
  text: text,
  startOffset: startOffset,
  endOffset: endOffset,
).text;

final class SentenceContext {
  const SentenceContext({
    required this.text,
    required this.startOffset,
    required this.endOffset,
  });

  final String text;
  final int startOffset;
  final int endOffset;
}
