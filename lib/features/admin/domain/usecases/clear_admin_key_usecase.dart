import 'package:sheshield/features/admin/domain/repositories/admin_repository.dart';

class ClearAdminKeyUseCase {
  const ClearAdminKeyUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<void> call() => _adminRepository.clearAdminKey();
}
