import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sheshield/features/helper/presentation/helper_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import '../providers/helper_extras_provider.dart';
import '../providers/helper_status_provider.dart';
import '../providers/nearby_alerts_provider.dart';
import '../widgets/helper_response_view.dart';
import '../widgets/nearby_alert_card.dart';

/// Alerts tab: "Nearby Alerts (n)" and "My Response (0/1)".
class HelperAlertsScreen extends ConsumerStatefulWidget {
  const HelperAlertsScreen({super.key});

  @override
  ConsumerState<HelperAlertsScreen> createState() => _HelperAlertsScreenState();
}

class _HelperAlertsScreenState extends ConsumerState<HelperAlertsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _poll = Timer.periodic(Duration(seconds: 10), (_) {
      ref.read(nearbyAlertsControllerProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _poll?.cancel();
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _accept(NearbyAlert alert) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Accept this alert?'),
        content: Text('${alert.label}. You will get the exact location of the person ${alert.distanceLabel}. Only accept if you can get there safely.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Accept')),
        ],
      ),
    );
    if (confirmed != true) return;
    final accepted = await ref.read(nearbyAlertsControllerProvider.notifier).accept(alert.id);
    if (!mounted) return;
    if (accepted != null) {
      ref.invalidate(myResponseProvider);
      _tabs.animateTo(1);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Already matched - someone else responded first.')));
  }

  @override
  Widget build(BuildContext context) {
    final alertsAsync = ref.watch(nearbyAlertsControllerProvider);
    final status = ref.watch(helperStatusControllerProvider).valueOrNull;
    final mine = ref.watch(myResponseProvider);
    final alerts = alertsAsync.valueOrNull ?? <NearbyAlert>[];
    final myCount = mine.valueOrNull == null ? 0 : 1;

    return Column(
      children: [
        Material(
          color: context.hp.surface,
          child: TabBar(
            controller: _tabs,
            labelColor: context.hp.primary,
            unselectedLabelColor: context.hp.textSecondary,
            indicatorColor: context.hp.primary,
            tabs: [Tab(text: 'Nearby Alerts (${alerts.length})'), Tab(text: 'My Response ($myCount)')],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabs,
            children: [
              RefreshIndicator(
                onRefresh: () => ref.read(nearbyAlertsControllerProvider.notifier).refresh(),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 110),
                  children: [
                    if (status != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          status.isActive ? 'Showing alerts within ${status.radiusKm.round()}km' : 'You are inactive. Go active on the Dashboard to receive alerts.',
                          style: TextStyle(color: context.hp.textSecondary),
                        ),
                      ),
                    if (alertsAsync.isLoading && alerts.isEmpty)
                      Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()))
                    else if (alerts.isEmpty)
                      Padding(padding: EdgeInsets.all(32), child: Center(child: Text('No active SOS calls nearby.', style: TextStyle(color: context.hp.textSecondary))))
                    else
                      for (final a in alerts)
                        Padding(padding: EdgeInsets.only(bottom: 12), child: NearbyAlertCard(alert: a, isBusy: false, onAccept: () => _accept(a))),
                  ],
                ),
              ),
              mine.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('$e')),
                data: (r) => r == null
                    ? Center(child: Padding(padding: EdgeInsets.all(32), child: Text('You are not responding to an alert right now.', style: TextStyle(color: context.hp.textSecondary))))
                    : HelperResponseView(
                        key: ValueKey(r.alert.id),
                        alert: r.alert,
                        initialStage: r.stage,
                        onEnded: () => ref.invalidate(myResponseProvider),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}