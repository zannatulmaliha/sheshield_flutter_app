import 'package:freezed_annotation/freezed_annotation.dart';

/// Converts between the Go backend's RFC3339 timestamp strings (Go's
/// default time.Time JSON encoding) and Dart's [DateTime], so entities
/// never hand-parse date fields individually.
class DateTimeConverter implements JsonConverter<DateTime, Object?> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Object? json) {
    if (json is String) return DateTime.parse(json);
    return DateTime.now();
  }

  @override
  Object toJson(DateTime date) => date.toIso8601String();
}
