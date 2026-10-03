import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_verification_queue_provider.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_async_body.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_scaffold.dart';
import 'package:sheshield/features/admin/presentation/widgets/verification_tile.dart';

class AdminVerificationQueueScreen extends ConsumerWidget {
  const AdminVerificationQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    return AdminScaffold(
      title: 'Helper Verification',
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(adminVerificationQueueControllerProvider.notifier).refresh(),
        child: AdminAsyncBody<List<AdminVerification>>(
          value: ref.watch(adminVerificationQueueControllerProvider),
          builder: (verifications) => verifications.isEmpty
              ? ListView(
                  padding: const EdgeInsets.only(top: 120),
                  children: [
                    Center(
                      child: Text(
                        'No helper verification submissions.',
                        style: TextStyle(color: palette.textSecondary),
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  itemCount: verifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => VerificationTile(
                    verification: verifications[index],
                    onTap: () => AdminVerificationDetailRoute(
                      $extra: verifications[index].id,
                    ).push(context),
                  ),
                ),
        ),
      ),
    );
  }
}
