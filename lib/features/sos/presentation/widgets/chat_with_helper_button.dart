import 'package:flutter/material.dart';
import 'package:sheshield/features/chat/presentation/sos_chat_screen.dart';

class ChatWithHelperButton extends StatelessWidget {
  const ChatWithHelperButton({super.key, required this.alertId, required this.color});

  final String alertId;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FilledButton.icon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => SosChatScreen(sosId: alertId, iAmHelper: false),
            ),
          ),
          icon: const Icon(Icons.chat_bubble_rounded, size: 16),
          label: const Text('Chat with your helper'),
          style: FilledButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
