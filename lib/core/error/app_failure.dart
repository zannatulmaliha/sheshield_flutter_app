import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

/// The single error type the data layer throws and the UI displays.
/// Replaces the per-feature `XxxFailure` copies that each re-implemented
/// the same message mapping.
@freezed
class AppFailure with _$AppFailure implements Exception {
  const AppFailure._();

  const factory AppFailure({
    required String message,
    @Default(false) bool unauthorized,

    /// HTTP status when the failure came from a server response.
    int? statusCode,
  }) = _AppFailure;

  @override
  String toString() => message;
}
