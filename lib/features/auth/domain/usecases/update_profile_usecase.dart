import 'package:sheshield/features/auth/domain/repositories/auth_repository.dart';
import 'package:sheshield/shared/entities/app_user.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<AppUser> call({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) =>
      _authRepository.updateProfile(
        name: name,
        phone: phone,
        countryCode: countryCode,
        address: address,
      );
}
