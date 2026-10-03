import 'package:sheshield/features/report/domain/entities/blocked_user.dart';
import 'package:sheshield/features/report/domain/entities/report_category.dart';

/// Filing reports and managing blocks. Both directions
/// (user-reports-helper, helper-reports-user) use [fileReport]; the server
/// tracks the reporter's role. Failures surface as `AppFailure`.
abstract interface class ReportRepository {
  /// [reporterRole] is `user` or `helper` -- the side the caller is acting
  /// as. [sosId] ties the report to a specific SOS when relevant.
  Future<void> fileReport({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  });

  /// One-tap, reversible, no explanation required (spec §5).
  Future<void> blockUser(String userId);

  Future<void> unblockUser(String userId);

  Future<List<BlockedUser>> fetchBlockedUsers();
}
