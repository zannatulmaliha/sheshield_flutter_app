import 'package:flutter/material.dart';

class ChatSafetyBanner extends StatelessWidget {
  const ChatSafetyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.amber.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: const Text(
        'Keep it in the app: phone numbers and social handles are not needed '
        'and are flagged for safety review.',
        style: TextStyle(fontSize: 11.5, color: Colors.black87),
      ),
    );
  }
}
