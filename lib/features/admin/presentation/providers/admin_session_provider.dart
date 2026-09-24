import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import '../../domain/repositories/i_admin_repository.dart';
import '../../domain/usecases/clear_admin_key_usecase.dart';
import '../../domain/usecases/get_report_queue_usecase.dart';
import '../../domain/usecases/has_admin_key_usecase.dart';
import '../../domain/usecases/set_admin_key_usecase.dart';

/// Whether an admin key is currently stored (and was accepted by the
/// server). Hand-written provider -- no build_runner / .g.dart needed.
final adminSessionControllerProvider =
    NotifierProvider<AdminSessionController, bool>(AdminSessionController.new);

class AdminSessionController extends Notifier<bool> {
  @override
  bool build() {
    // Restore a previously stored key without blocking build().
    getIt<HasAdminKeyUseCase>().call().then((has) {
      if (has) state = true;
    });
    return false;
  }

  /// Stores [key] and verifies it against the server by loading the queue.
  /// Returns null on success, or a user-facing error message. A rejected key
  /// is removed again, so a key that doesn't work is never left stored.
  Future<String?> signIn(String key) async {
    await getIt<SetAdminKeyUseCase>().call(key);
    try {
      await getIt<GetReportQueueUseCase>().call(forceRefresh: true);
      state = true;
      return null;
    } on AdminFailure catch (e) {
      await getIt<ClearAdminKeyUseCase>().call();
      state = false;
      return e.message;
    }
  }

  Future<void> signOut() async {
    await getIt<ClearAdminKeyUseCase>().call();
    state = false;
  }
}
