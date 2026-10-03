import 'package:get_it/get_it.dart';
import 'package:sheshield/features/verification/data/datasources/verification_api_datasource.dart';
import 'package:sheshield/features/verification/data/repositories/verification_repository_impl.dart';
import 'package:sheshield/features/verification/domain/repositories/verification_repository.dart';
import 'package:sheshield/features/verification/domain/usecases/get_verification_status_usecase.dart';
import 'package:sheshield/features/verification/domain/usecases/submit_verification_usecase.dart';

void registerVerificationDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => VerificationApiDataSource(locator()))
    ..registerLazySingleton<VerificationRepository>(
      () => VerificationRepositoryImpl(locator()),
    )
    ..registerLazySingleton(() => GetVerificationStatusUseCase(locator()))
    ..registerLazySingleton(() => SubmitVerificationUseCase(locator()));
}
