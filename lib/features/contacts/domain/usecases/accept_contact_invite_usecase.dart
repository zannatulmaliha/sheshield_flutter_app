import '../repositories/i_contacts_repository.dart';

class AcceptContactInviteUseCase {
  const AcceptContactInviteUseCase(this._repository);
  final IContactsRepository _repository;

  Future<void> call(String code) => _repository.acceptInvite(code);
}
