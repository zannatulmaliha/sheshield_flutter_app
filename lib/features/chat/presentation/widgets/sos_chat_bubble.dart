import 'package:flutter/material.dart';
import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';

/// One message. Others are labelled only by role ("Helper" / "Person in
/// need"), never by name.
class SosChatBubble extends StatelessWidget {
  const SosChatBubble({
    super.key,
    required this.message,
    required this.otherPartyLabel,
  });

  final SosChatMessage message;
  final String otherPartyLabel;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: isMine ? const Color(0xFF7C3AED) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMine)
              Text(
                otherPartyLabel,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
            Text(
              message.body,
              style: TextStyle(
                color: isMine ? Colors.white : Colors.black87,
                fontSize: 14.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
