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
    required this.focusType,
    required this.focusText,
    required this.title,
    required this.explanation,
    required this.structure,
    required this.literalTranslation,
    required this.naturalTranslation,
    this.examples = const [],
    required this.commonMistake,
    required this.cached,
  });

  final TextExplanationResponseFocusTypeEnum focusType;

  final String focusText;

  final String title;

  final String explanation;

  final String structure;

  final String literalTranslation;

  final String naturalTranslation;

  final List<TextExplanationExample> examples;

  final String commonMistake;

  final bool cached;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextExplanationResponse &&
          other.focusType == focusType &&
          other.focusText == focusText &&
          other.title == title &&
          other.explanation == explanation &&
          other.structure == structure &&
          other.literalTranslation == literalTranslation &&
          other.naturalTranslation == naturalTranslation &&
          _deepEquality.equals(other.examples, examples) &&
          other.commonMistake == commonMistake &&
          other.cached == cached;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (focusType.hashCode) +
      (focusText.hashCode) +
      (title.hashCode) +
      (explanation.hashCode) +
      (structure.hashCode) +
      (literalTranslation.hashCode) +
      (naturalTranslation.hashCode) +
      (examples.hashCode) +
      (commonMistake.hashCode) +
      (cached.hashCode);

  @override
  String toString() =>
      'TextExplanationResponse[focusType=$focusType, focusText=$focusText, title=$title, explanation=$explanation, structure=$structure, literalTranslation=$literalTranslation, naturalTranslation=$naturalTranslation, examples=$examples, commonMistake=$commonMistake, cached=$cached]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'focusType'] = this.focusType;
    json[r'focusText'] = this.focusText;
    json[r'title'] = this.title;
    json[r'explanation'] = this.explanation;
    json[r'structure'] = this.structure;
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
    TextExplanationResponseFocusTypeEnum? focusType,
    String? focusText,
    String? title,
    String? explanation,
    String? structure,
    String? literalTranslation,
    String? naturalTranslation,
    List<TextExplanationExample>? examples,
    String? commonMistake,
    bool? cached,
  }) =>
      TextExplanationResponse(
        focusType: focusType ?? this.focusType,
        focusText: focusText ?? this.focusText,
        title: title ?? this.title,
        explanation: explanation ?? this.explanation,
        structure: structure ?? this.structure,
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
        assert(json.containsKey(r'focusType'),
            'Required key "TextExplanationResponse[focusType]" is missing from JSON.');
        assert(json[r'focusType'] != null,
            'Required key "TextExplanationResponse[focusType]" has a null value in JSON.');
        assert(json.containsKey(r'focusText'),
            'Required key "TextExplanationResponse[focusText]" is missing from JSON.');
        assert(json[r'focusText'] != null,
            'Required key "TextExplanationResponse[focusText]" has a null value in JSON.');
        assert(json.containsKey(r'title'),
            'Required key "TextExplanationResponse[title]" is missing from JSON.');
        assert(json[r'title'] != null,
            'Required key "TextExplanationResponse[title]" has a null value in JSON.');
        assert(json.containsKey(r'explanation'),
            'Required key "TextExplanationResponse[explanation]" is missing from JSON.');
        assert(json[r'explanation'] != null,
            'Required key "TextExplanationResponse[explanation]" has a null value in JSON.');
        assert(json.containsKey(r'structure'),
            'Required key "TextExplanationResponse[structure]" is missing from JSON.');
        assert(json[r'structure'] != null,
            'Required key "TextExplanationResponse[structure]" has a null value in JSON.');
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
        focusType:
            TextExplanationResponseFocusTypeEnum.fromJson(json[r'focusType'])!,
        focusText: mapValueOfType<String>(json, r'focusText')!,
        title: mapValueOfType<String>(json, r'title')!,
        explanation: mapValueOfType<String>(json, r'explanation')!,
        structure: mapValueOfType<String>(json, r'structure')!,
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
    'focusType',
    'focusText',
    'title',
    'explanation',
    'structure',
    'literalTranslation',
    'naturalTranslation',
    'examples',
    'commonMistake',
    'cached',
  };
}

enum TextExplanationResponseFocusTypeEnum {
  grammar._(r'grammar'),
  phrasalVerb._(r'phrasalVerb'),
  idiom._(r'idiom'),
  ;

  /// Instantiate a new enum with the provided value.
  const TextExplanationResponseFocusTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [TextExplanationResponseFocusTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static TextExplanationResponseFocusTypeEnum? fromJson(dynamic value) =>
      TextExplanationResponseFocusTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [TextExplanationResponseFocusTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<TextExplanationResponseFocusTypeEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TextExplanationResponseFocusTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TextExplanationResponseFocusTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TextExplanationResponseFocusTypeEnum] to String,
/// and [decode] dynamic data back to [TextExplanationResponseFocusTypeEnum].
class TextExplanationResponseFocusTypeEnumTypeTransformer {
  factory TextExplanationResponseFocusTypeEnumTypeTransformer() => _instance ??=
      const TextExplanationResponseFocusTypeEnumTypeTransformer._();

  const TextExplanationResponseFocusTypeEnumTypeTransformer._();

  String encode(TextExplanationResponseFocusTypeEnum data) => data._value;

  /// Returns the instance of [TextExplanationResponseFocusTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TextExplanationResponseFocusTypeEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is TextExplanationResponseFocusTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'grammar':
          return TextExplanationResponseFocusTypeEnum.grammar;
        case r'phrasalVerb':
          return TextExplanationResponseFocusTypeEnum.phrasalVerb;
        case r'idiom':
          return TextExplanationResponseFocusTypeEnum.idiom;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static TextExplanationResponseFocusTypeEnumTypeTransformer? _instance;
}
