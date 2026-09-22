import '../repositories/i_auth_repository.dart';

class UpdateFcmTokenUseCase {
  const UpdateFcmTokenUseCase(this._repository);
  final IAuthRepository _repository;

  Future<void> call(String token) => _repository.updateFcmToken(token);
}
