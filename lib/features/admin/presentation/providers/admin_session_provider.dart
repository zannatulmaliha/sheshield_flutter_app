import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/admin/domain/usecases/clear_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/get_report_queue_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/has_admin_key_usecase.dart';
import 'package:sheshield/features/admin/domain/usecases/save_admin_key_usecase.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_use_case_providers.dart';

part 'admin_session_provider.g.dart';

/// Whether an operator key is stored AND was accepted by the server.
@Riverpod(keepAlive: true)
class AdminSessionController extends _$AdminSessionController {
  late final HasAdminKeyUseCase _hasAdminKey = ref.read(hasAdminKeyUseCaseProvider);
  late final SaveAdminKeyUseCase _saveAdminKey = ref.read(saveAdminKeyUseCaseProvider);
  late final ClearAdminKeyUseCase _clearAdminKey =
      ref.read(clearAdminKeyUseCaseProvider);
  late final GetReportQueueUseCase _getReportQueue =
      ref.read(getReportQueueUseCaseProvider);

  @override
  bool build() {
    // Restore a previously stored key without blocking build().
    _hasAdminKey().then((hasKey) {
      if (hasKey) state = true;
    });
    return false;
  }

  /// Stores [key] and verifies it by loading the queue. A rejected key is
  /// removed again, so a key that doesn't work is never left stored.
  /// Throws [AppFailure] when the server rejects it.
  Future<void> signIn(String key) async {
    await _saveAdminKey(key);
    try {
      await _getReportQueue(forceRefresh: true);
      state = true;
    } on AppFailure {
      await _clearAdminKey();
      state = false;
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _clearAdminKey();
    state = false;
  }
}
