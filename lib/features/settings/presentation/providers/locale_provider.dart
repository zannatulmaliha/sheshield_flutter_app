import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/l10n/app_language.dart';
import 'package:sheshield/features/settings/domain/repositories/i_locale_repository.dart';

part 'locale_provider.g.dart';

/// Drives `MaterialApp.router`'s `locale:` parameter. `null` state
/// means "no saved preference" -- Flutter then resolves the best
/// match from the device's system locales against `supportedLocales`
/// on its own, so we never have to duplicate that fallback logic here.
@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  @override
  Future<AppLanguage?> build() {
    return getIt<ILocaleRepository>().getSavedLanguage();
  }

  Future<void> setLanguage(AppLanguage language) async {
    state = AsyncData(language);
    await getIt<ILocaleRepository>().saveLanguage(language);
  }

  /// Reverts to following the device's system language.
  Future<void> followSystem() async {
    state = const AsyncData(null);
    await getIt<ILocaleRepository>().clearSavedLanguage();
  }
}