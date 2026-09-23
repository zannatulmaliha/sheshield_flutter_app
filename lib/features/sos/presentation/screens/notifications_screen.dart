import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import '../../domain/entities/alert_summary.dart';
import '../providers/alert_history_provider.dart';

/// The screen behind the home bell icon: the signed-in user's own SOS
/// history (GET /api/v1/alerts), most recent first. Read-only -- there is
/// nothing to act on here, unlike the helper's nearby-alerts list.
class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;
    final historyAsync = ref.watch(alertHistoryControllerProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.notifications),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(alertHistoryControllerProvider.notifier).refresh(),
        child: historyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(
            padding: const EdgeInsets.only(top: 80),
            children: [Center(child: Text('$e'))],
          ),
          data: (alerts) => alerts.isEmpty
              ? _EmptyState(colors: colors, l10n: l10n)
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  itemCount: alerts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) => _AlertHistoryCard(colors: colors, alert: alerts[i], l10n: l10n),
                ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.colors, required this.l10n});
  final AppPalette colors;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 100),
      children: [
        Icon(Icons.notifications_none_rounded, size: 56, color: colors.textSecondary.withValues(alpha: 0.5)),
        const SizedBox(height: 16),
        Text(
          l10n.noNotificationsYetTitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: colors.textPrimary),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.noNotificationsYetBody,
          textAlign: TextAlign.center,
          style: TextStyle(color: colors.textSecondary, fontSize: 13),
        ),
      ],
    );
  }
}

class _AlertHistoryCard extends StatelessWidget {
  const _AlertHistoryCard({required this.colors, required this.alert, required this.l10n});
  final AppPalette colors;
  final AlertSummary alert;
  final AppLocalizations l10n;

  String _statusLabel() => switch (alert.status) {
        'active' => l10n.alertStatusActive,
        'accepted' => l10n.alertStatusAccepted,
        _ => l10n.alertStatusResolved,
      };

  Color _statusColor() => switch (alert.status) {
        'active' => colors.sosStart,
        'accepted' => colors.warning,
        _ => colors.success,
      };

  String _deliverySummary() {
    if (alert.totalCount == 0) return l10n.sosNotifiedFallback;
    if (alert.failedCount == 0) return l10n.sosNotifiedAll(alert.sentCount);
    return l10n.sosNotifiedPartial(alert.sentCount, alert.totalCount, alert.failedCount);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 14, offset: const Offset(0, 6)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), shape: BoxShape.circle),
            child: Icon(Icons.shield_rounded, color: statusColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('MMM d, y · h:mm a').format(alert.createdAt.toLocal()),
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: colors.textPrimary),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        _statusLabel(),
                        style: TextStyle(color: statusColor, fontWeight: FontWeight.w800, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _deliverySummary(),
                  style: TextStyle(fontSize: 12.5, color: colors.textSecondary, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
