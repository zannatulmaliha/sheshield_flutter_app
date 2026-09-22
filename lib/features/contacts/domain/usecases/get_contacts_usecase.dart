import '../entities/trusted_contact.dart';
import '../repositories/i_contacts_repository.dart';

class GetContactsUseCase {
  const GetContactsUseCase(this._repository);
  final IContactsRepository _repository;

  Future<List<TrustedContact>> call() => _repository.list();
}