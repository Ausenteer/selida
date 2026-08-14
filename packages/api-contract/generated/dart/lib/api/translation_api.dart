//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TranslationApi {
  TranslationApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Explain the selected text for a language learner
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TextAssistanceRequest] textAssistanceRequest (required):
  Future<Response> explainTextWithHttpInfo(
    TextAssistanceRequest textAssistanceRequest, {
    Future<void>? abortTrigger,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/explain';

    // ignore: prefer_final_locals
    Object? postBody = textAssistanceRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Explain the selected text for a language learner
  ///
  /// Parameters:
  ///
  /// * [TextAssistanceRequest] textAssistanceRequest (required):
  Future<TextExplanationResponse?> explainText(
    TextAssistanceRequest textAssistanceRequest, {
    Future<void>? abortTrigger,
  }) async {
    final response = await explainTextWithHttpInfo(
      textAssistanceRequest,
      abortTrigger: abortTrigger,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'TextExplanationResponse',
      ) as TextExplanationResponse;
    }
    return null;
  }

  /// Translate only the selected text fragment
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TextAssistanceRequest] textAssistanceRequest (required):
  Future<Response> translateFragmentWithHttpInfo(
    TextAssistanceRequest textAssistanceRequest, {
    Future<void>? abortTrigger,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/translate/fragment';

    // ignore: prefer_final_locals
    Object? postBody = textAssistanceRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Translate only the selected text fragment
  ///
  /// Parameters:
  ///
  /// * [TextAssistanceRequest] textAssistanceRequest (required):
  Future<FragmentTranslationResponse?> translateFragment(
    TextAssistanceRequest textAssistanceRequest, {
    Future<void>? abortTrigger,
  }) async {
    final response = await translateFragmentWithHttpInfo(
      textAssistanceRequest,
      abortTrigger: abortTrigger,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'FragmentTranslationResponse',
      ) as FragmentTranslationResponse;
    }
    return null;
  }

  /// Translate and analyze one word in context
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [WordTranslationRequest] wordTranslationRequest (required):
  Future<Response> translateWordWithHttpInfo(
    WordTranslationRequest wordTranslationRequest, {
    Future<void>? abortTrigger,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/translate/word';

    // ignore: prefer_final_locals
    Object? postBody = wordTranslationRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Translate and analyze one word in context
  ///
  /// Parameters:
  ///
  /// * [WordTranslationRequest] wordTranslationRequest (required):
  Future<WordTranslationResponse?> translateWord(
    WordTranslationRequest wordTranslationRequest, {
    Future<void>? abortTrigger,
  }) async {
    final response = await translateWordWithHttpInfo(
      wordTranslationRequest,
      abortTrigger: abortTrigger,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'WordTranslationResponse',
      ) as WordTranslationResponse;
    }
    return null;
  }
}
