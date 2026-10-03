import 'package:sheshield/core/l10n/app_language.dart';
import 'package:sheshield/features/settings/domain/repositories/locale_repository.dart';

class GetSavedLanguageUseCase {
  const GetSavedLanguageUseCase(this._localeRepository);

  final LocaleRepository _localeRepository;

  Future<AppLanguage?> call() => _localeRepository.getSavedLanguage();
}
