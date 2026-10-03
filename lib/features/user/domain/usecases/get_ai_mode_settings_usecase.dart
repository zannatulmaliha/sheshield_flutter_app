import 'package:sheshield/features/user/domain/entities/ai_mode_settings.dart';
import 'package:sheshield/features/user/domain/repositories/ai_mode_settings_repository.dart';

class GetAiModeSettingsUseCase {
  const GetAiModeSettingsUseCase(this._aiModeSettingsRepository);

  final AiModeSettingsRepository _aiModeSettingsRepository;

  Future<AiModeSettings> call() => _aiModeSettingsRepository.getSettings();
}
