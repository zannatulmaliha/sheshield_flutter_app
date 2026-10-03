import 'package:get_it/get_it.dart';
import 'package:sheshield/features/admin/data/datasources/admin_api_client.dart';
import 'package:sheshield/features/admin/data/datasources/admin_key_store.dart';
import 'package:sheshield/features/admin/data/datasources/admin_report_api_datasource.dart';
import 'package:sheshield/features/admin/data/datasources/admin_verification_api_datasource.dart';
import 'package:sheshield/features/admin/data/repositories/admin_repository_impl.dart';
import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';
import 'package:sheshield/features/admin/domain/usecases/clear_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/decide_verification_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_detail_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_queue_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_verification_detail_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_verification_image_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_verification_queue_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/has_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/review_report_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/save_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/suspend_helper_usecase.dart';

/// Admin authenticates with its own operator key (see [AdminApiClient]),
/// not the user JWT, so it has its own key store and HTTP client.
void registerAdminDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => AdminKeyStore(locator()))
    ..registerLazySingleton(() => AdminApiClient(locator(), locator()))
    ..registerLazySingleton(() => AdminReportApiDataSource(locator()))
    ..registerLazySingleton(() => AdminVerificationApiDataSource(locator()))
    ..registerLazySingleton<AdminRepository>(
      () => AdminRepositoryImpl(
        keyStore: locator(),
        reportDataSource: locator(),
        verificationDataSource: locator(),
        cache: locator(),
      ),
    )
    ..registerLazySingleton(() => HasAdminKeyUseCase(locator()))
    ..registerLazySingleton(() => SaveAdminKeyUseCase(locator()))
    ..registerLazySingleton(() => ClearAdminKeyUseCase(locator()))
    ..registerLazySingleton(() => GetReportQueueUseCase(locator()))
    ..registerLazySingleton(() => GetReportDetailUseCase(locator()))
    ..registerLazySingleton(() => ReviewReportUseCase(locator()))
    ..registerLazySingleton(() => SuspendHelperUseCase(locator()))
    ..registerLazySingleton(() => GetVerificationQueueUseCase(locator()))
    ..registerLazySingleton(() => GetVerificationDetailUseCase(locator()))
    ..registerLazySingleton(() => GetVerificationImageUseCase(locator()))
    ..registerLazySingleton(() => DecideVerificationUseCase(locator()));
}
