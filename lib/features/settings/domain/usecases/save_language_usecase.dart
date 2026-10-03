import 'package:sheshield/core/l10n/app_language.dart';
import 'package:sheshield/features/settings/domain/repositories/locale_repository.dart';

class SaveLanguageUseCase {
  const SaveLanguageUseCase(this._localeRepository);

  final LocaleRepository _localeRepository;

  Future<void> call(AppLanguage language) => _localeRepository.saveLanguage(language);
}
