import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/features/user/presentation/providers/ai_mode_provider.dart';

/// The "Are you safe?" prompt. It closes itself when the controller's
/// countdown ends (an SOS is sent then) or the person answers.
class AutoCheckInDialog extends ConsumerWidget {
  const AutoCheckInDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final secondsLeft =
        ref.watch(aiModeControllerProvider.select((state) => state.autoCheckInSecondsLeft));

    ref.listen(
      aiModeControllerProvider.select((state) => state.autoCheckInSecondsLeft),
      (_, next) {
        if (next == null && context.mounted) Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      title: const Text('Are you safe?'),
      content: Text(
        'Auto Check-In: tap "Yes, I\'m safe" within ${secondsLeft ?? 0} seconds, '
        'or an SOS alert will be sent automatically.',
      ),
      actions: [
        ElevatedButton(
          onPressed: ref.read(aiModeControllerProvider.notifier).confirmSafe,
          child: const Text("Yes, I'm safe"),
        ),
      ],
    );
  }
}
