//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WordTranslationRequest {
  /// Returns a new [WordTranslationRequest] instance.
  WordTranslationRequest({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.interfaceLanguage,
    required this.source_,
    required this.context,
  });

  final WordTranslationRequestSourceLanguageEnum sourceLanguage;

  final WordTranslationRequestTargetLanguageEnum targetLanguage;

  final WordTranslationRequestInterfaceLanguageEnum interfaceLanguage;

  final String source_;

  final String context;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordTranslationRequest &&
          other.sourceLanguage == sourceLanguage &&
          other.targetLanguage == targetLanguage &&
          other.interfaceLanguage == interfaceLanguage &&
          other.source_ == source_ &&
          other.context == context;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (sourceLanguage.hashCode) +
      (targetLanguage.hashCode) +
      (interfaceLanguage.hashCode) +
      (source_.hashCode) +
      (context.hashCode);

  @override
  String toString() =>
      'WordTranslationRequest[sourceLanguage=$sourceLanguage, targetLanguage=$targetLanguage, interfaceLanguage=$interfaceLanguage, source_=$source_, context=$context]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'sourceLanguage'] = this.sourceLanguage;
    json[r'targetLanguage'] = this.targetLanguage;
    json[r'interfaceLanguage'] = this.interfaceLanguage;
    json[r'source'] = this.source_;
    json[r'context'] = this.context;
    return json;
  }

  /// Clones this instance of [WordTranslationRequest] and returns a new one where some of the
  /// properties have changed.
  WordTranslationRequest copyWith({
    WordTranslationRequestSourceLanguageEnum? sourceLanguage,
    WordTranslationRequestTargetLanguageEnum? targetLanguage,
    WordTranslationRequestInterfaceLanguageEnum? interfaceLanguage,
    String? source_,
    String? context,
  }) =>
      WordTranslationRequest(
        sourceLanguage: sourceLanguage ?? this.sourceLanguage,
        targetLanguage: targetLanguage ?? this.targetLanguage,
        interfaceLanguage: interfaceLanguage ?? this.interfaceLanguage,
        source_: source_ ?? this.source_,
        context: context ?? this.context,
      );

  /// Returns a new [WordTranslationRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WordTranslationRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'sourceLanguage'),
            'Required key "WordTranslationRequest[sourceLanguage]" is missing from JSON.');
        assert(json[r'sourceLanguage'] != null,
            'Required key "WordTranslationRequest[sourceLanguage]" has a null value in JSON.');
        assert(json.containsKey(r'targetLanguage'),
            'Required key "WordTranslationRequest[targetLanguage]" is missing from JSON.');
        assert(json[r'targetLanguage'] != null,
            'Required key "WordTranslationRequest[targetLanguage]" has a null value in JSON.');
        assert(json.containsKey(r'interfaceLanguage'),
            'Required key "WordTranslationRequest[interfaceLanguage]" is missing from JSON.');
        assert(json[r'interfaceLanguage'] != null,
            'Required key "WordTranslationRequest[interfaceLanguage]" has a null value in JSON.');
        assert(json.containsKey(r'source'),
            'Required key "WordTranslationRequest[source]" is missing from JSON.');
        assert(json[r'source'] != null,
            'Required key "WordTranslationRequest[source]" has a null value in JSON.');
        assert(json.containsKey(r'context'),
            'Required key "WordTranslationRequest[context]" is missing from JSON.');
        assert(json[r'context'] != null,
            'Required key "WordTranslationRequest[context]" has a null value in JSON.');
        return true;
      }());

      return WordTranslationRequest(
        sourceLanguage: WordTranslationRequestSourceLanguageEnum.fromJson(
            json[r'sourceLanguage'])!,
        targetLanguage: WordTranslationRequestTargetLanguageEnum.fromJson(
            json[r'targetLanguage'])!,
        interfaceLanguage: WordTranslationRequestInterfaceLanguageEnum.fromJson(
            json[r'interfaceLanguage'])!,
        source_: mapValueOfType<String>(json, r'source')!,
        context: mapValueOfType<String>(json, r'context')!,
      );
    }
    return null;
  }

  static List<WordTranslationRequest> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WordTranslationRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WordTranslationRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WordTranslationRequest> mapFromJson(dynamic json) {
    final map = <String, WordTranslationRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WordTranslationRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WordTranslationRequest-objects as value to a dart map
  static Map<String, List<WordTranslationRequest>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<WordTranslationRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WordTranslationRequest.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sourceLanguage',
    'targetLanguage',
    'interfaceLanguage',
    'source',
    'context',
  };
}

enum WordTranslationRequestSourceLanguageEnum {
  en._(r'en'),
  el._(r'el'),
  ;

  /// Instantiate a new enum with the provided value.
  const WordTranslationRequestSourceLanguageEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [WordTranslationRequestSourceLanguageEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static WordTranslationRequestSourceLanguageEnum? fromJson(dynamic value) =>
      WordTranslationRequestSourceLanguageEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [WordTranslationRequestSourceLanguageEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<WordTranslationRequestSourceLanguageEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WordTranslationRequestSourceLanguageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WordTranslationRequestSourceLanguageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WordTranslationRequestSourceLanguageEnum] to String,
/// and [decode] dynamic data back to [WordTranslationRequestSourceLanguageEnum].
class WordTranslationRequestSourceLanguageEnumTypeTransformer {
  factory WordTranslationRequestSourceLanguageEnumTypeTransformer() =>
      _instance ??=
          const WordTranslationRequestSourceLanguageEnumTypeTransformer._();

  const WordTranslationRequestSourceLanguageEnumTypeTransformer._();

  String encode(WordTranslationRequestSourceLanguageEnum data) => data._value;

  /// Returns the instance of [WordTranslationRequestSourceLanguageEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WordTranslationRequestSourceLanguageEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is WordTranslationRequestSourceLanguageEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'en':
          return WordTranslationRequestSourceLanguageEnum.en;
        case r'el':
          return WordTranslationRequestSourceLanguageEnum.el;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static WordTranslationRequestSourceLanguageEnumTypeTransformer? _instance;
}

enum WordTranslationRequestTargetLanguageEnum {
  ru._(r'ru'),
  ;

  /// Instantiate a new enum with the provided value.
  const WordTranslationRequestTargetLanguageEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [WordTranslationRequestTargetLanguageEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static WordTranslationRequestTargetLanguageEnum? fromJson(dynamic value) =>
      WordTranslationRequestTargetLanguageEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [WordTranslationRequestTargetLanguageEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<WordTranslationRequestTargetLanguageEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WordTranslationRequestTargetLanguageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WordTranslationRequestTargetLanguageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WordTranslationRequestTargetLanguageEnum] to String,
/// and [decode] dynamic data back to [WordTranslationRequestTargetLanguageEnum].
class WordTranslationRequestTargetLanguageEnumTypeTransformer {
  factory WordTranslationRequestTargetLanguageEnumTypeTransformer() =>
      _instance ??=
          const WordTranslationRequestTargetLanguageEnumTypeTransformer._();

  const WordTranslationRequestTargetLanguageEnumTypeTransformer._();

  String encode(WordTranslationRequestTargetLanguageEnum data) => data._value;

  /// Returns the instance of [WordTranslationRequestTargetLanguageEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WordTranslationRequestTargetLanguageEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is WordTranslationRequestTargetLanguageEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'ru':
          return WordTranslationRequestTargetLanguageEnum.ru;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static WordTranslationRequestTargetLanguageEnumTypeTransformer? _instance;
}

enum WordTranslationRequestInterfaceLanguageEnum {
  ru._(r'ru'),
  en._(r'en'),
  ;

  /// Instantiate a new enum with the provided value.
  const WordTranslationRequestInterfaceLanguageEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [WordTranslationRequestInterfaceLanguageEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static WordTranslationRequestInterfaceLanguageEnum? fromJson(dynamic value) =>
      WordTranslationRequestInterfaceLanguageEnumTypeTransformer()
          .decode(value);

  /// Returns a [List] containing instances of [WordTranslationRequestInterfaceLanguageEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<WordTranslationRequestInterfaceLanguageEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <WordTranslationRequestInterfaceLanguageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WordTranslationRequestInterfaceLanguageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WordTranslationRequestInterfaceLanguageEnum] to String,
/// and [decode] dynamic data back to [WordTranslationRequestInterfaceLanguageEnum].
class WordTranslationRequestInterfaceLanguageEnumTypeTransformer {
  factory WordTranslationRequestInterfaceLanguageEnumTypeTransformer() =>
      _instance ??=
          const WordTranslationRequestInterfaceLanguageEnumTypeTransformer._();

  const WordTranslationRequestInterfaceLanguageEnumTypeTransformer._();

  String encode(WordTranslationRequestInterfaceLanguageEnum data) =>
      data._value;

  /// Returns the instance of [WordTranslationRequestInterfaceLanguageEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WordTranslationRequestInterfaceLanguageEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is WordTranslationRequestInterfaceLanguageEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'ru':
          return WordTranslationRequestInterfaceLanguageEnum.ru;
        case r'en':
          return WordTranslationRequestInterfaceLanguageEnum.en;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static WordTranslationRequestInterfaceLanguageEnumTypeTransformer? _instance;
}
