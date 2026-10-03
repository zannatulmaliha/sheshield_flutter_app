import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';
import 'package:sheshield/features/helper/domain/usecases/get_live_state_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/release_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/resolve_alert_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_response_stage_usecase.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_activity_providers.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_response_state.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_use_case_providers.dart';

part 'helper_response_provider.g.dart';

const _pollInterval = Duration(seconds: 5);

/// 403 / 409: the server says this helper no longer holds the alert.
const _lockLostStatusCodes = {403, 409};

/// Everything about one held alert: polls `GET /helper/alerts/{id}/live`
/// (the server is the authority; after it resolves or the lock is lost the
/// live call stops returning coordinates), tracks the stage, and performs
/// stage / resolve / back-out. Action methods throw `AppFailure`; the
/// widget shows it.
@riverpod
class HelperResponseController extends _$HelperResponseController {
  late final GetLiveStateUseCase _getLiveState = ref.read(getLiveStateUseCaseProvider);
  late final SetResponseStageUseCase _setResponseStage =
      ref.read(setResponseStageUseCaseProvider);
  late final ResolveAlertUseCase _resolveAlert = ref.read(resolveAlertUseCaseProvider);
  late final ReleaseAlertUseCase _releaseAlert = ref.read(releaseAlertUseCaseProvider);

  Timer? _pollTimer;
  bool _isDisposed = false;

  @override
  HelperResponseState build(String alertId, ResponseStage initialStage) {
    _isDisposed = false;
    _pollTimer = Timer.periodic(_pollInterval, (_) => _pollLiveState());
    ref.onDispose(() {
      _isDisposed = true;
      _pollTimer?.cancel();
    });
    // After build returns, so `state` is initialised by the first poll.
    Future.microtask(_pollLiveState);
    return HelperResponseState(stage: initialStage);
  }

  Future<void> _pollLiveState() async {
    if (state.ended != null) return;
    try {
      final liveState = await _getLiveState(alertId);
      if (_isDisposed || state.ended != null) return;

      final furtherStage =
          liveState.stage.hasReached(state.stage) ? liveState.stage : state.stage;
      state = state.copyWith(live: liveState, stage: furtherStage);

      if (!liveState.isOpen) {
        _finish(
          liveState.endedByRequester
              ? HelperResponseEnd.requesterMarkedSafe
              : HelperResponseEnd.notAssignedAnymore,
        );
      }
    } on AppFailure catch (failure) {
      // Any other failure is just a missed poll.
      if (_lockLostStatusCodes.contains(failure.statusCode) && !_isDisposed) {
        _finish(HelperResponseEnd.notAssignedAnymore);
      }
    }
  }

  /// Moves forward only: going back to an earlier stage is ignored.
  Future<void> setStage(ResponseStage nextStage) async {
    if (state.stage.hasReached(nextStage)) return;
    await _setResponseStage(alertId, nextStage);
    if (!_isDisposed) state = state.copyWith(stage: nextStage);
  }

  Future<void> resolve() async {
    await _resolveAlert(alertId);
    _finish(HelperResponseEnd.resolvedByHelper);
  }

  /// "Can't help": hands the alert back to the other nearby helpers.
  Future<void> backOut() async {
    await _releaseAlert(alertId);
    _finish(HelperResponseEnd.backedOut);
  }

  void _finish(HelperResponseEnd reason) {
    if (_isDisposed || state.ended != null) return;
    _pollTimer?.cancel();
    state = state.copyWith(ended: reason);
    // Whatever just ended changes the dashboard numbers and history too.
    ref
      ..invalidate(myResponseProvider)
      ..invalidate(helperStatsProvider)
      ..invalidate(helperHistoryProvider);
  }
}
