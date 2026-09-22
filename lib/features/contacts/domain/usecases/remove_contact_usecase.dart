import '../repositories/i_contacts_repository.dart';

class RemoveContactUseCase {
  const RemoveContactUseCase(this._repository);
  final IContactsRepository _repository;

  Future<void> call(String contactId) => _repository.remove(contactId);
}