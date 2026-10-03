import 'package:get_it/get_it.dart';
import 'package:sheshield/core/services/motion/motion_api.dart';
import 'package:sheshield/core/services/motion/motion_settings.dart';
import 'package:sheshield/features/helper/data/datasources/helper_activity_api_datasource.dart';
import 'package:sheshield/features/helper/data/datasources/helper_alert_api_datasource.dart';
import 'package:sheshield/features/helper/data/datasources/helper_status_api_datasource.dart';
import 'package:sheshield/features/helper/data/repositories/helper_activity_repository_impl.dart';
import 'package:sheshield/features/helper/data/repositories/helper_alert_repository_impl.dart';
import 'package:sheshield/features/helper/data/repositories/helper_status_repository_impl.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_activity_repository.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_status_repository.dart';
import 'package:sheshield/features/helper/domain/usecases/accept_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_current_response_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_history_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_stats_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_live_state_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_nearby_alerts_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_safety_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/release_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/resolve_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_response_stage_usecase.dart';

/// Helper mode, plus the movement-detection API it shares a backend
/// surface with.
void registerHelperDependencies(GetIt locator) {
  locator
    ..registerLazySingleton(() => MotionSettingsStore(locator()))
    ..registerLazySingleton(() => MotionApi(locator()))
    ..registerLazySingleton(() => HelperStatusApiDataSource(locator()))
    ..registerLazySingleton(() => HelperAlertApiDataSource(locator()))
    ..registerLazySingleton(() => HelperActivityApiDataSource(locator()))
    ..registerLazySingleton<HelperStatusRepository>(
      () => HelperStatusRepositoryImpl(locator(), locator()),
    )
    ..registerLazySingleton<HelperAlertRepository>(
      () => HelperAlertRepositoryImpl(locator()),
    )
    ..registerLazySingleton<HelperActivityRepository>(
      () => HelperActivityRepositoryImpl(locator()),
    )
    ..registerLazySingleton(() => GetHelperStatusUseCase(locator()))
    ..registerLazySingleton(() => SetHelperStatusUseCase(locator()))
    ..registerLazySingleton(() => GetNearbyAlertsUseCase(locator()))
    ..registerLazySingleton(() => AcceptAlertUseCase(locator()))
    ..registerLazySingleton(() => ReleaseAlertUseCase(locator()))
    ..registerLazySingleton(() => GetSafetyStatusUseCase(locator()))
    ..registerLazySingleton(() => GetCurrentResponseUseCase(locator()))
    ..registerLazySingleton(() => GetLiveStateUseCase(locator()))
    ..registerLazySingleton(() => SetResponseStageUseCase(locator()))
    ..registerLazySingleton(() => ResolveAlertUseCase(locator()))
    ..registerLazySingleton(() => GetHelperStatsUseCase(locator()))
    ..registerLazySingleton(() => GetHelperHistoryUseCase(locator()));
}
