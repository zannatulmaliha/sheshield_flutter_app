import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class GetVerificationDetailUseCase {
  const GetVerificationDetailUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<AdminVerification> call(String verificationId) =>
      _adminRepository.fetchVerificationDetail(verificationId);
}
