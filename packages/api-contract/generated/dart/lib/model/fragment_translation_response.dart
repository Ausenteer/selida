//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FragmentTranslationResponse {
  /// Returns a new [FragmentTranslationResponse] instance.
  FragmentTranslationResponse({
    required this.translation,
    required this.cached,
  });

  final String translation;

  final bool cached;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FragmentTranslationResponse &&
          other.translation == translation &&
          other.cached == cached;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (translation.hashCode) + (cached.hashCode);

  @override
  String toString() =>
      'FragmentTranslationResponse[translation=$translation, cached=$cached]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'translation'] = this.translation;
    json[r'cached'] = this.cached;
    return json;
  }

  /// Clones this instance of [FragmentTranslationResponse] and returns a new one where some of the
  /// properties have changed.
  FragmentTranslationResponse copyWith({
    String? translation,
    bool? cached,
  }) =>
      FragmentTranslationResponse(
        translation: translation ?? this.translation,
        cached: cached ?? this.cached,
      );

  /// Returns a new [FragmentTranslationResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FragmentTranslationResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'translation'),
            'Required key "FragmentTranslationResponse[translation]" is missing from JSON.');
        assert(json[r'translation'] != null,
            'Required key "FragmentTranslationResponse[translation]" has a null value in JSON.');
        assert(json.containsKey(r'cached'),
            'Required key "FragmentTranslationResponse[cached]" is missing from JSON.');
        assert(json[r'cached'] != null,
            'Required key "FragmentTranslationResponse[cached]" has a null value in JSON.');
        return true;
      }());

      return FragmentTranslationResponse(
        translation: mapValueOfType<String>(json, r'translation')!,
        cached: mapValueOfType<bool>(json, r'cached')!,
      );
    }
    return null;
  }

  static List<FragmentTranslationResponse> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <FragmentTranslationResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FragmentTranslationResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FragmentTranslationResponse> mapFromJson(dynamic json) {
    final map = <String, FragmentTranslationResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FragmentTranslationResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FragmentTranslationResponse-objects as value to a dart map
  static Map<String, List<FragmentTranslationResponse>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<FragmentTranslationResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FragmentTranslationResponse.listFromJson(
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
    'cached',
  };
}
