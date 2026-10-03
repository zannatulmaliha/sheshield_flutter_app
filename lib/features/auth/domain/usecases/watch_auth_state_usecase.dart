import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';
import 'package:sheshield/shared/entities/app_user.dart';

/// Backs the router's redirect logic and any "is someone signed in" check:
/// the single source of truth for auth state in the whole app.
class WatchAuthStateUseCase {
  const WatchAuthStateUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Stream<AppUser?> call() => _authRepository.authStateChanges;
}
