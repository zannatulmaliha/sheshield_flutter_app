import '../repositories/i_auth_repository.dart';

/// Re-fetches the signed-in user from the server (e.g. after an admin
/// approves a helper's verification) and pushes it onto [authStateProvider].
class RefreshSessionUseCase {
  const RefreshSessionUseCase(this._repository);
  final IAuthRepository _repository;

  Future<void> call() => _repository.refreshSession();
}