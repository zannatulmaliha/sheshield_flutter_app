import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/features/contacts/domain/entities/contact_invite.dart';
import 'package:sheshield/features/contacts/presentation/providers/contacts_use_case_providers.dart';

part 'contact_invite_provider.g.dart';

/// A fresh invite code for one contact. Auto-disposed, so every time the
/// invite dialog opens it asks the server for a new code.
@riverpod
class ContactInviteController extends _$ContactInviteController {
  @override
  Future<ContactInvite> build(String contactId) {
    final inviteContact = ref.read(inviteContactUseCaseProvider);
    return inviteContact(contactId);
  }
}
