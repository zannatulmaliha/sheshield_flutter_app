import 'package:sheshield/shared/entities/app_user.dart';
import '../repositories/i_auth_repository.dart';

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);
  final IAuthRepository _repository;

  Future<AppUser> call({
    String? name,
    String? phone,
    String? countryCode,
    String? address,
  }) =>
      _repository.updateProfile(
        name: name,
        phone: phone,
        countryCode: countryCode,
        address: address,
      );
}