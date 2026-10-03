import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

class AcceptAlertUseCase {
  const AcceptAlertUseCase(this._helperAlertRepository);

  final HelperAlertRepository _helperAlertRepository;

  /// A null result means another helper won the race. Pure Dart, so the
  /// "exactly one must win" scenario is testable with a fake repository.
  Future<AcceptedAlert?> call(String alertId) =>
      _helperAlertRepository.acceptAlert(alertId);
}
