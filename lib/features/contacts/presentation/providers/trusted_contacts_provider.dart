import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/domain/usecases/add_contact_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_trusted_contacts_usecase.dart';
import 'package:sheshield/features/contacts/domain/usecases/remove_contact_usecase.dart';
import 'package:sheshield/features/contacts/presentation/providers/contacts_use_case_providers.dart';

part 'trusted_contacts_provider.g.dart';

/// Owns the trusted-contacts list for Home and the Contacts tab alike, so
/// adding or removing on one screen updates the other with no manual
/// refresh. Methods throw [AppFailure]; the calling widget shows it.
@riverpod
class TrustedContactsController extends _$TrustedContactsController {
  late final GetTrustedContactsUseCase _getTrustedContacts =
      ref.read(getTrustedContactsUseCaseProvider);
  late final AddContactUseCase _addContact = ref.read(addContactUseCaseProvider);
  late final RemoveContactUseCase _removeContact =
      ref.read(removeContactUseCaseProvider);

  @override
  Future<List<TrustedContact>> build() => _getTrustedContacts();

  List<TrustedContact> get _currentContacts =>
      state.valueOrNull ?? const <TrustedContact>[];

  Future<void> addContact({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) async {
    final createdContact = await _addContact(
      name: name,
      relation: relation,
      phone: phone,
      countryCode: countryCode,
    );
    state = AsyncData([..._currentContacts, createdContact]);
  }

  /// Removes optimistically so the tile disappears at once; restores the
  /// list and rethrows if the server rejects the removal.
  Future<void> removeContact(String contactId) async {
    final contactsBeforeRemoval = _currentContacts;
    state = AsyncData(
      contactsBeforeRemoval.where((contact) => contact.id != contactId).toList(),
    );
    try {
      await _removeContact(contactId);
    } catch (_) {
      state = AsyncData(contactsBeforeRemoval);
      rethrow;
    }
  }
}
