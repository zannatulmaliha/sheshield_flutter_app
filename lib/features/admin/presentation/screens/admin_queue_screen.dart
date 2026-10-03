import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_queue_provider.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_session_provider.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_async_body.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_scaffold.dart';
import 'package:sheshield/features/admin/presentation/widgets/report_queue_tile.dart';

/// The moderation queue: one shared list for every direction of report,
/// oldest-first. Pull-to-refresh forces past the 20s cache.
class AdminQueueScreen extends ConsumerWidget {
  const AdminQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);

    return AdminScaffold(
      title: l10n.adminQueueTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.verified_user_rounded),
          tooltip: 'Helper verification',
          onPressed: () => const AdminVerificationQueueRoute().push(context),
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
      body: RefreshIndicator(
        onRefresh: () => ref.read(adminQueueControllerProvider.notifier).refresh(),
        child: AdminAsyncBody<List<AdminReport>>(
          value: ref.watch(adminQueueControllerProvider),
          builder: (reports) => reports.isEmpty
              ? ListView(
                  padding: const EdgeInsets.only(top: 120),
                  children: [
                    Center(
                      child: Text(
                        l10n.adminQueueEmpty,
                        style: TextStyle(color: palette.textSecondary),
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  itemCount: reports.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => ReportQueueTile(
                    report: reports[index],
                    palette: palette,
                    onTap: () => AdminReportDetailRoute($extra: reports[index].id)
                        .go(context),
                  ),
                ),
        ),
      ),
    );
  }
}
