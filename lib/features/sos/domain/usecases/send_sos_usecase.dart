import '../entities/sos_alert.dart';
import '../repositories/i_sos_repository.dart';

class SendSosUseCase {
  const SendSosUseCase(this._repository);
  final ISosRepository _repository;

  Future<SosAlert> call({
    required double latitude,
    required double longitude,
    double? accuracyMeters,
    List<String> notifiedByDevice = const [],
    bool avConsent = false,
  }) =>
      _repository.send(
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: accuracyMeters,
        notifiedByDevice: notifiedByDevice,
        avConsent: avConsent,
      );
}