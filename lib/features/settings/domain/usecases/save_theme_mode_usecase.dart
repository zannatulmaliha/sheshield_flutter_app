import 'package:sheshield/core/theme/app_theme_mode.dart';
import 'package:sheshield/features/settings/domain/repositories/theme_mode_repository.dart';

class SaveThemeModeUseCase {
  const SaveThemeModeUseCase(this._themeModeRepository);

  final ThemeModeRepository _themeModeRepository;

  Future<void> call(AppThemeMode mode) => _themeModeRepository.saveThemeMode(mode);
}
