import '../repositories/i_admin_repository.dart';

class ClearAdminKeyUseCase {
  const ClearAdminKeyUseCase(this._repository);
  final IAdminRepository _repository;

  Future<void> call() => _repository.clearAdminKey();
}
