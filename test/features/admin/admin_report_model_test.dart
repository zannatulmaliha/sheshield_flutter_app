import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/features/admin/data/models/admin_report_detail_model.dart';
import 'package:sheshield/features/admin/domain/entities/reporter_role.dart';
import 'package:sheshield/features/admin/domain/entities/review_status.dart';

void main() {
  final reportJson = {
    'id': 'r1',
    'reporterId': 'a',
    'reportedId': 'b',
    'reporterRole': 'system',
    'category': 'false_alarm',
    'reviewStatus': 'reviewing',
    'sosId': '',
    'createdAt': '2026-10-01T08:00:00Z',
  };

  test('maps wire strings to enums and empty optionals to null', () {
    final detail = AdminReportDetailModel.fromJson({
      'report': reportJson,
      'auditTrail': null, // the backend sends null, not [], for an empty trail
    }).toEntity();

    expect(detail.report.reporterRole, ReporterRole.system);
    expect(detail.report.isSystemFlag, isTrue);
    expect(detail.report.reviewStatus, ReviewStatus.reviewing);
    expect(detail.report.isAwaitingDecision, isTrue);
    expect(detail.report.sosId, isNull);
    expect(detail.auditTrail, isEmpty);
  });

  test('an unknown status never hides a report from the queue', () {
    expect(ReviewStatus.fromWireValue('brand_new'), ReviewStatus.pending);
  });
}
