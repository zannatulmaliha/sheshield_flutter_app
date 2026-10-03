import 'package:sheshield/features/contacts/domain/entities/contact_invite.dart';
import 'package:sheshield/features/contacts/domain/repositories/contacts_repository.dart';

class InviteContactUseCase {
  const InviteContactUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<ContactInvite> call(String contactId) =>
      _contactsRepository.createInvite(contactId);
}
