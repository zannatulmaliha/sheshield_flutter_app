import 'package:sheshield/features/helper/domain/entities/helper_status.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_status_repository.dart';

class SetHelperStatusUseCase {
  const SetHelperStatusUseCase(this._helperStatusRepository);

  final HelperStatusRepository _helperStatusRepository;

  Future<HelperStatus> call({
    required bool isActive,
    required double radiusKm,
    double? latitude,
    double? longitude,
    bool mutualConnectionOptIn = false,
  }) =>
      _helperStatusRepository.setStatus(
        isActive: isActive,
        radiusKm: radiusKm,
        latitude: latitude,
        longitude: longitude,
        mutualConnectionOptIn: mutualConnectionOptIn,
      );
}
