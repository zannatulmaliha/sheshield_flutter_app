import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/ai/presentation/hooks/use_speech_dictation.dart';
import 'package:sheshield/features/ai/presentation/providers/ai_chat_provider.dart';
import 'package:sheshield/features/ai/presentation/widgets/chat_empty_state.dart';
import 'package:sheshield/features/ai/presentation/widgets/chat_input_bar.dart';
import 'package:sheshield/features/ai/presentation/widgets/chat_message_bubble.dart';
import 'package:sheshield/features/ai/presentation/widgets/chat_thinking_indicator.dart';

/// Full-screen "Ask AI Guardian" conversation. The conversation lives in
/// [aiChatControllerProvider], not local state, so it survives this screen
/// being popped and reopened within the same app session.
class AiChatScreen extends HookConsumerWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final chat = ref.watch(aiChatControllerProvider);
    final textController = useTextEditingController();
    final scrollController = useScrollController();
    final dictation = useSpeechDictation(
      textController: textController,
      onProblem: context.showMessage,
    );

    // Keep the newest message in view whenever the conversation grows.
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!scrollController.hasClients) return;
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      });
      return null;
    }, [chat.messages.length],);

    void sendTypedText() {
      final typedText = textController.text;
      if (typedText.trim().isEmpty) return;
      textController.clear();
      ref.read(aiChatControllerProvider.notifier).send(typedText);
    }

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.background,
        elevation: 0,
        foregroundColor: palette.textPrimary,
        title: const Text('AI Guardian'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: chat.messages.isEmpty
                  ? ChatEmptyState(palette: palette)
                  : ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: chat.messages.length,
                      itemBuilder: (context, index) => ChatMessageBubble(
                        message: chat.messages[index],
                        palette: palette,
                      ),
                    ),
            ),
            if (chat.isSending) ChatThinkingIndicator(palette: palette),
            ChatInputBar(
              controller: textController,
              isListening: dictation.isListening,
              palette: palette,
              onMicPressed: dictation.toggle,
              onSendPressed: sendTypedText,
            ),
          ],
        ),
      ),
    );
  }
}
