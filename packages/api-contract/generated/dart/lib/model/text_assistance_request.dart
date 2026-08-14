//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TextAssistanceRequest {
  /// Returns a new [TextAssistanceRequest] instance.
  TextAssistanceRequest({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.interfaceLanguage,
    required this.source_,
    required this.context,
  });

  final TextAssistanceRequestSourceLanguageEnum sourceLanguage;

  final TextAssistanceRequestTargetLanguageEnum targetLanguage;

  final TextAssistanceRequestInterfaceLanguageEnum interfaceLanguage;

  final String source_;

  final String context;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextAssistanceRequest &&
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
      'TextAssistanceRequest[sourceLanguage=$sourceLanguage, targetLanguage=$targetLanguage, interfaceLanguage=$interfaceLanguage, source_=$source_, context=$context]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'sourceLanguage'] = this.sourceLanguage;
    json[r'targetLanguage'] = this.targetLanguage;
    json[r'interfaceLanguage'] = this.interfaceLanguage;
    json[r'source'] = this.source_;
    json[r'context'] = this.context;
    return json;
  }

  /// Clones this instance of [TextAssistanceRequest] and returns a new one where some of the
  /// properties have changed.
  TextAssistanceRequest copyWith({
    TextAssistanceRequestSourceLanguageEnum? sourceLanguage,
    TextAssistanceRequestTargetLanguageEnum? targetLanguage,
    TextAssistanceRequestInterfaceLanguageEnum? interfaceLanguage,
    String? source_,
    String? context,
  }) =>
      TextAssistanceRequest(
        sourceLanguage: sourceLanguage ?? this.sourceLanguage,
        targetLanguage: targetLanguage ?? this.targetLanguage,
        interfaceLanguage: interfaceLanguage ?? this.interfaceLanguage,
        source_: source_ ?? this.source_,
        context: context ?? this.context,
      );

  /// Returns a new [TextAssistanceRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TextAssistanceRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'sourceLanguage'),
            'Required key "TextAssistanceRequest[sourceLanguage]" is missing from JSON.');
        assert(json[r'sourceLanguage'] != null,
            'Required key "TextAssistanceRequest[sourceLanguage]" has a null value in JSON.');
        assert(json.containsKey(r'targetLanguage'),
            'Required key "TextAssistanceRequest[targetLanguage]" is missing from JSON.');
        assert(json[r'targetLanguage'] != null,
            'Required key "TextAssistanceRequest[targetLanguage]" has a null value in JSON.');
        assert(json.containsKey(r'interfaceLanguage'),
            'Required key "TextAssistanceRequest[interfaceLanguage]" is missing from JSON.');
        assert(json[r'interfaceLanguage'] != null,
            'Required key "TextAssistanceRequest[interfaceLanguage]" has a null value in JSON.');
        assert(json.containsKey(r'source'),
            'Required key "TextAssistanceRequest[source]" is missing from JSON.');
        assert(json[r'source'] != null,
            'Required key "TextAssistanceRequest[source]" has a null value in JSON.');
        assert(json.containsKey(r'context'),
            'Required key "TextAssistanceRequest[context]" is missing from JSON.');
        assert(json[r'context'] != null,
            'Required key "TextAssistanceRequest[context]" has a null value in JSON.');
        return true;
      }());

      return TextAssistanceRequest(
        sourceLanguage: TextAssistanceRequestSourceLanguageEnum.fromJson(
            json[r'sourceLanguage'])!,
        targetLanguage: TextAssistanceRequestTargetLanguageEnum.fromJson(
            json[r'targetLanguage'])!,
        interfaceLanguage: TextAssistanceRequestInterfaceLanguageEnum.fromJson(
            json[r'interfaceLanguage'])!,
        source_: mapValueOfType<String>(json, r'source')!,
        context: mapValueOfType<String>(json, r'context')!,
      );
    }
    return null;
  }

  static List<TextAssistanceRequest> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TextAssistanceRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TextAssistanceRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TextAssistanceRequest> mapFromJson(dynamic json) {
    final map = <String, TextAssistanceRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TextAssistanceRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TextAssistanceRequest-objects as value to a dart map
  static Map<String, List<TextAssistanceRequest>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<TextAssistanceRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TextAssistanceRequest.listFromJson(
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

enum TextAssistanceRequestSourceLanguageEnum {
  en._(r'en'),
  el._(r'el'),
  ;

  /// Instantiate a new enum with the provided value.
  const TextAssistanceRequestSourceLanguageEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [TextAssistanceRequestSourceLanguageEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static TextAssistanceRequestSourceLanguageEnum? fromJson(dynamic value) =>
      TextAssistanceRequestSourceLanguageEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [TextAssistanceRequestSourceLanguageEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<TextAssistanceRequestSourceLanguageEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TextAssistanceRequestSourceLanguageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TextAssistanceRequestSourceLanguageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TextAssistanceRequestSourceLanguageEnum] to String,
/// and [decode] dynamic data back to [TextAssistanceRequestSourceLanguageEnum].
class TextAssistanceRequestSourceLanguageEnumTypeTransformer {
  factory TextAssistanceRequestSourceLanguageEnumTypeTransformer() =>
      _instance ??=
          const TextAssistanceRequestSourceLanguageEnumTypeTransformer._();

  const TextAssistanceRequestSourceLanguageEnumTypeTransformer._();

  String encode(TextAssistanceRequestSourceLanguageEnum data) => data._value;

  /// Returns the instance of [TextAssistanceRequestSourceLanguageEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TextAssistanceRequestSourceLanguageEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is TextAssistanceRequestSourceLanguageEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'en':
          return TextAssistanceRequestSourceLanguageEnum.en;
        case r'el':
          return TextAssistanceRequestSourceLanguageEnum.el;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static TextAssistanceRequestSourceLanguageEnumTypeTransformer? _instance;
}

enum TextAssistanceRequestTargetLanguageEnum {
  ru._(r'ru'),
  ;

  /// Instantiate a new enum with the provided value.
  const TextAssistanceRequestTargetLanguageEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [TextAssistanceRequestTargetLanguageEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static TextAssistanceRequestTargetLanguageEnum? fromJson(dynamic value) =>
      TextAssistanceRequestTargetLanguageEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [TextAssistanceRequestTargetLanguageEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<TextAssistanceRequestTargetLanguageEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TextAssistanceRequestTargetLanguageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TextAssistanceRequestTargetLanguageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TextAssistanceRequestTargetLanguageEnum] to String,
/// and [decode] dynamic data back to [TextAssistanceRequestTargetLanguageEnum].
class TextAssistanceRequestTargetLanguageEnumTypeTransformer {
  factory TextAssistanceRequestTargetLanguageEnumTypeTransformer() =>
      _instance ??=
          const TextAssistanceRequestTargetLanguageEnumTypeTransformer._();

  const TextAssistanceRequestTargetLanguageEnumTypeTransformer._();

  String encode(TextAssistanceRequestTargetLanguageEnum data) => data._value;

  /// Returns the instance of [TextAssistanceRequestTargetLanguageEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TextAssistanceRequestTargetLanguageEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is TextAssistanceRequestTargetLanguageEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'ru':
          return TextAssistanceRequestTargetLanguageEnum.ru;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static TextAssistanceRequestTargetLanguageEnumTypeTransformer? _instance;
}

enum TextAssistanceRequestInterfaceLanguageEnum {
  ru._(r'ru'),
  en._(r'en'),
  ;

  /// Instantiate a new enum with the provided value.
  const TextAssistanceRequestInterfaceLanguageEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [TextAssistanceRequestInterfaceLanguageEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static TextAssistanceRequestInterfaceLanguageEnum? fromJson(dynamic value) =>
      TextAssistanceRequestInterfaceLanguageEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [TextAssistanceRequestInterfaceLanguageEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<TextAssistanceRequestInterfaceLanguageEnum> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TextAssistanceRequestInterfaceLanguageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TextAssistanceRequestInterfaceLanguageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TextAssistanceRequestInterfaceLanguageEnum] to String,
/// and [decode] dynamic data back to [TextAssistanceRequestInterfaceLanguageEnum].
class TextAssistanceRequestInterfaceLanguageEnumTypeTransformer {
  factory TextAssistanceRequestInterfaceLanguageEnumTypeTransformer() =>
      _instance ??=
          const TextAssistanceRequestInterfaceLanguageEnumTypeTransformer._();

  const TextAssistanceRequestInterfaceLanguageEnumTypeTransformer._();

  String encode(TextAssistanceRequestInterfaceLanguageEnum data) => data._value;

  /// Returns the instance of [TextAssistanceRequestInterfaceLanguageEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TextAssistanceRequestInterfaceLanguageEnum? decode(dynamic data,
      {bool allowNull = true}) {
    if (data is TextAssistanceRequestInterfaceLanguageEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'ru':
          return TextAssistanceRequestInterfaceLanguageEnum.ru;
        case r'en':
          return TextAssistanceRequestInterfaceLanguageEnum.en;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static TextAssistanceRequestInterfaceLanguageEnumTypeTransformer? _instance;
}
