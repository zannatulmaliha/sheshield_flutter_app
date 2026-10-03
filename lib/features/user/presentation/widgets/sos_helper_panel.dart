import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/features/chat/domain/entities/responder_state.dart';
import 'package:sheshield/features/chat/presentation/providers/responder_state_provider.dart';
import 'package:sheshield/features/chat/presentation/sos_chat_screen.dart';

/// Whether a helper has accepted yet, plus the button to open the chat.
class SosHelperPanel extends ConsumerWidget {
  const SosHelperPanel({super.key, required this.sosId});

  final String sosId;

  String _statusLine(ResponderState? responder) {
    if (responder == null || !responder.helperAccepted) {
      return 'Looking for a nearby helper to accept...';
    }
    return switch (responder.progress) {
      ResponderProgress.arrived => 'Your helper has arrived.',
      ResponderProgress.assisting => 'Your helper is assisting you.',
      ResponderProgress.enRoute ||
      ResponderProgress.none =>
        'A helper accepted and is on the way.',
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responder = ref.watch(responderStateControllerProvider(sosId));
    final helperAccepted = responder?.helperAccepted ?? false;
    final accent = helperAccepted ? Colors.greenAccent : Colors.white70;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              helperAccepted ? Icons.verified_user_rounded : Icons.hourglass_top_rounded,
              color: accent,
              size: 18,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                _statusLine(responder),
                style: TextStyle(color: accent, fontSize: 13.5, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => SosChatScreen(sosId: sosId, iAmHelper: false),
            ),
          ),
          icon: const Icon(Icons.chat_bubble_rounded, color: Colors.white),
          label: Text(
            helperAccepted ? 'Chat with your helper' : 'Open chat',
            style: const TextStyle(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white54)),
        ),
      ],
    );
  }
}
