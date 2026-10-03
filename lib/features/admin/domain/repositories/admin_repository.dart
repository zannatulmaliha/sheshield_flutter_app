import 'dart:typed_data';

import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report_detail.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/domain/entities/review_decision.dart';
import 'package:sheshield/features/admin/domain/entities/verification_image_kind.dart';

/// Contract for the moderation dashboard. It authenticates with a separate
/// operator key (`X-Admin-Key`), never the app's user JWT. Failures surface
/// as `AppFailure`.
abstract interface class AdminRepository {
  Future<bool> hasAdminKey();
  Future<void> saveAdminKey(String key);
  Future<void> clearAdminKey();

  Future<List<AdminReport>> fetchReportQueue({bool forceRefresh = false});
  Future<AdminReportDetail> fetchReportDetail(String reportId);

  Future<void> reviewReport({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    bool markFalseSos = false,
    String? reviewerName,
  });

  /// Spec §6 fast-track. Returns the released SOS id, if the helper held one.
  Future<String?> suspendHelper({
    required String uid,
    required String reason,
    String? reviewerName,
  });

  Future<List<AdminVerification>> fetchVerificationQueue();
  Future<AdminVerification> fetchVerificationDetail(String verificationId);
  Future<Uint8List> fetchVerificationImage({
    required String verificationId,
    required VerificationImageKind kind,
  });
  Future<void> decideVerification({
    required String verificationId,
    required bool approved,
    String note = '',
    String? reviewerName,
  });
}
