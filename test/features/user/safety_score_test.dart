import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';
import 'package:sheshield/features/user/domain/entities/safety_score.dart';
import 'package:sheshield/features/user/domain/entities/time_of_day_risk.dart';

SafetyScore _score(int contacts, int features, {bool verified = false}) =>
    SafetyScore.calculate(
      contactsCount: contacts,
      enabledFeatures: features,
      isVerified: verified,
    );

void main() {
  group('SafetyScore', () {
    test('no signals scores zero', () => expect(_score(0, 0).score, 0));

    test('contacts and features each cap at 40, verification adds 20', () {
      expect(_score(3, 4).score, 80);
      expect(_score(3, 4, verified: true).score, 100);
      expect(_score(9, 9, verified: true).score, 100); // clamped inputs
    });

    test('contacts count towards three only', () {
      expect(_score(1, 0).score, 13);
      expect(_score(2, 0).score, 27);
    });

    test('description reflects contacts and verification', () {
      expect(_score(0, 2).description, contains('you have none yet'));
      expect(_score(1, 4).description, startsWith('1 trusted contact and'));
      expect(_score(2, 4, verified: true).description, endsWith('Identity verified.'));
    });
  });

  test('AiModeSettings counts enabled features', () {
    expect(const AiModeSettings().enabledFeatureCount, 3); // defaults: route risk off
    expect(
      const AiModeSettings(
        voiceEnabled: false,
        fakeCallEnabled: false,
        autoCheckInEnabled: false,
      ).enabledFeatureCount,
      0,
    );
  });

  test('TimeOfDayRisk follows the documented hours', () {
    TimeOfDayRisk at(int hour) => TimeOfDayRisk.at(DateTime(2026, 10, 1, hour));
    expect(at(23), TimeOfDayRisk.high);
    expect(at(3), TimeOfDayRisk.high);
    expect(at(20), TimeOfDayRisk.medium);
    expect(at(6), TimeOfDayRisk.medium);
    expect(at(12), TimeOfDayRisk.low);
  });
}
