import 'package:sheshield/features/contacts/domain/entities/contact_invite.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';

/// Contract the presentation layer depends on. No Dio type appears here;
/// the data layer throws `AppFailure` for every transport error.
abstract interface class ContactsRepository {
  Future<List<TrustedContact>> fetchContacts();

  Future<TrustedContact> addContact({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  });

  Future<void> removeContact(String contactId);

  /// Issues a fresh invite code for one of the caller's own contacts so
  /// they can link their account and get an alarm push, not just an SMS.
  Future<ContactInvite> createInvite(String contactId);

  /// Redeems a code someone else's invite produced, linking the CALLER's
  /// account as that contact (the invitee's side).
  Future<void> acceptInvite(String code);
}
