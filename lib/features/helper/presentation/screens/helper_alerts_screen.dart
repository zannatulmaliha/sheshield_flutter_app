import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/hooks/use_periodic_callback.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_activity_providers.dart';
import 'package:sheshield/features/helper/presentation/providers/nearby_alerts_provider.dart';
import 'package:sheshield/features/helper/presentation/widgets/accept_alert_flow.dart';
import 'package:sheshield/features/helper/presentation/widgets/my_response_tab.dart';
import 'package:sheshield/features/helper/presentation/widgets/nearby_alerts_tab.dart';

/// Alerts tab: "Nearby Alerts (n)" and "My Response (0/1)".
class HelperAlertsScreen extends HookConsumerWidget {
  const HelperAlertsScreen({super.key});

  static const _pollInterval = Duration(seconds: 10);
  static const _myResponseTabIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final tabController = useTabController(initialLength: 2);
    final alertCount =
        ref.watch(nearbyAlertsControllerProvider).valueOrNull?.length ?? 0;
    final myResponseCount = ref.watch(myResponseProvider).valueOrNull == null ? 0 : 1;

    usePeriodicCallback(
      _pollInterval,
      () => ref.read(nearbyAlertsControllerProvider.notifier).refresh(),
    );

    return Column(
      children: [
        Material(
          color: palette.surface,
          child: TabBar(
            controller: tabController,
            labelColor: palette.primary,
            unselectedLabelColor: palette.textSecondary,
            indicatorColor: palette.primary,
            tabs: [
              Tab(text: 'Nearby Alerts ($alertCount)'),
              Tab(text: 'My Response ($myResponseCount)'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              NearbyAlertsTab(
                onAccept: (alert) async {
                  final acceptedAlert = await runAcceptAlertFlow(context, ref, alert);
                  if (acceptedAlert != null) {
                    tabController.animateTo(_myResponseTabIndex);
                  }
                },
              ),
              const MyResponseTab(),
            ],
          ),
        ),
      ],
    );
  }
}
