import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sheshield/core/cache/cache_box_interface.dart';
import 'package:sheshield/core/config/app_config.dart';
import 'package:sheshield/core/di/native_dependencies.dart'
    if (dart.library.html) 'package:sheshield/core/di/web_dependencies.dart';
import 'package:sheshield/core/network/auth_token_store.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/core/services/device_alarm_service.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/core/services/evidence_service.dart';
import 'package:sheshield/core/services/push_service.dart';
import 'package:sheshield/core/services/ringtone_service.dart';
import 'package:sheshield/core/services/voice_distress_service.dart';

Future<void> registerCoreDependencies(GetIt locator, AppConfig config) async {
  locator
    ..registerSingleton<AppConfig>(config)
    ..registerLazySingleton(() => const FlutterSecureStorage())
    ..registerLazySingleton(() => AuthTokenStore(locator()))
    ..registerLazySingleton(
      () => DioClient(
        baseUrl: config.apiBaseUrl,
        tokenStore: locator(),
        enableLogging: config.enableNetworkLogging,
      ),
    )
    ..registerLazySingleton(DeviceLocationService.new)
    ..registerLazySingleton(DeviceSmsService.new)
    ..registerLazySingleton(DeviceAlarmService.new)
    ..registerLazySingleton(EvidenceService.new)
    ..registerLazySingleton(() => PushService(locator()))
    ..registerLazySingleton(RingtoneService.new)
    ..registerLazySingleton(VoiceDistressService.new);

  locator.registerSingleton<CacheBox>(await createCacheBox());
}
