// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_invite_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contactInviteControllerHash() =>
    r'02ce8660171b61030ccd78c5adf845ee1e8c14c7';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ContactInviteController
    extends BuildlessAutoDisposeAsyncNotifier<ContactInvite> {
  late final String contactId;

  FutureOr<ContactInvite> build(
    String contactId,
  );
}

/// A fresh invite code for one contact. Auto-disposed, so every time the
/// invite dialog opens it asks the server for a new code.
///
/// Copied from [ContactInviteController].
@ProviderFor(ContactInviteController)
const contactInviteControllerProvider = ContactInviteControllerFamily();

/// A fresh invite code for one contact. Auto-disposed, so every time the
/// invite dialog opens it asks the server for a new code.
///
/// Copied from [ContactInviteController].
class ContactInviteControllerFamily extends Family<AsyncValue<ContactInvite>> {
  /// A fresh invite code for one contact. Auto-disposed, so every time the
  /// invite dialog opens it asks the server for a new code.
  ///
  /// Copied from [ContactInviteController].
  const ContactInviteControllerFamily();

  /// A fresh invite code for one contact. Auto-disposed, so every time the
  /// invite dialog opens it asks the server for a new code.
  ///
  /// Copied from [ContactInviteController].
  ContactInviteControllerProvider call(
    String contactId,
  ) {
    return ContactInviteControllerProvider(
      contactId,
    );
  }

  @override
  ContactInviteControllerProvider getProviderOverride(
    covariant ContactInviteControllerProvider provider,
  ) {
    return call(
      provider.contactId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'contactInviteControllerProvider';
}

/// A fresh invite code for one contact. Auto-disposed, so every time the
/// invite dialog opens it asks the server for a new code.
///
/// Copied from [ContactInviteController].
class ContactInviteControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ContactInviteController,
        ContactInvite> {
  /// A fresh invite code for one contact. Auto-disposed, so every time the
  /// invite dialog opens it asks the server for a new code.
  ///
  /// Copied from [ContactInviteController].
  ContactInviteControllerProvider(
    String contactId,
  ) : this._internal(
          () => ContactInviteController()..contactId = contactId,
          from: contactInviteControllerProvider,
          name: r'contactInviteControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$contactInviteControllerHash,
          dependencies: ContactInviteControllerFamily._dependencies,
          allTransitiveDependencies:
              ContactInviteControllerFamily._allTransitiveDependencies,
          contactId: contactId,
        );

  ContactInviteControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.contactId,
  }) : super.internal();

  final String contactId;

  @override
  FutureOr<ContactInvite> runNotifierBuild(
    covariant ContactInviteController notifier,
  ) {
    return notifier.build(
      contactId,
    );
  }

  @override
  Override overrideWith(ContactInviteController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ContactInviteControllerProvider._internal(
        () => create()..contactId = contactId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        contactId: contactId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ContactInviteController,
      ContactInvite> createElement() {
    return _ContactInviteControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ContactInviteControllerProvider &&
        other.contactId == contactId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, contactId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ContactInviteControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ContactInvite> {
  /// The parameter `contactId` of this provider.
  String get contactId;
}

class _ContactInviteControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ContactInviteController,
        ContactInvite> with ContactInviteControllerRef {
  _ContactInviteControllerProviderElement(super.provider);

  @override
  String get contactId => (origin as ContactInviteControllerProvider).contactId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
