import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';

/// Persists the AI Guardian toggles across app restarts.
abstract interface class AiModeSettingsRepository {
  Future<AiModeSettings> getSettings();

  Future<void> saveSettings(AiModeSettings settings);
}
