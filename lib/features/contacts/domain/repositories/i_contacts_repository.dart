import '../entities/trusted_contact.dart';

/// Contract the presentation layer depends on. No Dio type appears
/// here -- data/ translates transport errors into [ContactsFailure].
abstract class IContactsRepository {
  Future<List<TrustedContact>> list();

  Future<TrustedContact> add({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  });

  Future<void> remove(String contactId);
}

class ContactsFailure implements Exception {
  const ContactsFailure(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}