import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_status.freezed.dart';
part 'verification_status.g.dart';

/// Mirrors the Go backend's four states exactly (internal/verification).
enum VerificationState {
  @JsonValue('none')
  none,
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
}

/// GET /api/v1/verification response. [note] is the reviewer's reason,
/// only ever present when [status] is rejected.
@freezed
class VerificationStatus with _$VerificationStatus {
  const factory VerificationStatus({
    required VerificationState status,
    @Default('') String note,
    DateTime? submittedAt,
  }) = _VerificationStatus;

  factory VerificationStatus.fromJson(Map<String, dynamic> json) =>
      _$VerificationStatusFromJson(json);
}