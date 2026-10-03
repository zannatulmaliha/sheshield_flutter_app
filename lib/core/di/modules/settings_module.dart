import 'package:get_it/get_it.dart';
import 'package:sheshield/features/settings/data/repositories/locale_repository_impl.dart';
import 'package:sheshield/features/settings/data/repositories/theme_mode_repository_impl.dart';
import 'package:sheshield/features/settings/domain/repositories/locale_repository.dart';
import 'package:sheshield/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:sheshield/features/settings/domain/usecases/clear_saved_language_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/get_saved_language_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/get_saved_theme_mode_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/save_language_usecase.dart';
import 'package:sheshield/features/settings/domain/usecases/save_theme_mode_usecase.dart';

void registerSettingsDependencies(GetIt locator) {
  locator
    ..registerLazySingleton<LocaleRepository>(() => LocaleRepositoryImpl(locator()))
    ..registerLazySingleton<ThemeModeRepository>(() => ThemeModeRepositoryImpl(locator()))
    ..registerLazySingleton(() => GetSavedLanguageUseCase(locator()))
    ..registerLazySingleton(() => SaveLanguageUseCase(locator()))
    ..registerLazySingleton(() => ClearSavedLanguageUseCase(locator()))
    ..registerLazySingleton(() => GetSavedThemeModeUseCase(locator()))
    ..registerLazySingleton(() => SaveThemeModeUseCase(locator()));
}
