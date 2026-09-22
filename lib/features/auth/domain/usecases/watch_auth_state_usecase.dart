import 'package:sheshield/shared/entities/app_user.dart';
import '../repositories/i_auth_repository.dart';

/// Backs the router's redirect logic and any "is someone logged in"
/// check — the single source of truth for auth state in the whole app.
class WatchAuthStateUseCase {
  const WatchAuthStateUseCase(this._repository);
  final IAuthRepository _repository;

  Stream<AppUser?> call() => _repository.authStateChanges;
}
