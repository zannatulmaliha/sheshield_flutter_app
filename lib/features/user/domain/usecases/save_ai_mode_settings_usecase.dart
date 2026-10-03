import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';
import 'package:sheshield/features/user/domain/repositories/ai_mode_settings_repository.dart';

class SaveAiModeSettingsUseCase {
  const SaveAiModeSettingsUseCase(this._aiModeSettingsRepository);

  final AiModeSettingsRepository _aiModeSettingsRepository;

  Future<void> call(AiModeSettings settings) =>
      _aiModeSettingsRepository.saveSettings(settings);
}
