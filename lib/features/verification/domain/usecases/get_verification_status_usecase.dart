import '../entities/verification_status.dart';
import '../repositories/i_verification_repository.dart';

class GetVerificationStatusUseCase {
  const GetVerificationStatusUseCase(this._repository);
  final IVerificationRepository _repository;

  Future<VerificationStatus> call() => _repository.fetchStatus();
}