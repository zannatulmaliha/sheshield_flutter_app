import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/chat/domain/entities/responder_state.dart';
import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';
import 'package:sheshield/features/chat/domain/repositories/sos_chat_repository.dart';
import 'package:sheshield/features/chat/domain/usecases/get_sos_chat_messages_usecase.dart';
import 'package:sheshield/features/chat/domain/usecases/send_sos_chat_message_usecase.dart';
import 'package:sheshield/features/chat/presentation/providers/chat_use_case_providers.dart';
import 'package:sheshield/features/chat/presentation/providers/sos_chat_provider.dart';

SosChatMessage _message(int sequence, {bool isMine = false}) => SosChatMessage(
      sequence: sequence,
      id: 'm$sequence',
      sender: isMine ? 'requester' : 'helper',
      isMine: isMine,
      body: 'hello $sequence',
      createdAt: DateTime(2026),
    );

class _FakeSosChatRepository implements SosChatRepository {
  _FakeSosChatRepository({this.serverMessages = const [], this.sendFailure});

  final List<SosChatMessage> serverMessages;
  final AppFailure? sendFailure;
  final requestedCursors = <int>[];

  @override
  Future<List<SosChatMessage>> fetchMessages(
    String sosId, {
    int afterSequence = 0,
  }) async {
    requestedCursors.add(afterSequence);
    return serverMessages.where((m) => m.sequence > afterSequence).toList();
  }

  @override
  Future<SosChatMessage> sendMessage(String sosId, String body) async {
    if (sendFailure != null) throw sendFailure!;
    return _message(99, isMine: true);
  }

  @override
  Future<ResponderState> fetchResponderState(String sosId) =>
      throw UnimplementedError();
}

ProviderContainer _containerWith(_FakeSosChatRepository repository) {
  final container = ProviderContainer(
    overrides: [
      getSosChatMessagesUseCaseProvider
          .overrideWithValue(GetSosChatMessagesUseCase(repository)),
      sendSosChatMessageUseCaseProvider
          .overrideWithValue(SendSosChatMessageUseCase(repository)),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('loads existing messages when the chat opens', () async {
    final container = _containerWith(
      _FakeSosChatRepository(serverMessages: [_message(1), _message(2)]),
    );
    container.listen(sosChatControllerProvider('sos1'), (_, __) {});

    await Future<void>.delayed(Duration.zero);

    expect(container.read(sosChatControllerProvider('sos1')).messages, hasLength(2));
  });

  test('a sent message is appended once', () async {
    final container = _containerWith(_FakeSosChatRepository());
    container.listen(sosChatControllerProvider('sos1'), (_, __) {});
    final controller = container.read(sosChatControllerProvider('sos1').notifier);

    await controller.send('  hi  ');
    await controller.send('   '); // blank: ignored

    final chat = container.read(sosChatControllerProvider('sos1'));
    expect(chat.messages, hasLength(1));
    expect(chat.isSending, isFalse);
  });

  test('403 / 409 closes the conversation and blocks further sends', () async {
    final container = _containerWith(
      _FakeSosChatRepository(
        sendFailure: const AppFailure(message: 'Resolved', statusCode: 409),
      ),
    );
    container.listen(sosChatControllerProvider('sos1'), (_, __) {});
    final controller = container.read(sosChatControllerProvider('sos1').notifier);

    await controller.send('anyone there?');

    final chat = container.read(sosChatControllerProvider('sos1'));
    expect(chat.isClosed, isTrue);
    expect(chat.errorMessage, 'Resolved');
  });

  test('a network error keeps the chat open', () async {
    final container = _containerWith(
      _FakeSosChatRepository(
        sendFailure: const AppFailure(message: 'No internet connection.'),
      ),
    );
    container.listen(sosChatControllerProvider('sos1'), (_, __) {});

    await container.read(sosChatControllerProvider('sos1').notifier).send('hi');

    expect(container.read(sosChatControllerProvider('sos1')).isClosed, isFalse);
  });
}
