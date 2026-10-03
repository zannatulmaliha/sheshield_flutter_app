import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/sos/domain/entities/duress_type.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';

/// "I'm Safe" and the secondary panic trigger.
///
/// The panic trigger (spec §2a/§6) bypasses whichever helper is matched:
/// it notifies new responders and trusted contacts in parallel without
/// waiting on that helper. It is always intentional, so there is no extra
/// confirm step beyond the tap itself.
class SosSentActions extends ConsumerWidget {
  const SosSentActions({super.key, required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sosController = ref.read(sosControllerProvider.notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: palette.sosEnd,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () async {
              await sosController.markSafe();
              if (context.mounted) context.pop();
            },
            child: const Text("I'm Safe", style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () async {
            await sosController.triggerDuress(DuressType.manualPanic);
            if (context.mounted) {
              context.showMessage('Emergency escalated -- trusted contacts notified again.');
            }
          },
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          icon: const Icon(Icons.emergency_share_rounded, size: 18),
          label: const Text(
            'Still in danger? Escalate now',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
