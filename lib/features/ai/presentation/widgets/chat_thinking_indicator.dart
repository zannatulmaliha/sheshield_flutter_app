import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

class ChatThinkingIndicator extends StatelessWidget {
  const ChatThinkingIndicator({super.key, required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(
            width: 14,
            height: 14,
            child: CircularProgressIndicator(strokeWidth: 2, color: palette.primary),
          ),
          const SizedBox(width: 10),
          Text(
            'AI Guardian is thinking...',
            style: TextStyle(
              color: palette.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
