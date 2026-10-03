import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/hooks/use_countdown.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';
import 'package:sheshield/features/user/presentation/widgets/sheet_container.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_confirm_step.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_consent_step.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_countdown_step.dart';

const _countdownSeconds = 10;

Future<void> showSosConfirmSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const SosConfirmSheet(),
  );
}

/// The three steps of the spec's §2 SOS prelude: confirm -> a cancelable 10s
/// countdown (no penalty for backing out) -> a real-time AV-recording
/// consent prompt -> only then does the alert actually fire.
enum SosStep { confirm, countdown, consent }

class SosConfirmSheet extends HookConsumerWidget {
  const SosConfirmSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final step = useState(SosStep.confirm);
    final isSending = useState(false);
    final secondsLeft = useCountdown(
      seconds: _countdownSeconds,
      isRunning: step.value == SosStep.countdown,
      onFinished: () => step.value = SosStep.consent,
    );

    Future<void> sendWithConsent(bool avConsent) async {
      if (isSending.value) return;
      isSending.value = true;

      final errorMessage =
          await ref.read(sosControllerProvider.notifier).send(avConsent: avConsent);

      if (context.mounted) Navigator.of(context).pop();
      // The sheet is gone by now, so report the outcome on the root navigator.
      final rootContext = rootNavigatorKey.currentContext;
      if (rootContext == null || !rootContext.mounted) return;

      if (errorMessage != null) {
        ScaffoldMessenger.of(rootContext).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        return;
      }
      const SosSentRoute().push(rootContext);
    }

    return SheetContainer(
      palette: palette,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 42,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          switch (step.value) {
            SosStep.confirm => SosConfirmStep(
                palette: palette,
                onConfirm: () => step.value = SosStep.countdown,
              ),
            SosStep.countdown => SosCountdownStep(
                palette: palette,
                secondsLeft: secondsLeft,
                // Nothing was ever sent, so there is nothing to undo.
                onCancel: () => Navigator.of(context).pop(),
              ),
            SosStep.consent => SosConsentStep(
                palette: palette,
                isSending: isSending.value,
                onAnswer: sendWithConsent,
              ),
          },
        ],
      ),
    );
  }
}
