import 'package:freezed_annotation/freezed_annotation.dart';

part 'helper_status.freezed.dart';
part 'helper_status.g.dart';

/// Whether this account is currently accepting alerts, and how far it
/// will look for them.
@freezed
class HelperStatus with _$HelperStatus {
  const factory HelperStatus({
    @Default(false) bool isActive,
    @Default(3.0) double radiusKm,
  }) = _HelperStatus;

  factory HelperStatus.fromJson(Map<String, dynamic> json) =>
      _$HelperStatusFromJson(json);
}
