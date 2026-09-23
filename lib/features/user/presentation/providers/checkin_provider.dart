import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';

part 'checkin_provider.g.dart';

enum CheckInStatus {
  /// No countdown running.
  idle,

  /// Counting down; the person can still [CheckInController.checkIn] to
  /// stop it before it reaches zero.
  running,

  /// The countdown reached zero and an SOS was sent automatically.
  sosSent,
}

class CheckInState {
  const CheckInState({
    this.status = CheckInStatus.idle,
    this.totalSeconds = 0,
    this.remainingSeconds = 0,
  });

  final CheckInStatus status;
  final int totalSeconds;
  final int remainingSeconds;

  /// 0.0 (just started) to 1.0 (about to fire), for a progress indicator.
  double get progress =>
      totalSeconds == 0 ? 0 : 1 - (remainingSeconds / totalSeconds);

  CheckInState copyWith({
    CheckInStatus? status,
    int? totalSeconds,
    int? remainingSeconds,
  }) =>
      CheckInState(
        status: status ?? this.status,
        totalSeconds: totalSeconds ?? this.totalSeconds,
        remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      );
}

/// A safety countdown the person sets before doing something risky (walking
/// home alone, meeting a stranger, ...). If it reaches zero without them
/// checking in, an SOS goes out on their behalf via [SosController.send] --
/// the exact same alert (live location + every trusted contact) a manual SOS
/// press triggers.
///
/// Ticks once a second with a plain [Timer], which only ever fires while
/// this app process is alive and in the foreground. There is deliberately
/// no WorkManager/AlarmManager-backed background service behind it yet, so
/// a fully backgrounded (and especially a killed) app will NOT fire the
/// automatic SOS -- the same class of limitation already called out for
/// [PushService] on this codebase's MIUI test devices. Good enough for "I
/// forgot to check in while the app was open"; not yet a substitute for a
/// true OS-level background timer.
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
    final total = duration.inSeconds;
    state = CheckInState(
      status: CheckInStatus.running,
      totalSeconds: total,
      remainingSeconds: total,
    );

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  Future<void> _tick() async {
    final remaining = state.remainingSeconds - 1;
    if (remaining > 0) {
      state = state.copyWith(remainingSeconds: remaining);
      return;
    }

    _ticker?.cancel();
    state = state.copyWith(remainingSeconds: 0);
    await ref.read(sosControllerProvider.notifier).send();
    state = state.copyWith(status: CheckInStatus.sosSent);
  }

  /// "I'm safe" -- stops the countdown before it reaches zero. No SOS is
  /// sent.
  void checkIn() {
    _ticker?.cancel();
    state = const CheckInState();
  }

  /// Dismisses the "SOS sent" banner after an automatic trigger, once the
  /// person has seen it.
  void dismiss() {
    state = const CheckInState();
  }
}
