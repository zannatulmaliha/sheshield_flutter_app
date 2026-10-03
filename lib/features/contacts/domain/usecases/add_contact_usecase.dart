import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/domain/repositories/contacts_repository.dart';

class AddContactUseCase {
  const AddContactUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<TrustedContact> call({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) =>
      _contactsRepository.addContact(
        name: name,
        relation: relation,
        phone: phone,
        countryCode: countryCode,
      );
}
