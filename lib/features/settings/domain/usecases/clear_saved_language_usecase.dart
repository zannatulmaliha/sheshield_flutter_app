import 'package:sheshield/features/settings/domain/repositories/locale_repository.dart';

class ClearSavedLanguageUseCase {
  const ClearSavedLanguageUseCase(this._localeRepository);

  final LocaleRepository _localeRepository;

  Future<void> call() => _localeRepository.clearSavedLanguage();
}
