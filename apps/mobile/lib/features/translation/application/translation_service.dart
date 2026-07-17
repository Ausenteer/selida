import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selida/core/database/app_database.dart';
import 'package:selida/core/database/database_provider.dart';
import 'package:selida/features/translation/domain/word_translation.dart';

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
  Future<TextAssistance> assistText(
    TextAssistanceRequest request,
    TextAssistanceKind kind,
  );
}

final class TranslationService implements WordTranslator, TextAssistant {
  TranslationService(this._database, {HttpClient? httpClient})
    : _httpClient = httpClient ?? HttpClient();

  final AppDatabase _database;
  final HttpClient _httpClient;

  static const _configuredBaseUrl = String.fromEnvironment(
    'SELIDA_API_BASE_URL',
  );

  String get _baseUrl {
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
      final httpRequest = await _httpClient
          .postUrl(Uri.parse('$_baseUrl/v1/translate/word'))
          .timeout(const Duration(seconds: 3));
      httpRequest.headers.contentType = ContentType.json;
      httpRequest.write(jsonEncode(request.toJson()));
      final response = await httpRequest.close().timeout(
        const Duration(seconds: 15),
      );
      final body = await utf8.decoder.bind(response).join();
      if (response.statusCode != HttpStatus.ok) {
        throw const TranslationException(TranslationFailure.unavailable);
      }
      final result = WordTranslation.fromJson(
        jsonDecode(body) as Map<String, Object?>,
      );
      await _database.saveTranslationCacheEntry(
        key: cacheKey,
        requestKind: 'word',
        resultJson: jsonEncode(result.toJson()),
      );
      return result;
    } on SocketException {
      throw const TranslationException(TranslationFailure.offline);
    } on TimeoutException {
      throw const TranslationException(TranslationFailure.unavailable);
    } on FormatException {
      throw const TranslationException(TranslationFailure.invalidResponse);
    } on HttpException {
      throw const TranslationException(TranslationFailure.unavailable);
    }
  }

  @override
  Future<TextAssistance> assistText(
    TextAssistanceRequest request,
    TextAssistanceKind kind,
  ) async {
    final cacheKey = textAssistanceCacheKey(request, kind);
    final cached = await _database.translationCacheEntry(cacheKey);
    if (cached != null) {
      try {
        return TextAssistance.fromJson(
          jsonDecode(cached.resultJson) as Map<String, Object?>,
        ).asCached();
      } on FormatException {
        // Ignore stale cache data and refresh it from the server.
      } on TypeError {
        // Ignore cache data written by an older incompatible schema.
      }
    }

    final path = switch (kind) {
      TextAssistanceKind.fragmentTranslation => '/v1/translate/fragment',
      TextAssistanceKind.explanation => '/v1/explain',
    };
    try {
      final httpRequest = await _httpClient
          .postUrl(Uri.parse('$_baseUrl$path'))
          .timeout(const Duration(seconds: 3));
      httpRequest.headers.contentType = ContentType.json;
      httpRequest.write(jsonEncode(request.toJson()));
      final response = await httpRequest.close().timeout(
        const Duration(seconds: 20),
      );
      final body = await utf8.decoder.bind(response).join();
      if (response.statusCode != HttpStatus.ok) {
        throw const TranslationException(TranslationFailure.unavailable);
      }
      final result = TextAssistance.fromJson(
        jsonDecode(body) as Map<String, Object?>,
      );
      await _database.saveTranslationCacheEntry(
        key: cacheKey,
        requestKind: kind.name,
        resultJson: jsonEncode(result.toJson()),
      );
      return result;
    } on SocketException {
      throw const TranslationException(TranslationFailure.offline);
    } on TimeoutException {
      throw const TranslationException(TranslationFailure.unavailable);
    } on FormatException {
      throw const TranslationException(TranslationFailure.invalidResponse);
    } on HttpException {
      throw const TranslationException(TranslationFailure.unavailable);
    }
  }

  void close() {
    _httpClient.close(force: true);
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
            'schemaVersion': 1,
            'promptVersion': 2,
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
