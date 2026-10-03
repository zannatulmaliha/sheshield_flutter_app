import 'package:sheshield/features/sos/domain/entities/sos_alert.dart';
import 'package:sheshield/features/sos/domain/repositories/sos_repository.dart';

class SendSosUseCase {
  const SendSosUseCase(this._sosRepository);

  final SosRepository _sosRepository;

  Future<SosAlert> call({
    required double latitude,
    required double longitude,
    double? accuracyMeters,
    List<String> notifiedByDevice = const [],
    bool avConsent = false,
    String trigger = 'manual',
  }) =>
      _sosRepository.sendAlert(
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: accuracyMeters,
        notifiedByDevice: notifiedByDevice,
        avConsent: avConsent,
        trigger: trigger,
      );
}
