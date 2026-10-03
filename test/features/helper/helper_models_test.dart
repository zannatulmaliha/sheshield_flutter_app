import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/features/helper/data/models/helper_history_item_model.dart';
import 'package:sheshield/features/helper/data/models/helper_status_model.dart';
import 'package:sheshield/features/helper/data/models/live_state_model.dart';
import 'package:sheshield/features/helper/data/models/my_response_model.dart';
import 'package:sheshield/features/helper/data/models/nearby_alert_model.dart';
import 'package:sheshield/features/helper/domain/entities/live_alert_status.dart';
import 'package:sheshield/features/helper/domain/entities/response_outcome.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/domain/entities/risk_level.dart';

void main() {
  group('NearbyAlertModel', () {
    final json = {
      'id': 'a1',
      'distanceMeters': 850,
      'createdAt': '2026-10-01T08:00:00Z',
    };

    test('fills the documented defaults and never carries identity', () {
      final alert = NearbyAlertModel.fromJson(json).toEntity();
      expect(alert.roughArea, 'Nearby');
      expect(alert.label, 'SOS button pressed');
      expect(alert.riskLevel, RiskLevel.high);
      expect(alert.isHighRisk, isTrue);
    });

    test('formats distance and estimates ETA', () {
      expect(NearbyAlertModel.fromJson(json).toEntity().distanceLabel, '850 m away');
      final far = NearbyAlertModel.fromJson({...json, 'distanceMeters': 2500})
          .toEntity();
      expect(far.distanceLabel, '2.5 km away');
      expect(far.etaMinutes, 6); // 2.5 km at 25 km/h = 6 min
    });

    test('unknown risk reads as high, medium stays medium', () {
      expect(RiskLevel.fromWireValue('???'), RiskLevel.high);
      expect(RiskLevel.fromWireValue('medium'), RiskLevel.medium);
    });
  });

  test('MyResponseModel splits the flat payload into alert + progress', () {
    final response = MyResponseModel.fromJson({
      'id': 'a1',
      'userName': 'Amina',
      'phone': '1700000000',
      'countryCode': '+880',
      'latitude': 23.8,
      'longitude': 90.4,
      'acceptedAt': '2026-10-01T08:00:00Z',
      'requesterUid': 'u9',
      'progress': 'arrived',
      'riskLevel': 'medium',
    }).toEntity();

    expect(response.alert.id, 'a1');
    expect(response.alert.fullPhone, '+880 1700000000');
    expect(response.stage, ResponseStage.arrived);
    expect(response.riskLevel, RiskLevel.medium);
    expect(response.label, 'SOS');
  });

  group('LiveStateModel', () {
    test('open vs ended by the requester', () {
      final open = LiveStateModel.fromJson(const {}).toEntity();
      expect(open.status, LiveAlertStatus.accepted);
      expect(open.isOpen, isTrue);

      final resolved = LiveStateModel.fromJson({'status': 'resolved'}).toEntity();
      expect(resolved.isOpen, isFalse);
      expect(resolved.endedByRequester, isTrue);
    });

    test('lock lost (status active) is neither open nor resolved', () {
      final lost = LiveStateModel.fromJson({'status': 'active'}).toEntity();
      expect(lost.isOpen, isFalse);
      expect(lost.endedByRequester, isFalse);
    });
  });

  test('ResponseStage orders stages and parses wire values', () {
    expect(ResponseStage.arrived.hasReached(ResponseStage.enRoute), isTrue);
    expect(ResponseStage.enRoute.hasReached(ResponseStage.arrived), isFalse);
    expect(ResponseStage.fromWireValue('en_route'), ResponseStage.enRoute);
    expect(ResponseStage.fromWireValue('nonsense'), ResponseStage.none);
  });

  test('history outcome parses and defaults to active', () {
    final item = HelperHistoryItemModel.fromJson({
      'id': 'h1',
      'alertId': 'a1',
      'acceptedAt': '2026-10-01T08:00:00Z',
      'outcome': 'released',
    }).toEntity();
    expect(item.outcome, ResponseOutcome.released);
    expect(item.label, 'SOS');
    expect(ResponseOutcome.fromWireValue(null), ResponseOutcome.active);
  });

  test('HelperStatusModel survives the cache round-trip', () {
    const model = HelperStatusModel(isActive: true, radiusKm: 5, mutualConnectionOptIn: true);
    expect(HelperStatusModel.fromJson(model.toJson()), model);
  });
}
