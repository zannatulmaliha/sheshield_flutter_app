import 'package:get_it/get_it.dart';
import 'package:sheshield/features/user/data/repositories/ai_mode_settings_repository_impl.dart';
import 'package:sheshield/features/user/domain/repositories/ai_mode_settings_repository.dart';
import 'package:sheshield/features/user/domain/usecases/get_ai_mode_settings_usecase.dart';
import 'package:sheshield/features/user/domain/usecases/save_ai_mode_settings_usecase.dart';

void registerUserDependencies(GetIt locator) {
  locator
    ..registerLazySingleton<AiModeSettingsRepository>(
      () => AiModeSettingsRepositoryImpl(locator()),
    )
    ..registerLazySingleton(() => GetAiModeSettingsUseCase(locator()))
    ..registerLazySingleton(() => SaveAiModeSettingsUseCase(locator()));
}
