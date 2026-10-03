import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key, required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome_rounded, color: palette.primary, size: 40),
            const SizedBox(height: 14),
            Text(
              'Ask AI Guardian anything -- safety tips, what to do in an '
              'emergency, or just talk something through.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: palette.textSecondary,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
