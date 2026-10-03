import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/verification/domain/entities/verification_state.dart';

export 'package:sheshield/features/verification/domain/entities/verification_state.dart';

part 'verification_status.freezed.dart';

/// A helper's verification outcome. [note] is the reviewer's reason and is
/// only present when [status] is rejected.
@freezed
class VerificationStatus with _$VerificationStatus {
  const factory VerificationStatus({
    required VerificationState status,
    @Default('') String note,
    DateTime? submittedAt,
  }) = _VerificationStatus;
}
