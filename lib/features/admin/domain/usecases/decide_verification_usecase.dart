import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class DecideVerificationUseCase {
  const DecideVerificationUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<void> call({
    required String verificationId,
    required bool approved,
    String note = '',
    String? reviewerName,
  }) =>
      _adminRepository.decideVerification(
        verificationId: verificationId,
        approved: approved,
        note: note,
        reviewerName: reviewerName,
      );
}
