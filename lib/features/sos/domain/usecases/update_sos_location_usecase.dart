import 'package:sheshield/features/sos/domain/repositories/sos_repository.dart';

class UpdateSosLocationUseCase {
  const UpdateSosLocationUseCase(this._sosRepository);

  final SosRepository _sosRepository;

  Future<void> call({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracyMeters,
  }) =>
      _sosRepository.updateAlertLocation(
        alertId: alertId,
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: accuracyMeters,
      );
}
