import '../entities/contact_invite.dart';
import '../repositories/i_contacts_repository.dart';

class InviteContactUseCase {
  const InviteContactUseCase(this._repository);
  final IContactsRepository _repository;

  Future<ContactInvite> call(String contactId) => _repository.invite(contactId);
}
