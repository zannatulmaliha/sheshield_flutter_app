import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class GetVerificationQueueUseCase {
  const GetVerificationQueueUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<List<AdminVerification>> call() =>
      _adminRepository.fetchVerificationQueue();
}
