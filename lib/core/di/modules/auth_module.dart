import 'package:get_it/get_it.dart';
import 'package:sheshield/features/auth/data/datasources/auth_api_datasource.dart';
import 'package:sheshield/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';
import 'package:sheshield/features/auth/domain/usecases/refresh_session_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/set_discoverable_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_fcm_token_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/watch_auth_state_usecase.dart';

void registerAuthDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => AuthApiDataSource(locator()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(locator()))
    ..registerLazySingleton(() => SignInUseCase(locator()))
    ..registerLazySingleton(() => SignUpUseCase(locator()))
    ..registerLazySingleton(() => SignOutUseCase(locator()))
    ..registerLazySingleton(() => WatchAuthStateUseCase(locator()))
    ..registerLazySingleton(() => UpdateProfileUseCase(locator()))
    ..registerLazySingleton(() => RefreshSessionUseCase(locator()))
    ..registerLazySingleton(() => UpdateFcmTokenUseCase(locator()))
    ..registerLazySingleton(() => SetDiscoverableUseCase(locator()));
}
