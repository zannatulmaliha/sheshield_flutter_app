import '../repositories/i_admin_repository.dart';

class HasAdminKeyUseCase {
  const HasAdminKeyUseCase(this._repository);
  final IAdminRepository _repository;

  Future<bool> call() => _repository.hasAdminKey();
}
