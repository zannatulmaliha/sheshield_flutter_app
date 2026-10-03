import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_verification.freezed.dart';

/// A helper's identity-verification submission awaiting (or past) review.
@freezed
class AdminVerification with _$AdminVerification {
  const AdminVerification._();

  const factory AdminVerification({
    required String id,
    required String userUid,
    required String status,
    required String note,
    required DateTime createdAt,
    required String userName,
    required String userEmail,
    required String userPhone,
    required String userType,
    DateTime? reviewedAt,
  }) = _AdminVerification;

  bool get isPending => status == 'pending';

  String get displayName => userName.isEmpty ? userUid : userName;
}
