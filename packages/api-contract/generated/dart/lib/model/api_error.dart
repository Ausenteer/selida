//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiError {
  /// Returns a new [ApiError] instance.
  ApiError({
    this.error,
    required this.message,
    this.statusCode,
    this.code,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  final String? error;

  final String message;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  final int? statusCode;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  final String? code;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiError &&
          other.error == error &&
          other.message == message &&
          other.statusCode == statusCode &&
          other.code == code;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (error == null ? 0 : error!.hashCode) +
      (message.hashCode) +
      (statusCode == null ? 0 : statusCode!.hashCode) +
      (code == null ? 0 : code!.hashCode);

  @override
  String toString() =>
      'ApiError[error=$error, message=$message, statusCode=$statusCode, code=$code]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.error != null) {
      json[r'error'] = this.error;
    } else {
      json[r'error'] = null;
    }
    json[r'message'] = this.message;
    if (this.statusCode != null) {
      json[r'statusCode'] = this.statusCode;
    } else {
      json[r'statusCode'] = null;
    }
    if (this.code != null) {
      json[r'code'] = this.code;
    } else {
      json[r'code'] = null;
    }
    return json;
  }

  /// Clones this instance of [ApiError] and returns a new one where some of the
  /// properties have changed.
  ApiError copyWith({
    String? error,
    String? message,
    int? statusCode,
    String? code,
  }) =>
      ApiError(
        error: error ?? this.error,
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        code: code ?? this.code,
      );

  /// Returns a new [ApiError] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiError? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'message'),
            'Required key "ApiError[message]" is missing from JSON.');
        assert(json[r'message'] != null,
            'Required key "ApiError[message]" has a null value in JSON.');
        return true;
      }());

      return ApiError(
        error: mapValueOfType<String>(json, r'error'),
        message: mapValueOfType<String>(json, r'message')!,
        statusCode: mapValueOfType<int>(json, r'statusCode'),
        code: mapValueOfType<String>(json, r'code'),
      );
    }
    return null;
  }

  static List<ApiError> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ApiError>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiError.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiError> mapFromJson(dynamic json) {
    final map = <String, ApiError>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiError.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiError-objects as value to a dart map
  static Map<String, List<ApiError>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ApiError>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiError.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'message',
  };
}
