import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/l10n/app_language.dart';
import 'package:sheshield/features/settings/domain/usecases/clear_saved_language_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/get_saved_language_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:sheshield/features/settings/presentation/providers/settings_use_case_providers.dart';

part 'locale_provider.g.dart';

/// Drives `MaterialApp.router`'s `locale:`. A `null` state means "no saved
/// preference": Flutter then resolves the best match from the device's
/// locales against `supportedLocales` itself, so that fallback logic is
/// never duplicated here.
@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  late final GetSavedLanguageUseCase _getSavedLanguage =
      ref.read(getSavedLanguageUseCaseProvider);
  late final SaveLanguageUseCase _saveLanguage = ref.read(saveLanguageUseCaseProvider);
  late final ClearSavedLanguageUseCase _clearSavedLanguage =
      ref.read(clearSavedLanguageUseCaseProvider);

  @override
  Future<AppLanguage?> build() => _getSavedLanguage();

  Future<void> setLanguage(AppLanguage language) async {
    state = AsyncData(language);
    await _saveLanguage(language);
  }

  /// Reverts to following the device's system language.
  Future<void> followSystem() async {
    state = const AsyncData(null);
    await _clearSavedLanguage();
  }
}
