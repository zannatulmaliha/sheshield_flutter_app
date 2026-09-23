import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sheshield/core/theme/app_theme_mode.dart';
import 'package:sheshield/features/settings/domain/repositories/i_theme_mode_repository.dart';

/// Persists the chosen [AppThemeMode] to secure storage -- same
/// [FlutterSecureStorage] singleton [LocaleRepositoryImpl] already uses,
/// rather than pulling in shared_preferences for one more string.
class ThemeModeRepositoryImpl implements IThemeModeRepository {
  ThemeModeRepositoryImpl(this._storage);

  static const _themeModeKey = 'sheshield_theme_mode';

  final FlutterSecureStorage _storage;

  @override
  Future<AppThemeMode> getSavedThemeMode() async {
    final key = await _storage.read(key: _themeModeKey);
    return AppThemeMode.fromKey(key);
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) {
    return _storage.write(key: _themeModeKey, value: mode.key);
  }
}
