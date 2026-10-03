import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/domain/repositories/contacts_repository.dart';

class GetTrustedContactsUseCase {
  const GetTrustedContactsUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<List<TrustedContact>> call() => _contactsRepository.fetchContacts();
}
