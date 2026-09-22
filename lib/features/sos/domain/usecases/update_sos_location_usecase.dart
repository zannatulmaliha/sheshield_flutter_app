import '../repositories/i_sos_repository.dart';

class UpdateSosLocationUseCase {
  const UpdateSosLocationUseCase(this._repository);
  final ISosRepository _repository;

  Future<void> call({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracyMeters,
  }) =>
      _repository.updateLocation(
        alertId: alertId,
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: accuracyMeters,
      );
}
