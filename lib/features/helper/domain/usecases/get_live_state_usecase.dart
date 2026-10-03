import 'package:sheshield/features/helper/domain/entities/live_state.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_alert_repository.dart';

class GetLiveStateUseCase {
  const GetLiveStateUseCase(this._helperAlertRepository);

  final HelperAlertRepository _helperAlertRepository;

  Future<LiveState> call(String alertId) =>
      _helperAlertRepository.fetchLiveState(alertId);
}
