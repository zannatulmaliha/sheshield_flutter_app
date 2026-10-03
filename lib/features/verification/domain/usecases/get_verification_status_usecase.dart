import 'package:sheshield/features/verification/domain/entities/verification_status.dart';
import 'package:sheshield/features/verification/domain/repositories/verification_repository.dart';

class GetVerificationStatusUseCase {
  const GetVerificationStatusUseCase(this._verificationRepository);

  final VerificationRepository _verificationRepository;

  Future<VerificationStatus> call() =>
      _verificationRepository.fetchVerificationStatus();
}
