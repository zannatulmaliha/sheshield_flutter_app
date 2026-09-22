import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/domain/repositories/i_contacts_repository.dart';
import 'package:sheshield/features/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/remove_contact_usecase.dart';

part 'contacts_provider.g.dart';

/// Owns the trusted-contacts list for Home and the Contacts tab alike
/// -- both watch this single provider, so adding/removing a contact
/// on one screen updates the other without any manual refresh call.
@riverpod
class ContactsController extends _$ContactsController {
  @override
  Future<List<TrustedContact>> build() => getIt<GetContactsUseCase>().call();

  /// Returns null on success, or a message to show the user (e.g. the
  /// server's own "You can add up to 10 trusted contacts.").
  Future<String?> add({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) async {
    final previous = state.valueOrNull ?? const <TrustedContact>[];
    state = const AsyncLoading<List<TrustedContact>>().copyWithPrevious(state);
    try {
      final created = await getIt<AddContactUseCase>().call(
        name: name,
        relation: relation,
        phone: phone,
        countryCode: countryCode,
      );
      state = AsyncData([...previous, created]);
      return null;
    } on ContactsFailure catch (e) {
      state = AsyncData(previous);
      return e.message;
    }
  }

  /// Removes optimistically so the tile disappears immediately; rolls
  /// back and returns a message if the server rejects it.
  Future<String?> remove(String contactId) async {
    final previous = state.valueOrNull ?? const <TrustedContact>[];
    state = AsyncData(previous.where((c) => c.id != contactId).toList());
    try {
      await getIt<RemoveContactUseCase>().call(contactId);
      return null;
    } on ContactsFailure catch (e) {
      state = AsyncData(previous);
      return e.message;
    }
  }
}