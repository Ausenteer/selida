//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WordTranslationResponse {
  /// Returns a new [WordTranslationResponse] instance.
  WordTranslationResponse({
    required this.translation,
    required this.lemma,
    required this.partOfSpeech,
    required this.formAnalysis,
    required this.cached,
  });

  final String translation;

  final String lemma;

  final String partOfSpeech;

  final String formAnalysis;

  final bool cached;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordTranslationResponse &&
          other.translation == translation &&
          other.lemma == lemma &&
          other.partOfSpeech == partOfSpeech &&
          other.formAnalysis == formAnalysis &&
          other.cached == cached;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (translation.hashCode) +
      (lemma.hashCode) +
      (partOfSpeech.hashCode) +
      (formAnalysis.hashCode) +
      (cached.hashCode);

  @override
  String toString() =>
      'WordTranslationResponse[translation=$translation, lemma=$lemma, partOfSpeech=$partOfSpeech, formAnalysis=$formAnalysis, cached=$cached]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'translation'] = this.translation;
    json[r'lemma'] = this.lemma;
    json[r'partOfSpeech'] = this.partOfSpeech;
    json[r'formAnalysis'] = this.formAnalysis;
    json[r'cached'] = this.cached;
    return json;
  }

  /// Clones this instance of [WordTranslationResponse] and returns a new one where some of the
  /// properties have changed.
  WordTranslationResponse copyWith({
    String? translation,
    String? lemma,
    String? partOfSpeech,
    String? formAnalysis,
    bool? cached,
  }) =>
      WordTranslationResponse(
        translation: translation ?? this.translation,
        lemma: lemma ?? this.lemma,
        partOfSpeech: partOfSpeech ?? this.partOfSpeech,
        formAnalysis: formAnalysis ?? this.formAnalysis,
        cached: cached ?? this.cached,
      );

  /// Returns a new [WordTranslationResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WordTranslationResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'translation'),
            'Required key "WordTranslationResponse[translation]" is missing from JSON.');
        assert(json[r'translation'] != null,
            'Required key "WordTranslationResponse[translation]" has a null value in JSON.');
        assert(json.containsKey(r'lemma'),
            'Required key "WordTranslationResponse[lemma]" is missing from JSON.');
        assert(json[r'lemma'] != null,
            'Required key "WordTranslationResponse[lemma]" has a null value in JSON.');
        assert(json.containsKey(r'partOfSpeech'),
            'Required key "WordTranslationResponse[partOfSpeech]" is missing from JSON.');
        assert(json[r'partOfSpeech'] != null,
            'Required key "WordTranslationResponse[partOfSpeech]" has a null value in JSON.');
        assert(json.containsKey(r'formAnalysis'),
            'Required key "WordTranslationResponse[formAnalysis]" is missing from JSON.');
        assert(json[r'formAnalysis'] != null,
            'Required key "WordTranslationResponse[formAnalysis]" has a null value in JSON.');
        assert(json.containsKey(r'cached'),
            'Required key "WordTranslationResponse[cached]" is missing from JSON.');
        assert(json[r'cached'] != null,
            'Required key "WordTranslationResponse[cached]" has a null value in JSON.');
        return true;
      }());

      return WordTranslationResponse(
        translation: mapValueOfType<String>(json, r'translation')!,
        lemma: mapValueOfType<String>(json, r'lemma')!,
        partOfSpeech: mapValueOfType<String>(json, r'partOfSpeech')!,
        formAnalysis: mapValueOfType<String>(json, r'formAnalysis')!,
        cached: mapValueOfType<bool>(json, r'cached')!,
      );
    }
    return null;
  }

  static List<WordTranslationResponse> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WordTranslationResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WordTranslationResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WordTranslationResponse> mapFromJson(dynamic json) {
    final map = <String, WordTranslationResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WordTranslationResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WordTranslationResponse-objects as value to a dart map
  static Map<String, List<WordTranslationResponse>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<WordTranslationResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WordTranslationResponse.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'translation',
    'lemma',
    'partOfSpeech',
    'formAnalysis',
    'cached',
  };
}
