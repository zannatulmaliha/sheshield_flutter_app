import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Counts down from [seconds] once per second while [isRunning], calling
/// [onFinished] when it reaches zero. Returns the seconds left. Turning
/// [isRunning] off cancels the timer and resets the count.
int useCountdown({
  required int seconds,
  required bool isRunning,
  required VoidCallback onFinished,
}) {
  final secondsLeft = useState(seconds);
  final latestOnFinished = useRef(onFinished)..value = onFinished;

  useEffect(() {
    secondsLeft.value = seconds;
    if (!isRunning) return null;

    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value <= 1) {
        timer.cancel();
        latestOnFinished.value();
        return;
      }
      secondsLeft.value -= 1;
    });
    return timer.cancel;
  }, [isRunning, seconds],);

  return secondsLeft.value;
}
