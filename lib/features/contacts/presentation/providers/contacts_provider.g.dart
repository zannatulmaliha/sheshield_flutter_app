// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contactsControllerHash() =>
    r'25fb3e45c9b3462acb92dab510e8483708fb5b54';

/// Owns the trusted-contacts list for Home and the Contacts tab alike
/// -- both watch this single provider, so adding/removing a contact
/// on one screen updates the other without any manual refresh call.
///
/// Copied from [ContactsController].
@ProviderFor(ContactsController)
final contactsControllerProvider = AutoDisposeAsyncNotifierProvider<
    ContactsController, List<TrustedContact>>.internal(
  ContactsController.new,
  name: r'contactsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contactsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ContactsController = AutoDisposeAsyncNotifier<List<TrustedContact>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
