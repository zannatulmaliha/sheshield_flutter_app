import '../entities/blocked_user.dart';
import '../entities/report_category.dart';

/// Contract for filing reports and managing blocks -- both directions
/// (user-reports-helper, helper-reports-user) go through the same File
/// call; the server tracks reporterRole, the app doesn't need two methods.
abstract class IReportRepository {
  /// Files a report against [reportedId]. [reporterRole] is 'user' or
  /// 'helper' -- whichever side the caller is acting as for this report.
  /// [sosId] ties it to a specific SOS when relevant (optional).
  Future<void> file({
    required String reportedId,
    required ReportCategory category,
    required String reporterRole,
    String? sosId,
  });

  /// One-tap, reversible, no explanation required (spec §5).
  Future<void> block(String userId);

  Future<void> unblock(String userId);

  Future<List<BlockedUser>> listBlocks();
}

class ReportFailure implements Exception {
  const ReportFailure(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}
