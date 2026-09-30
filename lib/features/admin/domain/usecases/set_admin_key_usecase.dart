import '../repositories/i_admin_repository.dart';

class SetAdminKeyUseCase {
  const SetAdminKeyUseCase(this._repository);
  final IAdminRepository _repository;

  Future<void> call(String key) => _repository.setAdminKey(key);
}
