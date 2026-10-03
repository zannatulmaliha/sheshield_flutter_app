import 'package:flutter/material.dart';

class SosChatComposer extends StatelessWidget {
  const SosChatComposer({
    super.key,
    required this.controller,
    required this.isEnabled,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isEnabled;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: isEnabled,
              maxLength: 500,
              minLines: 1,
              maxLines: 3,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: const InputDecoration(
                counterText: '',
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: (isSending || !isEnabled) ? null : onSend,
            icon: isSending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }
}
