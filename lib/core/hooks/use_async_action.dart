import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sheshield/core/error/app_failure.dart';

/// Tracks one user-triggered async operation (submit, save, delete...).
/// Replaces the hand-rolled `_loading` / `_error` / `mounted` + setState
/// trio that every dialog and sheet used to carry.
@immutable
class AsyncAction {
  const AsyncAction({
    required this.isRunning,
    required this.errorMessage,
    required this.run,
    required this.clearError,
  });

  final bool isRunning;
  final String? errorMessage;

  /// Runs [task]; returns true when it finished without an [AppFailure].
  /// [onFailure] receives the message (only while the widget is mounted),
  /// so callers never read a stale `errorMessage` after an `await`.
  final Future<bool> Function(
    Future<void> Function() task, {
    void Function(String message)? onFailure,
  }) run;
  final VoidCallback clearError;
}

AsyncAction useAsyncAction() {
  final isRunning = useState(false);
  final errorMessage = useState<String?>(null);
  final isMounted = useIsMounted();

  Future<bool> run(
    Future<void> Function() task, {
    void Function(String message)? onFailure,
  }) async {
    isRunning.value = true;
    errorMessage.value = null;
    try {
      await task();
      return true;
    } on AppFailure catch (failure) {
      if (isMounted()) {
        errorMessage.value = failure.message;
        onFailure?.call(failure.message);
      }
      return false;
    } finally {
      if (isMounted()) isRunning.value = false;
    }
  }

  return AsyncAction(
    isRunning: isRunning.value,
    errorMessage: errorMessage.value,
    run: run,
    clearError: () => errorMessage.value = null,
  );
}
