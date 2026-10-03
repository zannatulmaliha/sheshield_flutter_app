import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';

/// Re-fetches the signed-in user (e.g. after an admin approves a helper's
/// verification) and pushes it onto the auth state stream.
class RefreshSessionUseCase {
  const RefreshSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> call() => _authRepository.refreshSession();
}
