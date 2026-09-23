import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/theme/app_theme_mode.dart';
import 'package:sheshield/features/settings/domain/repositories/i_theme_mode_repository.dart';

part 'theme_mode_provider.g.dart';

/// Drives [resolvePalette] (core/theme/app_palette.dart) and, through it,
/// every User-mode screen's colors.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  Future<AppThemeMode> build() {
    return getIt<IThemeModeRepository>().getSavedThemeMode();
  }

  Future<void> setMode(AppThemeMode mode) async {
    state = AsyncData(mode);
    await getIt<IThemeModeRepository>().saveThemeMode(mode);
  }
}
