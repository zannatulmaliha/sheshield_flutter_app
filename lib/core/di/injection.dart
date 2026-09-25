import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:sheshield/core/cache/cache_box_interface.dart';
import 'package:sheshield/core/constants/api_constants.dart';
import 'package:sheshield/core/network/dio_client.dart';
import 'package:sheshield/core/services/device_alarm_service.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/core/services/evidence_service.dart';
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
import 'package:sheshield/features/auth/domain/usecases/set_discoverable_usecase.dart';

// ==================== HELPER ====================
import 'package:sheshield/features/helper/data/datasources/helper_api_datasource.dart';
import 'package:sheshield/features/helper/data/repositories/helper_repository_impl.dart';
import 'package:sheshield/features/helper/domain/repositories/i_helper_repository.dart';
import 'package:sheshield/features/helper/domain/usecases/accept_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_nearby_alerts_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/release_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/get_safety_status_usecase.dart';

// ==================== SOS ====================
import 'package:sheshield/features/sos/data/datasources/sos_api_datasource.dart';
import 'package:sheshield/features/sos/data/repositories/sos_repository_impl.dart';
import 'package:sheshield/features/sos/domain/repositories/i_sos_repository.dart';
import 'package:sheshield/features/sos/domain/usecases/send_sos_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/update_sos_location_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/resolve_sos_alert_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/get_alert_history_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/trigger_duress_usecase.dart';

// ==================== REPORT ====================
import 'package:sheshield/features/report/data/datasources/report_api_datasource.dart';
import 'package:sheshield/features/report/data/repositories/report_repository_impl.dart';
import 'package:sheshield/features/report/domain/repositories/i_report_repository.dart';
import 'package:sheshield/features/report/domain/usecases/file_report_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/block_user_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/unblock_user_usecase.dart';
import 'package:sheshield/features/report/domain/usecases/list_blocks_usecase.dart';

// ==================== CONTACTS ====================
import 'package:sheshield/features/contacts/data/datasources/contacts_api_datasource.dart';
import 'package:sheshield/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:sheshield/features/contacts/domain/repositories/i_contacts_repository.dart';
import 'package:sheshield/features/contacts/domain/usecases/accept_contact_invite_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/invite_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/remove_contact_usecase.dart';

// ==================== SETTINGS ====================
import 'package:sheshield/features/settings/data/repositories/locale_repository_impl.dart';
import 'package:sheshield/features/settings/domain/repositories/i_locale_repository.dart';
import 'package:sheshield/features/settings/data/repositories/theme_mode_repository_impl.dart';
import 'package:sheshield/features/settings/domain/repositories/i_theme_mode_repository.dart';

// ==================== VERIFICATION ====================
import 'package:sheshield/features/verification/data/datasources/verification_api_datasource.dart';
import 'package:sheshield/features/verification/data/repositories/verification_repository_impl.dart';
import 'package:sheshield/features/verification/domain/repositories/i_verification_repository.dart';
import 'package:sheshield/features/verification/domain/usecases/get_verification_status_usecase.dart';
import 'package:sheshield/features/verification/domain/usecases/submit_verification_usecase.dart';

// ==================== ADMIN ====================
import 'package:sheshield/features/admin/data/datasources/admin_api_datasource.dart';
import 'package:sheshield/features/admin/data/repositories/admin_repository_impl.dart';
import 'package:sheshield/features/admin/domain/repositories/i_admin_repository.dart';
import 'package:sheshield/features/admin/domain/usecases/has_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/set_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/clear_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_queue_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_detail_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/review_report_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/suspend_helper_usecase.dart';

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
    () => EvidenceService(),
  );

  getIt.registerLazySingleton(
    () => PushService(),
  );

  final cacheBox = await createCacheBox();

  getIt.registerSingleton<CacheBox>(cacheBox);

  // ==================== SETTINGS FEATURE ====================

  getIt.registerLazySingleton<ILocaleRepository>(
    () => LocaleRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<IThemeModeRepository>(
    () => ThemeModeRepositoryImpl(getIt()),
  );

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

  getIt.registerLazySingleton(
    () => SetDiscoverableUseCase(getIt()),
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

  getIt.registerLazySingleton(
    () => ReleaseAlertUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetSafetyStatusUseCase(getIt()),
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

  getIt.registerLazySingleton(
    () => GetAlertHistoryUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => TriggerDuressUseCase(getIt()),
  );

  // ==================== REPORT FEATURE ====================

  getIt.registerLazySingleton(
    () => ReportApiDataSource(getIt()),
  );

  getIt.registerLazySingleton<IReportRepository>(
    () => ReportRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton(
    () => FileReportUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => BlockUserUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => UnblockUserUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => ListBlocksUseCase(getIt()),
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

  // ==================== ADMIN FEATURE ====================
  // Separate credential (X-Admin-Key) from the app's own user JWT -- see
  // AdminApiDataSource's doc comment. Uses the same DioClient and CacheBox
  // singletons every other feature does; nothing new to construct.

  getIt.registerLazySingleton(
    () => AdminApiDataSource(getIt(), getIt()),
  );

  getIt.registerLazySingleton<IAdminRepository>(
    () => AdminRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton(
    () => HasAdminKeyUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => SetAdminKeyUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => ClearAdminKeyUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetReportQueueUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => GetReportDetailUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => ReviewReportUseCase(getIt()),
  );

  getIt.registerLazySingleton(
    () => SuspendHelperUseCase(getIt()),
  );
}