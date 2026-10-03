import 'package:sheshield/core/theme/app_theme_mode.dart';
import 'package:sheshield/features/settings/domain/repositories/theme_mode_repository.dart';

class GetSavedThemeModeUseCase {
  const GetSavedThemeModeUseCase(this._themeModeRepository);

  final ThemeModeRepository _themeModeRepository;

  Future<AppThemeMode> call() => _themeModeRepository.getSavedThemeMode();
}
