import '../entities/admin_report.dart';
import '../entities/admin_report_detail.dart';
import '../entities/admin_verification.dart';

/// Wire values match the backend's report.ReviewRequest.Status.
enum ReviewDecision {
  dismissed('dismissed'),
  actioned('actioned');

  const ReviewDecision(this.key);
  final String key;
}

/// Contract for the moderation dashboard. Authenticated by a separate
/// operator key (X-Admin-Key), never the app's user JWT.
abstract class IAdminRepository {
  Future<bool> hasAdminKey();
  Future<void> setAdminKey(String key);
  Future<void> clearAdminKey();

  Future<List<AdminReport>> getQueue({bool forceRefresh = false});
  Future<AdminReportDetail> getDetail(String reportId);

  Future<void> review({
    required String reportId,
    required ReviewDecision decision,
    required String resolution,
    bool markFalseSos = false,
    String? reviewerName,
  });

  /// Spec §6 fast-track. Returns the released SOS id, if the helper held one.
  Future<List<AdminVerification>> getVerificationQueue(
      {bool forceRefresh = false});
  Future<AdminVerification> getVerificationDetail(String verificationId);
  Future<List<int>> getVerificationImage(
      {required String verificationId, required String kind});
  Future<void> decideVerification(
      {required String verificationId,
      required bool approved,
      String note = '',
      String? reviewerName});

  Future<String?> suspendHelper({
    required String uid,
    required String reason,
    String? reviewerName,
  });
}

class AdminFailure implements Exception {
  const AdminFailure(this.message, {this.unauthorized = false});
  final String message;

  /// True when the server rejected the admin key (401).
  final bool unauthorized;

  @override
  String toString() => message;
}
