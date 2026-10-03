import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/config/app_config_provider.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/settings/presentation/providers/locale_provider.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';

class SheShieldApp extends ConsumerWidget {
  const SheShieldApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // sosControllerProvider is auto-dispose, and the SOS button only
    // ref.read()s it. With no listener, it was torn down right after the
    // alert was sent, so the "SOS Alert Sent" screen got a fresh, empty
    // controller (alert == null): no chat button, no helper status, and the
    // live-location timer stopped. A no-op listener at the root keeps the
    // active alert alive for the whole app session without rebuilding here.
    ref.listen(sosControllerProvider, (_, __) {});

    // valueOrNull: while the saved-language read is still resolving,
    // or if none was ever saved, this is null and MaterialApp falls
    // back to the device's own system locale automatically.
    final savedLanguage = ref.watch(localeControllerProvider).valueOrNull;

    return MaterialApp.router(
      title: ref.watch(appConfigProvider).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: router,
      locale: savedLanguage?.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}