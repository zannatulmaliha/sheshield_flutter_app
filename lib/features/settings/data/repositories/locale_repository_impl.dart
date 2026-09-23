import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sheshield/core/l10n/app_language.dart';
import 'package:sheshield/features/settings/domain/repositories/i_locale_repository.dart';

/// Persists the user's chosen [AppLanguage] to secure storage. Reuses
/// the same [FlutterSecureStorage] singleton the JWT session already
/// lives in (see `DioClient`) rather than pulling in a second storage
/// dependency (shared_preferences) just for one string.
class LocaleRepositoryImpl implements ILocaleRepository {
  LocaleRepositoryImpl(this._storage);

  static const _languageCodeKey = 'sheshield_language_code';

  final FlutterSecureStorage _storage;

  @override
  Future<AppLanguage?> getSavedLanguage() async {
    final code = await _storage.read(key: _languageCodeKey);
    return AppLanguage.fromLanguageCode(code);
  }

  @override
  Future<void> saveLanguage(AppLanguage language) {
    return _storage.write(key: _languageCodeKey, value: language.languageCode);
  }

  @override
  Future<void> clearSavedLanguage() {
    return _storage.delete(key: _languageCodeKey);
  }
}