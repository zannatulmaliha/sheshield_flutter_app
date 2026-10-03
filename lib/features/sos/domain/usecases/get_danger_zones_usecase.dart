import 'package:sheshield/features/sos/domain/entities/danger_zone.dart';
import 'package:sheshield/features/sos/domain/repositories/sos_repository.dart';

class GetDangerZonesUseCase {
  const GetDangerZonesUseCase(this._sosRepository);

  final SosRepository _sosRepository;

  Future<List<DangerZone>> call({required double latitude, required double longitude}) =>
      _sosRepository.fetchDangerZones(latitude: latitude, longitude: longitude);
}
