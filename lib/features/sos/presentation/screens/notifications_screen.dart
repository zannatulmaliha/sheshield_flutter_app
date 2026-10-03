import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/sos/presentation/providers/alert_history_provider.dart';
import 'package:sheshield/features/sos/presentation/widgets/alert_history_card.dart';
import 'package:sheshield/features/sos/presentation/widgets/notifications_empty_state.dart';

/// The screen behind the home bell icon: the signed-in user's own SOS
/// history, most recent first. An accepted alert has a button to chat with
/// the helper.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: Text(l10n.notifications),
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(alertHistoryControllerProvider.notifier).refresh(),
        child: ref.watch(alertHistoryControllerProvider).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ListView(
                padding: const EdgeInsets.only(top: 80),
                children: [Center(child: Text(describeErrorForUser(error)))],
              ),
              data: (alerts) => alerts.isEmpty
                  ? NotificationsEmptyState(palette: palette, l10n: l10n)
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                      itemCount: alerts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => AlertHistoryCard(
                        alert: alerts[index],
                        palette: palette,
                        l10n: l10n,
                      ),
                    ),
            ),
      ),
    );
  }
}
