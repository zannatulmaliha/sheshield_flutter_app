import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/ai/domain/entities/chat_message.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({super.key, required this.message, required this.palette});

  final ChatMessage message;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final isFromUser = message.isFromUser;

    return Align(
      alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isFromUser ? palette.primary : palette.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isFromUser ? 18 : 4),
            bottomRight: Radius.circular(isFromUser ? 4 : 18),
          ),
          boxShadow: isFromUser ? null : softShadow(opacity: 0.06),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: isFromUser ? Colors.white : palette.textPrimary,
            fontSize: 13.5,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
