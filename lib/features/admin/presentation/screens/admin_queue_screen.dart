import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import '../providers/admin_queue_provider.dart';
import '../providers/admin_session_provider.dart';
import 'admin_verification_screen.dart';
import '../widgets/report_queue_tile.dart';

/// The moderation queue -- one shared list for both directions (a helper
/// reporting a requester, a requester reporting a helper, or a system
/// rate-limit flag), oldest-first, matching `admin reports queue`'s CLI
/// output exactly. Pull-to-refresh forces past the 20s cache.
class AdminQueueScreen extends ConsumerWidget {
  const AdminQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;
    final queueAsync = ref.watch(adminQueueControllerProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.adminQueueTitle),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.verified_user_rounded),
            tooltip: 'Helper verification',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => const AdminVerificationScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: l10n.adminSignOut,
            onPressed: () async {
              await ref.read(adminSessionControllerProvider.notifier).signOut();
              if (context.mounted) const AdminLoginRoute().go(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(adminQueueControllerProvider.notifier).refresh(),
        child: queueAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ListView(
            padding: const EdgeInsets.only(top: 80),
            children: [Center(child: Text('$e'))],
          ),
          data: (reports) => reports.isEmpty
              ? ListView(
                  padding: const EdgeInsets.only(top: 120),
                  children: [
                    Center(
                      child: Text(l10n.adminQueueEmpty,
                          style: TextStyle(color: colors.textSecondary)),
                    ),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  itemCount: reports.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final report = reports[i];
                    return ReportQueueTile(
                      report: report,
                      colors: colors,
                      onTap: () =>
                          AdminReportDetailRoute($extra: report.id).go(context),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
