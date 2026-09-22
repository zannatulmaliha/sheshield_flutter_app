import '../entities/helper_status.dart';
import '../repositories/i_helper_repository.dart';

class SetHelperStatusUseCase {
  const SetHelperStatusUseCase(this._repository);
  final IHelperRepository _repository;

  Future<HelperStatus> call({
    required bool isActive,
    required double radiusKm,
    double? latitude,
    double? longitude,
  }) {
    return _repository.setStatus(
      isActive: isActive,
      radiusKm: radiusKm,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
