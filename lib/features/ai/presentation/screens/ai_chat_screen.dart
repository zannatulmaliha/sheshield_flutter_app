import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/ai/domain/entities/chat_message.dart';
import 'package:sheshield/features/ai/presentation/providers/ai_chat_provider.dart';

/// Full-screen "Ask AI Guardian" conversation, pushed from the ask bar on
/// [AiModeScreen]. The conversation itself lives in
/// [aiChatControllerProvider], not local state, so it survives this
/// screen being popped and reopened within the same app session.
class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final SpeechToText _speech = SpeechToText();
  bool _listening = false;

  @override
  void dispose() {
    if (_listening) _speech.stop();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// Dictates into the text field for the user to review -- never sends
  /// automatically, so a misheard word can be fixed before it goes out.
  Future<void> _toggleMic() async {
    if (_listening) {
      await _speech.stop();
      if (mounted) setState(() => _listening = false);
      return;
    }

    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Microphone permission is needed for voice input.')),
        );
      }
      return;
    }

    final available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          if (mounted) setState(() => _listening = false);
        }
      },
    );
    if (!available) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Speech recognition is not available on this device.')),
        );
      }
      return;
    }

    setState(() => _listening = true);
    await _speech.listen(
      onResult: _handleSpeechResult,
      listenOptions: SpeechListenOptions(partialResults: true),
    );
  }

  void _handleSpeechResult(SpeechRecognitionResult result) {
    _textController.value = TextEditingValue(
      text: result.recognizedWords,
      selection: TextSelection.collapsed(offset: result.recognizedWords.length),
    );
  }

  Future<void> _send() async {
    final text = _textController.text;
    if (text.trim().isEmpty) return;
    _textController.clear();
    await ref.read(aiChatControllerProvider.notifier).send(text);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final chat = ref.watch(aiChatControllerProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        foregroundColor: colors.textPrimary,
        title: const Text('AI Guardian'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: chat.messages.isEmpty
                  ? _EmptyState(colors: colors)
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: chat.messages.length,
                      itemBuilder: (context, i) => _MessageBubble(
                        message: chat.messages[i],
                        colors: colors,
                      ),
                    ),
            ),
            if (chat.isSending)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: colors.primary),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'AI Guardian is thinking...',
                      style: TextStyle(
                          color: colors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            _InputBar(
              controller: _textController,
              listening: _listening,
              colors: colors,
              onMic: _toggleMic,
              onSend: _send,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.colors});
  final AppPalette colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome_rounded, color: colors.primary, size: 40),
            const SizedBox(height: 14),
            Text(
              'Ask AI Guardian anything -- safety tips, what to do in an emergency, or just talk something through.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: colors.textSecondary, fontSize: 13, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.colors});
  final ChatMessage message;
  final AppPalette colors;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isUser ? colors.primary : colors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 18),
          ),
          boxShadow: isUser ? null : softShadow(opacity: 0.06),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: isUser ? Colors.white : colors.textPrimary,
            fontSize: 13.5,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.listening,
    required this.colors,
    required this.onMic,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool listening;
  final AppPalette colors;
  final VoidCallback onMic;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.07),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onMic,
              icon: Icon(
                listening ? Icons.mic_rounded : Icons.mic_none_rounded,
                color: listening ? colors.sosEnd : colors.primary,
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: listening
                      ? 'Listening...'
                      : 'Ask AI Guardian anything...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: onSend,
              icon: Icon(Icons.send_rounded, color: colors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
