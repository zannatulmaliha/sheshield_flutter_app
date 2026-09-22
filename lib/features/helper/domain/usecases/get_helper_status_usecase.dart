import '../entities/helper_status.dart';
import '../repositories/i_helper_repository.dart';

class GetHelperStatusUseCase {
  const GetHelperStatusUseCase(this._repository);
  final IHelperRepository _repository;

  Future<HelperStatus> call() => _repository.fetchStatus();
}
