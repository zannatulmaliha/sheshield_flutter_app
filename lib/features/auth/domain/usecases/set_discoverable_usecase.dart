import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';

class SetDiscoverableUseCase {
  const SetDiscoverableUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> call(bool discoverable) => _authRepository.setDiscoverable(discoverable);
}
