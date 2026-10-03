import 'package:sheshield/features/helper/domain/entities/my_response.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

class GetCurrentResponseUseCase {
  const GetCurrentResponseUseCase(this._helperAlertRepository);

  final HelperAlertRepository _helperAlertRepository;

  Future<MyResponse?> call() => _helperAlertRepository.fetchCurrentResponse();
}
