import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:sheshield/core/cache/cache_box_interface.dart';
import 'package:sheshield/core/constants/api_constants.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/core/services/device_alarm_service.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/core/services/push_service.dart';

// ==================== AUTH ====================
import 'package:sheshield/features/auth/data/datasources/auth_api_datasource.dart';
import 'package:sheshield/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sheshield/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/watch_auth_state_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/refresh_session_usecase.dart';
import 'package:sheshield/features/auth/domain/usecases/update_fcm_token_usecase.dart';

// ==================== HELPER ====================
import 'package:sheshield/features/helper/data/datasources/helper_api_datasource.dart';
import 'package:sheshield/features/helper/data/repositories/helper_repository_impl.dart';
import 'package:sheshield/features/helper/domain/repositories/i_helper_repository.dart';
import 'package:sheshield/features/helper/domain/usecases/accept_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_nearby_alerts_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_helper_status_usecase.dart';

// ==================== SOS ====================
import 'package:sheshield/features/sos/data/datasources/sos_api_datasource.dart';
import 'package:sheshield/features/sos/data/repositories/sos_repository_impl.dart';
import 'package:sheshield/features/sos/domain/repositories/i_sos_repository.dart';
import 'package:sheshield/features/sos/domain/usecases/send_sos_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/update_sos_location_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/resolve_sos_alert_usecase.dart';

// ==================== CONTACTS ====================
import 'package:sheshield/features/contacts/data/datasources/contacts_api_datasource.dart';
import 'package:sheshield/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:sheshield/features/contacts/domain/repositories/i_contacts_repository.dart';
import 'package:sheshield/features/contacts/domain/usecases/accept_contact_invite_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/invite_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/remove_contact_usecase.dart';

// ==================== VERIFICATION ====================
import 'package:sheshield/features/verification/data/datasources/verification_api_datasource.dart';
import 'package:sheshield/features/verification/data/repositories/verification_repository_impl.dart';
import 'package:sheshield/features/verification/domain/repositories/i_verification_repository.dart';
import 'package:sheshield/features/verification/domain/usecases/get_verification_status_usecase.dart';
import 'package:sheshield/features/verification/domain/usecases/submit_verification_usecase.dart';

import 'native_dependencies.dart'
    if (dart.library.html) 'web_dependencies.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // ==================== CORE ====================

  getIt.registerLazySingleton(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton(
    () => DioClient(
      ApiConstants.baseUrl,
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => DeviceLocationService(),
  );

  getIt.registerLazySingleton(
    () => DeviceSmsService(),
  );

  getIt.registerLazySingleton(
    () => DeviceAlarmService(),
  );

  getIt.registerLazySingleton(
    () => PushService(),
  );

  final cacheBox = await createCacheBox();

  getIt.registerSingleton<CacheBox>(cacheBox);

  // ==================== AUTH FEATURE ====================

  getIt.registerLazySingleton(
    () => AuthApiDataSource(getIt()),
  );

  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => SignInUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => SignUpUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => SignOutUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => WatchAuthStateUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => UpdateProfileUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => RefreshSessionUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => UpdateFcmTokenUseCase(getIt()),
  );

  // ==================== HELPER FEATURE ====================

  getIt.registerLazySingleton(
    () => HelperApiDataSource(getIt()),
  );

  getIt.registerLazySingleton<IHelperRepository>(
    () => HelperRepositoryImpl(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetHelperStatusUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => SetHelperStatusUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetNearbyAlertsUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => AcceptAlertUseCase(getIt()),
  );

  // ==================== SOS FEATURE ====================

  getIt.registerLazySingleton(
    () => SosApiDataSource(getIt()),
  );

  getIt.registerLazySingleton<ISosRepository>(
    () => SosRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => SendSosUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => UpdateSosLocationUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => ResolveSosAlertUseCase(getIt()),
  );

  // ==================== CONTACTS FEATURE ====================

  getIt.registerLazySingleton(
    () => ContactsApiDataSource(getIt()),
  );

  getIt.registerLazySingleton<IContactsRepository>(
    () => ContactsRepositoryImpl(
      getIt(),
      getIt(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetContactsUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => AddContactUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => RemoveContactUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => InviteContactUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => AcceptContactInviteUseCase(getIt()),
  );

  // ==================== VERIFICATION FEATURE ====================

  getIt.registerLazySingleton(
    () => VerificationApiDataSource(getIt()),
  );

  getIt.registerLazySingleton<IVerificationRepository>(
    () => VerificationRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetVerificationStatusUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => SubmitVerificationUseCase(getIt()),
  );
}