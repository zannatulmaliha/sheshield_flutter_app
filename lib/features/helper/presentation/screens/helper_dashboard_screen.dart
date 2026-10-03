import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/hooks/use_periodic_callback.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/helper/domain/entities/helper_stats.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_activity_providers.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_status_provider.dart';
import 'package:sheshield/features/helper/presentation/providers/nearby_alerts_provider.dart';
import 'package:sheshield/features/helper/presentation/widgets/accept_alert_flow.dart';
import 'package:sheshield/features/helper/presentation/widgets/active_helper_card.dart';
import 'package:sheshield/features/helper/presentation/widgets/helper_not_verified_view.dart';
import 'package:sheshield/features/helper/presentation/widgets/helper_stats_row.dart';
import 'package:sheshield/features/helper/presentation/widgets/inactive_helper_hint.dart';
import 'package:sheshield/features/helper/presentation/widgets/nearby_alerts_section.dart';

/// GO ACTIVE toggle, response radius, and the nearby-alerts list.
/// [isVerified] / [onVerify] gate the whole screen: an unverified helper
/// never sees the toggle or any alert data.
class HelperDashboardScreen extends HookConsumerWidget {
  const HelperDashboardScreen({
    super.key,
    required this.isVerified,
    required this.onVerify,
  });

  static const _pollInterval = Duration(seconds: 15);

  final bool isVerified;
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    usePeriodicCallback(
      _pollInterval,
      () => ref.read(nearbyAlertsControllerProvider.notifier).refresh(),
      enabled: isVerified,
    );

    if (!isVerified) return HelperNotVerifiedView(onVerify: onVerify);

    final palette = resolvePalette(context, ref);
    final statusState = ref.watch(helperStatusControllerProvider);
    final statusController = ref.read(helperStatusControllerProvider.notifier);

    Future<void> toggleActive(bool isActive) async {
      final errorMessage = await statusController.toggleActive(isActive);
      if (errorMessage != null && context.mounted) context.showMessage(errorMessage);
    }

    Future<void> acceptAlert(NearbyAlert alert) async {
      final acceptedAlert = await runAcceptAlertFlow(context, ref, alert);
      if (acceptedAlert == null || !context.mounted) return;
      await HelperAlertDetailRoute($extra: acceptedAlert).push(context);
      ref.invalidate(helperStatsProvider);
    }

    return statusState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(describeErrorForUser(error))),
      data: (status) => SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => ref.read(nearbyAlertsControllerProvider.notifier).refresh(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            children: [
              Text(
                AppLocalizations.of(context).helperDashboard,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              ActiveHelperCard(
                status: status,
                isBusy: statusState.isLoading,
                onToggle: toggleActive,
                onRadiusChanged: statusController.setRadius,
                onMutualConnectionChanged: statusController.setMutualConnectionOptIn,
              ),
              const SizedBox(height: 16),
              HelperStatsRow(
                stats: ref.watch(helperStatsProvider).valueOrNull ?? const HelperStats(),
                palette: palette,
              ),
              const SizedBox(height: 22),
              if (status.isActive)
                NearbyAlertsSection(
                  alertsState: ref.watch(nearbyAlertsControllerProvider),
                  onAccept: acceptAlert,
                )
              else
                const InactiveHelperHint(),
            ],
          ),
        ),
      ),
    );
  }
}
