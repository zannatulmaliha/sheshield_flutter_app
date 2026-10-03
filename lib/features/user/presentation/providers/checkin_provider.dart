import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';
import 'package:sheshield/features/user/presentation/providers/checkin_state.dart';

export 'package:sheshield/features/user/presentation/providers/checkin_state.dart';

part 'checkin_provider.g.dart';

const _tickInterval = Duration(seconds: 1);

/// A safety countdown the person sets before doing something risky (walking
/// home alone, meeting a stranger, ...). If it reaches zero without them
/// checking in, an SOS goes out on their behalf via `SosController.send`:
/// the exact same alert (live location + every trusted contact) a manual SOS
/// press triggers.
///
/// Ticks once a second with a plain [Timer], which only fires while this app
/// process is alive. There is deliberately no WorkManager/AlarmManager
/// background service behind it yet, so a fully backgrounded (and especially
/// a killed) app will NOT fire the automatic SOS. Good enough for "I forgot
/// to check in while the app was open"; not a substitute for an OS-level
/// background timer.
@riverpod
class CheckInController extends _$CheckInController {
  Timer? _ticker;

  @override
  CheckInState build() {
    ref.onDispose(() => _ticker?.cancel());
    return const CheckInState();
  }

  void start(Duration duration) {
    _ticker?.cancel();
    final totalSeconds = duration.inSeconds;
    state = CheckInState(
      status: CheckInStatus.running,
      totalSeconds: totalSeconds,
      remainingSeconds: totalSeconds,
    );
    _ticker = Timer.periodic(_tickInterval, (_) => _tick());
  }

  Future<void> _tick() async {
    final remainingSeconds = state.remainingSeconds - 1;
    if (remainingSeconds > 0) {
      state = state.copyWith(remainingSeconds: remainingSeconds);
      return;
    }

    _ticker?.cancel();
    state = state.copyWith(remainingSeconds: 0);
    await ref.read(sosControllerProvider.notifier).send();
    state = state.copyWith(status: CheckInStatus.sosSent);
  }

  /// "I'm safe": stops the countdown before it reaches zero. No SOS is sent.
  void checkIn() {
    _ticker?.cancel();
    state = const CheckInState();
  }

  /// Dismisses the "SOS sent" banner after an automatic trigger.
  void dismiss() => state = const CheckInState();
}
