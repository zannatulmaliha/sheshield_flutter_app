import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class SaveAdminKeyUseCase {
  const SaveAdminKeyUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<void> call(String key) => _adminRepository.saveAdminKey(key);
}
