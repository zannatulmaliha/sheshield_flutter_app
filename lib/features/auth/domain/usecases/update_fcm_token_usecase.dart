import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';

class UpdateFcmTokenUseCase {
  const UpdateFcmTokenUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> call(String token) => _authRepository.updateFcmToken(token);
}
