import 'package:sheshield/core/theme/app_theme_mode.dart';

/// Persists the user's chosen [AppThemeMode] across app restarts.
abstract class IThemeModeRepository {
  Future<AppThemeMode> getSavedThemeMode();

  Future<void> saveThemeMode(AppThemeMode mode);
}
