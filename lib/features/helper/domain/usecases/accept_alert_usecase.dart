import '../entities/accepted_alert.dart';
import '../repositories/i_helper_repository.dart';

class AcceptAlertUseCase {
  const AcceptAlertUseCase(this._repository);
  final IHelperRepository _repository;

  /// Null return means another helper won the race -- pure Dart,
  /// testable with a fake [IHelperRepository] and no server involved,
  /// which is exactly where the "exactly one must win" scenario should
  /// be exercised on the Flutter side.
  Future<AcceptedAlert?> call(String alertId) => _repository.accept(alertId);
}
