import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/ai/domain/entities/chat_message.dart';
import 'package:sheshield/features/ai/domain/repositories/ai_repository.dart';
import 'package:sheshield/features/ai/domain/usecases/send_chat_message_usecase.dart';
import 'package:sheshield/features/ai/presentation/providers/ai_chat_provider.dart';
import 'package:sheshield/features/ai/presentation/providers/ai_use_case_providers.dart';

class _FakeAiRepository implements AiRepository {
  _FakeAiRepository({this.failure});

  final AppFailure? failure;
  final receivedHistories = <List<ChatMessage>>[];

  @override
  Future<String> sendChatMessage(List<ChatMessage> history) async {
    receivedHistories.add(history);
    if (failure != null) throw failure!;
    return 'stay in a lit, busy place';
  }
}

ProviderContainer _containerWith(_FakeAiRepository repository) {
  final container = ProviderContainer(
    overrides: [
      sendChatMessageUseCaseProvider
          .overrideWithValue(SendChatMessageUseCase(repository)),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('appends the person\'s turn, then the assistant reply', () async {
    final container = _containerWith(_FakeAiRepository());
    container.listen(aiChatControllerProvider, (_, __) {});

    await container.read(aiChatControllerProvider.notifier).send('  help  ');

    final chat = container.read(aiChatControllerProvider);
    expect(chat.isSending, isFalse);
    expect(chat.messages.map((m) => m.role), [ChatRole.user, ChatRole.assistant]);
    expect(chat.messages.first.content, 'help');
  });

  test('a failure becomes an assistant message and keeps the user turn', () async {
    final container = _containerWith(
      _FakeAiRepository(failure: const AppFailure(message: 'No internet')),
    );
    container.listen(aiChatControllerProvider, (_, __) {});

    await container.read(aiChatControllerProvider.notifier).send('hello');

    final messages = container.read(aiChatControllerProvider).messages;
    expect(messages, hasLength(2));
    expect(messages.last.content, 'No internet');
  });

  test('blank input is ignored and history is capped at 20 messages', () async {
    final repository = _FakeAiRepository();
    final container = _containerWith(repository);
    container.listen(aiChatControllerProvider, (_, __) {});
    final controller = container.read(aiChatControllerProvider.notifier);

    await controller.send('   ');
    expect(repository.receivedHistories, isEmpty);

    for (var turn = 0; turn < 15; turn++) {
      await controller.send('message $turn');
    }
    expect(repository.receivedHistories.last, hasLength(20));
  });
}
