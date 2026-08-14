//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TextExplanationResponse {
  /// Returns a new [TextExplanationResponse] instance.
  TextExplanationResponse({
    required this.summary,
    required this.meaningInContext,
    required this.breakdown,
    required this.literalTranslation,
    required this.naturalTranslation,
    this.examples = const [],
    required this.commonMistake,
    required this.cached,
  });

  final String summary;

  final String meaningInContext;

  final String breakdown;

  final String literalTranslation;

  final String naturalTranslation;

  final List<TextExplanationExample> examples;

  final String commonMistake;

  final bool cached;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextExplanationResponse &&
          other.summary == summary &&
          other.meaningInContext == meaningInContext &&
          other.breakdown == breakdown &&
          other.literalTranslation == literalTranslation &&
          other.naturalTranslation == naturalTranslation &&
          _deepEquality.equals(other.examples, examples) &&
          other.commonMistake == commonMistake &&
          other.cached == cached;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (summary.hashCode) +
      (meaningInContext.hashCode) +
      (breakdown.hashCode) +
      (literalTranslation.hashCode) +
      (naturalTranslation.hashCode) +
      (examples.hashCode) +
      (commonMistake.hashCode) +
      (cached.hashCode);

  @override
  String toString() =>
      'TextExplanationResponse[summary=$summary, meaningInContext=$meaningInContext, breakdown=$breakdown, literalTranslation=$literalTranslation, naturalTranslation=$naturalTranslation, examples=$examples, commonMistake=$commonMistake, cached=$cached]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'summary'] = this.summary;
    json[r'meaningInContext'] = this.meaningInContext;
    json[r'breakdown'] = this.breakdown;
    json[r'literalTranslation'] = this.literalTranslation;
    json[r'naturalTranslation'] = this.naturalTranslation;
    json[r'examples'] = this.examples;
    json[r'commonMistake'] = this.commonMistake;
    json[r'cached'] = this.cached;
    return json;
  }

  /// Clones this instance of [TextExplanationResponse] and returns a new one where some of the
  /// properties have changed.
  TextExplanationResponse copyWith({
    String? summary,
    String? meaningInContext,
    String? breakdown,
    String? literalTranslation,
    String? naturalTranslation,
    List<TextExplanationExample>? examples,
    String? commonMistake,
    bool? cached,
  }) =>
      TextExplanationResponse(
        summary: summary ?? this.summary,
        meaningInContext: meaningInContext ?? this.meaningInContext,
        breakdown: breakdown ?? this.breakdown,
        literalTranslation: literalTranslation ?? this.literalTranslation,
        naturalTranslation: naturalTranslation ?? this.naturalTranslation,
        examples: examples ?? this.examples,
        commonMistake: commonMistake ?? this.commonMistake,
        cached: cached ?? this.cached,
      );

  /// Returns a new [TextExplanationResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TextExplanationResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'summary'),
            'Required key "TextExplanationResponse[summary]" is missing from JSON.');
        assert(json[r'summary'] != null,
            'Required key "TextExplanationResponse[summary]" has a null value in JSON.');
        assert(json.containsKey(r'meaningInContext'),
            'Required key "TextExplanationResponse[meaningInContext]" is missing from JSON.');
        assert(json[r'meaningInContext'] != null,
            'Required key "TextExplanationResponse[meaningInContext]" has a null value in JSON.');
        assert(json.containsKey(r'breakdown'),
            'Required key "TextExplanationResponse[breakdown]" is missing from JSON.');
        assert(json[r'breakdown'] != null,
            'Required key "TextExplanationResponse[breakdown]" has a null value in JSON.');
        assert(json.containsKey(r'literalTranslation'),
            'Required key "TextExplanationResponse[literalTranslation]" is missing from JSON.');
        assert(json[r'literalTranslation'] != null,
            'Required key "TextExplanationResponse[literalTranslation]" has a null value in JSON.');
        assert(json.containsKey(r'naturalTranslation'),
            'Required key "TextExplanationResponse[naturalTranslation]" is missing from JSON.');
        assert(json[r'naturalTranslation'] != null,
            'Required key "TextExplanationResponse[naturalTranslation]" has a null value in JSON.');
        assert(json.containsKey(r'examples'),
            'Required key "TextExplanationResponse[examples]" is missing from JSON.');
        assert(json[r'examples'] != null,
            'Required key "TextExplanationResponse[examples]" has a null value in JSON.');
        assert(json.containsKey(r'commonMistake'),
            'Required key "TextExplanationResponse[commonMistake]" is missing from JSON.');
        assert(json[r'commonMistake'] != null,
            'Required key "TextExplanationResponse[commonMistake]" has a null value in JSON.');
        assert(json.containsKey(r'cached'),
            'Required key "TextExplanationResponse[cached]" is missing from JSON.');
        assert(json[r'cached'] != null,
            'Required key "TextExplanationResponse[cached]" has a null value in JSON.');
        return true;
      }());

      return TextExplanationResponse(
        summary: mapValueOfType<String>(json, r'summary')!,
        meaningInContext: mapValueOfType<String>(json, r'meaningInContext')!,
        breakdown: mapValueOfType<String>(json, r'breakdown')!,
        literalTranslation:
            mapValueOfType<String>(json, r'literalTranslation')!,
        naturalTranslation:
            mapValueOfType<String>(json, r'naturalTranslation')!,
        examples: TextExplanationExample.listFromJson(json[r'examples']),
        commonMistake: mapValueOfType<String>(json, r'commonMistake')!,
        cached: mapValueOfType<bool>(json, r'cached')!,
      );
    }
    return null;
  }

  static List<TextExplanationResponse> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TextExplanationResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TextExplanationResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TextExplanationResponse> mapFromJson(dynamic json) {
    final map = <String, TextExplanationResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TextExplanationResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TextExplanationResponse-objects as value to a dart map
  static Map<String, List<TextExplanationResponse>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<TextExplanationResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TextExplanationResponse.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'summary',
    'meaningInContext',
    'breakdown',
    'literalTranslation',
    'naturalTranslation',
    'examples',
    'commonMistake',
    'cached',
  };
}
