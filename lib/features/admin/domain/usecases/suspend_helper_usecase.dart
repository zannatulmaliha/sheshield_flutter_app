import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class SuspendHelperUseCase {
  const SuspendHelperUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<String?> call({
    required String uid,
    required String reason,
    String? reviewerName,
  }) =>
      _adminRepository.suspendHelper(
        uid: uid,
        reason: reason,
        reviewerName: reviewerName,
      );
}
