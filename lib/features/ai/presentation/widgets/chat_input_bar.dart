import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.isListening,
    required this.palette,
    required this.onMicPressed,
    required this.onSendPressed,
  });

  final TextEditingController controller;
  final bool isListening;
  final AppPalette palette;
  final VoidCallback onMicPressed;
  final VoidCallback onSendPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.07),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onMicPressed,
              icon: Icon(
                isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
                color: isListening ? palette.sosEnd : palette.primary,
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSendPressed(),
                decoration: InputDecoration(
                  hintText: isListening ? 'Listening...' : 'Ask AI Guardian anything...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: onSendPressed,
              icon: Icon(Icons.send_rounded, color: palette.primary),
            ),
          ],
        ),
      ),
    );
  }
}
