import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/verification/domain/entities/verification_status.dart';
import 'package:sheshield/features/verification/presentation/providers/verification_provider.dart';
import 'package:sheshield/features/verification/presentation/widgets/verification_form.dart';
import 'package:sheshield/features/verification/presentation/widgets/verification_status_view.dart';

/// A helper's ID is checked before they may respond to alerts, because
/// helpers can see where someone in danger is. This screen collects the
/// photos; the decision is made by an admin on the server, never the app.
class VerificationScreen extends ConsumerWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final controller = ref.read(verificationControllerProvider.notifier);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: const Text('Helper verification'),
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: ref.watch(verificationControllerProvider).when(
              loading: () => const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => ListView(
                children: [
                  VerificationStatusView(
                    colors: palette,
                    icon: Icons.cloud_off_rounded,
                    color: palette.textSecondary,
                    title: "Couldn't load your status",
                    message: 'Check your connection and try again.',
                    buttonLabel: 'Try again',
                    onButton: () => ref.invalidate(verificationControllerProvider),
                  ),
                ],
              ),
              data: (status) => switch (status.status) {
                VerificationState.approved => ListView(
                    children: [
                      VerificationStatusView(
                        colors: palette,
                        icon: Icons.verified_rounded,
                        color: palette.success,
                        title: "You're verified",
                        message: 'You can now respond to alerts near you.',
                        buttonLabel: 'Done',
                        onButton: () => context.pop(),
                      ),
                    ],
                  ),
                VerificationState.pending => ListView(
                    children: [
                      VerificationStatusView(
                        colors: palette,
                        icon: Icons.hourglass_top_rounded,
                        color: palette.warning,
                        title: 'Under review',
                        message: 'A reviewer is checking your documents. '
                            'Pull down to check for an update.',
                        buttonLabel: 'Check now',
                        onButton: controller.refresh,
                      ),
                    ],
                  ),
                VerificationState.none ||
                VerificationState.rejected =>
                  VerificationForm(status: status),
              },
            ),
      ),
    );
  }
}
