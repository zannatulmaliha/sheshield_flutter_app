import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/chat/domain/entities/responder_state.dart';
import 'package:sheshield/features/chat/domain/usecases/get_responder_state_usecase.dart';
import 'package:sheshield/features/chat/presentation/providers/chat_use_case_providers.dart';

part 'responder_state_provider.g.dart';

const _pollInterval = Duration(seconds: 4);

/// Has a helper accepted this SOS yet, and how far along are they? Polls
/// while something is watching it (auto-disposed). `null` until the first
/// answer arrives. A failed poll is not fatal: the next tick tries again.
@riverpod
class ResponderStateController extends _$ResponderStateController {
  late final GetResponderStateUseCase _getResponderState =
      ref.read(getResponderStateUseCaseProvider);

  bool _isDisposed = false;

  @override
  ResponderState? build(String sosId) {
    _isDisposed = false;
    final pollTimer = Timer.periodic(_pollInterval, (_) => _fetch());
    ref.onDispose(() {
      _isDisposed = true;
      pollTimer.cancel();
    });
    Future.microtask(_fetch);
    return null;
  }

  Future<void> _fetch() async {
    try {
      final latest = await _getResponderState(sosId);
      if (!_isDisposed) state = latest;
    } on AppFailure {
      // next tick
    }
  }
}
