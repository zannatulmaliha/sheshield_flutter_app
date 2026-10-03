import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/features/sos/data/models/alert_summary_model.dart';
import 'package:sheshield/features/sos/data/models/sos_alert_model.dart';
import 'package:sheshield/features/sos/domain/entities/alert_status.dart';
import 'package:sheshield/features/sos/domain/entities/delivery_status.dart';

void main() {
  test('counts sent and failed deliveries; simulated is neither', () {
    final alert = SosAlertModel.fromJson({
      'id': 'a1',
      'createdAt': '2026-10-01T08:00:00Z',
      'deliveries': [
        {'contactId': '1', 'name': 'A', 'channel': 'device', 'status': 'sent'},
        {'contactId': '2', 'name': 'B', 'channel': 'server', 'status': 'failed'},
        {'contactId': '3', 'name': 'C', 'channel': 'server', 'status': 'simulated'},
      ],
    }).toEntity();

    expect(alert.sentCount, 1);
    expect(alert.failedCount, 1);
    expect(alert.deliveries, hasLength(3));
  });

  test('an unknown delivery status is never reported as sent', () {
    expect(DeliveryStatus.fromWireValue('???'), DeliveryStatus.failed);
  });

  test('a missing deliveries list is treated as empty', () {
    final alert = SosAlertModel.fromJson(
      {'id': 'a1', 'createdAt': '2026-10-01T08:00:00Z'},
    ).toEntity();
    expect(alert.deliveries, isEmpty);
    expect(alert.shareUrl, isNull);
  });

  test('history rows map status and aggregate counts', () {
    final summary = AlertSummaryModel.fromJson({
      'id': 'a1',
      'status': 'accepted',
      'createdAt': '2026-10-01T08:00:00Z',
      'sentCount': 2,
      'totalCount': 3,
    }).toEntity();

    expect(summary.status, AlertStatus.accepted);
    expect(summary.isActive, isFalse);
    expect(summary.failedCount, 0);
    expect(AlertSummaryModel.fromJson({'id': 'x', 'status': 'active', 'createdAt': '2026-10-01T08:00:00Z'}).toEntity().isActive, isTrue);
  });
}
