import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/chat/domain/entities/sos_chat_message.dart';
import 'package:sheshield/features/chat/domain/usecases/get_sos_chat_messages_usecase.dart';
import 'package:sheshield/features/chat/domain/usecases/send_sos_chat_message_usecase.dart';
import 'package:sheshield/features/chat/presentation/providers/chat_use_case_providers.dart';
import 'package:sheshield/features/chat/presentation/providers/sos_chat_state.dart';

part 'sos_chat_provider.g.dart';

const _pollInterval = Duration(seconds: 3);

/// The server answers 403 / 409 once the alert is resolved or the helper
/// was released.
const _conversationClosedStatusCodes = {403, 409};

/// One SOS conversation. Polls while the screen is open (auto-disposed, so
/// polling stops when it closes) and owns every state change, so the widget
/// is pure presentation.
@riverpod
class SosChatController extends _$SosChatController {
  late final GetSosChatMessagesUseCase _getMessages =
      ref.read(getSosChatMessagesUseCaseProvider);
  late final SendSosChatMessageUseCase _sendMessage =
      ref.read(sendSosChatMessageUseCaseProvider);

  bool _isDisposed = false;

  @override
  SosChatState build(String sosId) {
    _isDisposed = false;
    final pollTimer = Timer.periodic(_pollInterval, (_) => _fetchNewMessages());
    ref.onDispose(() {
      _isDisposed = true;
      pollTimer.cancel();
    });
    // After build returns, so `state` is initialised by the first fetch.
    Future.microtask(_fetchNewMessages);
    return const SosChatState();
  }

  Future<void> _fetchNewMessages() async {
    if (state.isClosed) return;
    try {
      final freshMessages = await _getMessages(
        sosId,
        afterSequence: state.lastSequence,
      );
      if (_isDisposed || freshMessages.isEmpty) return;
      state = state.copyWith(
        messages: _mergeBySequence(state.messages, freshMessages),
        errorMessage: null,
      );
    } on AppFailure catch (failure) {
      if (!_isDisposed) _showFailure(failure);
    }
  }

  Future<void> send(String messageText) async {
    final body = messageText.trim();
    if (body.isEmpty || state.isSending || state.isClosed) return;

    state = state.copyWith(isSending: true);
    try {
      final sentMessage = await _sendMessage(sosId, body);
      if (_isDisposed) return;
      state = state.copyWith(
        messages: _mergeBySequence(state.messages, [sentMessage]),
        isSending: false,
        errorMessage: null,
      );
    } on AppFailure catch (failure) {
      if (_isDisposed) return;
      state = state.copyWith(isSending: false);
      _showFailure(failure);
    }
  }

  void _showFailure(AppFailure failure) {
    state = state.copyWith(
      errorMessage: failure.message,
      isClosed: _conversationClosedStatusCodes.contains(failure.statusCode),
    );
  }

  /// Adds only messages not already present (poll and send can race).
  List<SosChatMessage> _mergeBySequence(
    List<SosChatMessage> existing,
    List<SosChatMessage> incoming,
  ) {
    final knownSequences = existing.map((message) => message.sequence).toSet();
    return [
      ...existing,
      ...incoming.where((message) => !knownSequences.contains(message.sequence)),
    ];
  }
}
