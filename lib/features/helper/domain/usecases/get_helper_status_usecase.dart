import 'package:sheshield/features/helper/domain/entities/helper_status.dart';
import 'package:sheshield/features/helper/domain/repositories/helper_status_repository.dart';

class GetHelperStatusUseCase {
  const GetHelperStatusUseCase(this._helperStatusRepository);

  final HelperStatusRepository _helperStatusRepository;

  Future<HelperStatus> call() => _helperStatusRepository.fetchStatus();
}
