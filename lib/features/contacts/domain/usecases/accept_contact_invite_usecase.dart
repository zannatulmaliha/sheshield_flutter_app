import 'package:sheshield/features/contacts/domain/repositories/contacts_repository.dart';

class AcceptContactInviteUseCase {
  const AcceptContactInviteUseCase(this._contactsRepository);

  final ContactsRepository _contactsRepository;

  Future<void> call(String code) => _contactsRepository.acceptInvite(code);
}
