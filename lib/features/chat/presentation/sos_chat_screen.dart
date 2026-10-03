import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/features/chat/presentation/providers/sos_chat_provider.dart';
import 'package:sheshield/features/chat/presentation/widgets/chat_safety_banner.dart';
import 'package:sheshield/features/chat/presentation/widgets/sos_chat_app_bar_title.dart';
import 'package:sheshield/features/chat/presentation/widgets/sos_chat_bubble.dart';
import 'package:sheshield/features/chat/presentation/widgets/sos_chat_composer.dart';

/// Full-screen in-app chat for one SOS, used by both the helper (from the
/// response screen) and the requester. Nobody ever sees a phone number or
/// name; messages are labelled only "Helper" / "Person in need".
class SosChatScreen extends HookConsumerWidget {
  const SosChatScreen({super.key, required this.sosId, required this.iAmHelper});

  final String sosId;
  final bool iAmHelper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chat = ref.watch(sosChatControllerProvider(sosId));
    final textController = useTextEditingController();
    final scrollController = useScrollController();
    final otherPartyLabel = iAmHelper ? 'Person in need' : 'Helper';

    // Jump to the newest message whenever one arrives.
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
      return null;
    }, [chat.messages.length],);

    void sendTypedText() {
      final typedText = textController.text;
      if (typedText.trim().isEmpty || chat.isSending || chat.isClosed) return;
      textController.clear();
      ref.read(sosChatControllerProvider(sosId).notifier).send(typedText);
    }

    return Scaffold(
      appBar: AppBar(
        title: SosChatAppBarTitle(sosId: sosId, iAmHelper: iAmHelper),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ChatSafetyBanner(),
            Expanded(
              child: chat.messages.isEmpty
                  ? const Center(
                      child: Text(
                        'No messages yet. Say hello.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(14),
                      itemCount: chat.messages.length,
                      itemBuilder: (context, index) => SosChatBubble(
                        message: chat.messages[index],
                        otherPartyLabel: otherPartyLabel,
                      ),
                    ),
            ),
            if (chat.errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Text(
                  chat.isClosed
                      ? 'This emergency has ended, so the chat is closed.'
                      : chat.errorMessage!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                ),
              ),
            SosChatComposer(
              controller: textController,
              isEnabled: !chat.isClosed,
              isSending: chat.isSending,
              onSend: sendTypedText,
            ),
          ],
        ),
      ),
    );
  }
}
