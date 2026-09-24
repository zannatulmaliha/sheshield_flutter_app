import '../repositories/i_admin_repository.dart';

class SuspendHelperUseCase {
  const SuspendHelperUseCase(this._repository);
  final IAdminRepository _repository;

  Future<String?> call({
    required String uid,
    required String reason,
    String? reviewerName,
  }) =>
      _repository.suspendHelper(
          uid: uid, reason: reason, reviewerName: reviewerName);
}
