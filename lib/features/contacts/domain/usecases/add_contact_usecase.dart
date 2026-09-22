import '../entities/trusted_contact.dart';
import '../repositories/i_contacts_repository.dart';

class AddContactUseCase {
  const AddContactUseCase(this._repository);
  final IContactsRepository _repository;

  Future<TrustedContact> call({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) =>
      _repository.add(
        name: name,
        relation: relation,
        phone: phone,
        countryCode: countryCode,
      );
}