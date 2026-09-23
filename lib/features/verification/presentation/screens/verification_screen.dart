import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import '../../domain/entities/verification_status.dart';
import '../providers/verification_provider.dart';
import '../widgets/verification_form.dart';
import '../widgets/verification_status_view.dart';

/// Helpers can see where someone in danger is, so a person checks every
/// helper's ID before they may respond to alerts. This screen collects the
/// three photos; the decision is made by an admin on the server
/// (internal/verification's admin command), never by the app.
class VerificationScreen extends ConsumerWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final async = ref.watch(verificationControllerProvider);
    final controller = ref.read(verificationControllerProvider.notifier);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Helper verification'),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: async.when(
          loading: () => const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => ListView(children: [
            VerificationStatusView(
              colors: colors,
              icon: Icons.cloud_off_rounded,
              color: colors.textSecondary,
              title: "Couldn't load your status",
              message: 'Check your connection and try again.',
              buttonLabel: 'Try again',
              onButton: () => ref.invalidate(verificationControllerProvider),
            ),
          ]),
          data: (status) => _body(context, status, controller, colors),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, VerificationStatus status, VerificationController controller, AppPalette colors) {
    return switch (status.status) {
      VerificationState.approved => ListView(children: [
          VerificationStatusView(
            colors: colors,
            icon: Icons.verified_rounded,
            color: colors.success,
            title: "You're verified",
            message: 'You can now respond to alerts near you.',
            buttonLabel: 'Done',
            onButton: () => context.pop(),
          ),
        ]),
      VerificationState.pending => ListView(children: [
          VerificationStatusView(
            colors: colors,
            icon: Icons.hourglass_top_rounded,
            color: colors.warning,
            title: 'Under review',
            message: 'A reviewer is checking your documents. Pull down to check for an update.',
            buttonLabel: 'Check now',
            onButton: controller.refresh,
          ),
        ]),
      VerificationState.none || VerificationState.rejected =>
        VerificationForm(status: status, onSubmit: controller.submit),
    };
  }
}