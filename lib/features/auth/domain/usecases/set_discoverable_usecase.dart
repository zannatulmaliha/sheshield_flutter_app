import '../repositories/i_auth_repository.dart';

class SetDiscoverableUseCase {
  const SetDiscoverableUseCase(this._repository);
  final IAuthRepository _repository;

  Future<void> call(bool discoverable) => _repository.setDiscoverable(discoverable);
}
