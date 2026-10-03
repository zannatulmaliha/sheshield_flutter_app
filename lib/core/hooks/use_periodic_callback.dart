import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Calls [callback] every [interval] while the widget is mounted and
/// [enabled]. Replaces a hand-managed `Timer?` + `initState` + `dispose`.
/// The latest [callback] is always the one invoked, so it may capture
/// values from the current build.
void usePeriodicCallback(
  Duration interval,
  VoidCallback callback, {
  bool enabled = true,
}) {
  final latestCallback = useRef(callback)..value = callback;

  useEffect(() {
    if (!enabled) return null;
    final timer = Timer.periodic(interval, (_) => latestCallback.value());
    return timer.cancel;
  }, [interval, enabled],);
}
