import 'package:get_it/get_it.dart';
import 'package:sheshield/features/sos/data/datasources/sos_api_datasource.dart';
import 'package:sheshield/features/sos/data/repositories/sos_repository_impl.dart';
import 'package:sheshield/features/sos/domain/repositories/sos_repository.dart';
import 'package:sheshield/features/sos/domain/usecases/get_alert_history_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/get_danger_zones_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/resolve_sos_alert_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/send_sos_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/trigger_duress_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/update_sos_location_usecase.dart';

void registerSosDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => SosApiDataSource(locator()))
    ..registerLazySingleton<SosRepository>(() => SosRepositoryImpl(locator()))
    ..registerLazySingleton(() => SendSosUseCase(locator()))
    ..registerLazySingleton(() => UpdateSosLocationUseCase(locator()))
    ..registerLazySingleton(() => ResolveSosAlertUseCase(locator()))
    ..registerLazySingleton(() => GetAlertHistoryUseCase(locator()))
    ..registerLazySingleton(() => GetDangerZonesUseCase(locator()))
    ..registerLazySingleton(() => TriggerDuressUseCase(locator()));
}
