import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/theme/app_theme_mode.dart';
import 'package:sheshield/features/settings/domain/usecases/get_saved_theme_mode_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/save_theme_mode_usecase.dart';
import 'package:sheshield/features/settings/presentation/providers/settings_use_case_providers.dart';

part 'theme_mode_provider.g.dart';

/// Drives `resolvePalette` (core/theme/app_palette.dart) and, through it,
/// every User-mode screen's colors.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  late final GetSavedThemeModeUseCase _getSavedThemeMode =
      ref.read(getSavedThemeModeUseCaseProvider);
  late final SaveThemeModeUseCase _saveThemeMode =
      ref.read(saveThemeModeUseCaseProvider);

  @override
  Future<AppThemeMode> build() => _getSavedThemeMode();

  Future<void> setMode(AppThemeMode mode) async {
    state = AsyncData(mode);
    await _saveThemeMode(mode);
  }
}
