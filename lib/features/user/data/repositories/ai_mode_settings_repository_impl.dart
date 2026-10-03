import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sheshield/features/user/data/models/ai_mode_settings_model.dart';
import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';
import 'package:sheshield/features/user/domain/repositories/ai_mode_settings_repository.dart';

/// Stores the settings as one JSON blob under [_settingsKey]. Falls back to
/// reading the pre-refactor per-flag keys once, so toggles survive this
/// refactor for existing installs, then writes the migrated value back as
/// JSON so the legacy keys are never read again.
class AiModeSettingsRepositoryImpl implements AiModeSettingsRepository {
  const AiModeSettingsRepositoryImpl(this._secureStorage);

  static const _settingsKey = 'sheshield_ai_mode_settings';

  static const _legacyVoiceKey = 'sheshield_ai_voice_distress_enabled';
  static const _legacyFakeCallKey = 'sheshield_ai_fake_call_enabled';
  static const _legacyRouteRiskKey = 'sheshield_ai_route_risk_enabled';
  static const _legacyAutoCheckInKey = 'sheshield_ai_auto_checkin_enabled';

  final FlutterSecureStorage _secureStorage;

  @override
  Future<AiModeSettings> getSettings() async {
    final raw = await _secureStorage.read(key: _settingsKey);
    if (raw != null) {
      return AiModeSettingsModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      ).toEntity();
    }

    final migrated = await _readLegacyFlags();
    await saveSettings(migrated);
    return migrated;
  }

  @override
  Future<void> saveSettings(AiModeSettings settings) async {
    final json = jsonEncode(AiModeSettingsModel.fromEntity(settings).toJson());
    await _secureStorage.write(key: _settingsKey, value: json);
  }

  Future<AiModeSettings> _readLegacyFlags() async {
    const defaults = AiModeSettings();
    return AiModeSettings(
      voiceEnabled: await _readLegacyFlag(_legacyVoiceKey, defaults.voiceEnabled),
      fakeCallEnabled:
          await _readLegacyFlag(_legacyFakeCallKey, defaults.fakeCallEnabled),
      routeRiskEnabled:
          await _readLegacyFlag(_legacyRouteRiskKey, defaults.routeRiskEnabled),
      autoCheckInEnabled: await _readLegacyFlag(
        _legacyAutoCheckInKey,
        defaults.autoCheckInEnabled,
      ),
    );
  }

  Future<bool> _readLegacyFlag(String key, bool fallback) async {
    final raw = await _secureStorage.read(key: key);
    return raw == null ? fallback : raw == 'true';
  }
}
