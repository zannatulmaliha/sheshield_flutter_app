import 'package:sheshield/core/l10n/app_language.dart';

/// Persists the user's language choice across app restarts. `null`
/// means "no explicit choice yet" -- the app then follows the device's
/// system locale (falling back to English) until the user picks one.
abstract class ILocaleRepository {
  Future<AppLanguage?> getSavedLanguage();

  Future<void> saveLanguage(AppLanguage language);

  Future<void> clearSavedLanguage();
}