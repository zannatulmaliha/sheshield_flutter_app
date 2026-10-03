import 'package:sheshield/features/contacts/domain/repositories/contacts_repository.dart';

class RemoveContactUseCase {
  const RemoveContactUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<void> call(String contactId) => _contactsRepository.removeContact(contactId);
}
