import '../entities/contact_invite.dart';
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

  /// Issues a fresh invite code for one of the caller's own contacts, so
  /// that contact can link their own SheShield account and receive an
  /// alarm push (not just SMS) on this user's next SOS.
  Future<ContactInvite> invite(String contactId);

  /// Redeems a code someone else's [invite] produced, linking the CALLER's
  /// account as that contact. Called from the invitee's side, not the
  /// contact owner's.
  Future<void> acceptInvite(String code);
}

class ContactsFailure implements Exception {
  const ContactsFailure(this.message, {this.unauthorized = false});
  final String message;
  final bool unauthorized;

  @override
  String toString() => message;
}