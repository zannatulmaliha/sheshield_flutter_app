import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/chat/presentation/providers/responder_state_provider.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_helper_panel.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_sent_actions.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_sent_header.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_share_link_notice.dart';

/// Full-screen "SOS Alert Sent" confirmation. Pushed as a transparent
/// overlay route (see `SosSentRoute`) right after a successful send, so it
/// still reads as a modal floating over Home.
class SosActivatedView extends ConsumerWidget {
  const SosActivatedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final alert = ref.watch(sosControllerProvider).valueOrNull;

    // Tell the person the moment a helper accepts, instead of making them
    // guess.
    if (alert != null) {
      ref.listen(responderStateControllerProvider(alert.id), (previous, next) {
        final justAccepted =
            (next?.helperAccepted ?? false) && !(previous?.helperAccepted ?? false);
        if (justAccepted) {
          context.showMessage(
            'A helper accepted your SOS and is on the way. You can chat with them now.',
          );
        }
      });
    }

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SosSentHeader(alert: alert, palette: palette),
              if (alert != null) ...[
                const SizedBox(height: 16),
                SosHelperPanel(sosId: alert.id),
              ],
              if (alert?.shareUrl != null) ...[
                const SizedBox(height: 16),
                const SosShareLinkNotice(),
              ],
              const SizedBox(height: 32),
              SosSentActions(palette: palette),
            ],
          ),
        ),
      ),
    );
  }
}
