import 'package:get_it/get_it.dart';
import 'package:sheshield/core/config/app_config.dart';
import 'package:sheshield/core/di/modules/admin_module.dart';
import 'package:sheshield/core/di/modules/ai_module.dart';
import 'package:sheshield/core/di/modules/auth_module.dart';
import 'package:sheshield/core/di/modules/chat_module.dart';
import 'package:sheshield/core/di/modules/contacts_module.dart';
import 'package:sheshield/core/di/modules/core_module.dart';
import 'package:sheshield/core/di/modules/helper_module.dart';
import 'package:sheshield/core/di/modules/report_module.dart';
import 'package:sheshield/core/di/modules/settings_module.dart';
import 'package:sheshield/core/di/modules/sos_module.dart';
import 'package:sheshield/core/di/modules/user_module.dart';
import 'package:sheshield/core/di/modules/verification_module.dart';

final getIt = GetIt.instance;

/// Composition root. Each feature owns one module file; this only fixes
/// the order. Widgets never call [getIt] -- they read Riverpod providers
/// (see each feature's `*_providers.dart`), which resolve from here.
Future<void> configureDependencies(AppConfig config) async {
  await registerCoreDependencies(getIt, config);
  registerSettingsDependencies(getIt);
  registerAuthDependencies(getIt);
  registerHelperDependencies(getIt);
  registerSosDependencies(getIt);
  registerReportDependencies(getIt);
  registerContactsDependencies(getIt);
  registerVerificationDependencies(getIt);
  registerAiDependencies(getIt);
  registerAdminDependencies(getIt);
  registerChatDependencies(getIt);
  registerUserDependencies(getIt);
}
