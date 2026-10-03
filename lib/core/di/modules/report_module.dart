import 'package:get_it/get_it.dart';
import 'package:sheshield/features/report/data/datasources/report_api_datasource.dart';
import 'package:sheshield/features/report/data/repositories/report_repository_impl.dart';
import 'package:sheshield/features/report/domain/repositories/report_repository.dart';
import 'package:sheshield/features/report/domain/usecases/block_user_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/file_report_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/list_blocked_users_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/unblock_user_usecase.dart';

void registerReportDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => ReportApiDataSource(locator()))
    ..registerLazySingleton<ReportRepository>(() => ReportRepositoryImpl(locator()))
    ..registerLazySingleton(() => FileReportUseCase(locator()))
    ..registerLazySingleton(() => BlockUserUseCase(locator()))
    ..registerLazySingleton(() => UnblockUserUseCase(locator()))
    ..registerLazySingleton(() => ListBlockedUsersUseCase(locator()));
}
