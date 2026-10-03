// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_verification_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminVerificationDetailControllerHash() =>
    r'637dd803a837882262f4be25af384f889e2e58a3';

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

abstract class _$AdminVerificationDetailController
    extends BuildlessAutoDisposeAsyncNotifier<AdminVerification> {
  late final String verificationId;

  FutureOr<AdminVerification> build(
    String verificationId,
  );
}

/// One verification submission, plus the approve / reject decision.
///
/// Copied from [AdminVerificationDetailController].
@ProviderFor(AdminVerificationDetailController)
const adminVerificationDetailControllerProvider =
    AdminVerificationDetailControllerFamily();

/// One verification submission, plus the approve / reject decision.
///
/// Copied from [AdminVerificationDetailController].
class AdminVerificationDetailControllerFamily
    extends Family<AsyncValue<AdminVerification>> {
  /// One verification submission, plus the approve / reject decision.
  ///
  /// Copied from [AdminVerificationDetailController].
  const AdminVerificationDetailControllerFamily();

  /// One verification submission, plus the approve / reject decision.
  ///
  /// Copied from [AdminVerificationDetailController].
  AdminVerificationDetailControllerProvider call(
    String verificationId,
  ) {
    return AdminVerificationDetailControllerProvider(
      verificationId,
    );
  }

  @override
  AdminVerificationDetailControllerProvider getProviderOverride(
    covariant AdminVerificationDetailControllerProvider provider,
  ) {
    return call(
      provider.verificationId,
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
  String? get name => r'adminVerificationDetailControllerProvider';
}

/// One verification submission, plus the approve / reject decision.
///
/// Copied from [AdminVerificationDetailController].
class AdminVerificationDetailControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        AdminVerificationDetailController, AdminVerification> {
  /// One verification submission, plus the approve / reject decision.
  ///
  /// Copied from [AdminVerificationDetailController].
  AdminVerificationDetailControllerProvider(
    String verificationId,
  ) : this._internal(
          () => AdminVerificationDetailController()
            ..verificationId = verificationId,
          from: adminVerificationDetailControllerProvider,
          name: r'adminVerificationDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adminVerificationDetailControllerHash,
          dependencies: AdminVerificationDetailControllerFamily._dependencies,
          allTransitiveDependencies: AdminVerificationDetailControllerFamily
              ._allTransitiveDependencies,
          verificationId: verificationId,
        );

  AdminVerificationDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.verificationId,
  }) : super.internal();

  final String verificationId;

  @override
  FutureOr<AdminVerification> runNotifierBuild(
    covariant AdminVerificationDetailController notifier,
  ) {
    return notifier.build(
      verificationId,
    );
  }

  @override
  Override overrideWith(AdminVerificationDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdminVerificationDetailControllerProvider._internal(
        () => create()..verificationId = verificationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        verificationId: verificationId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AdminVerificationDetailController,
      AdminVerification> createElement() {
    return _AdminVerificationDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminVerificationDetailControllerProvider &&
        other.verificationId == verificationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, verificationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AdminVerificationDetailControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AdminVerification> {
  /// The parameter `verificationId` of this provider.
  String get verificationId;
}

class _AdminVerificationDetailControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        AdminVerificationDetailController,
        AdminVerification> with AdminVerificationDetailControllerRef {
  _AdminVerificationDetailControllerProviderElement(super.provider);

  @override
  String get verificationId =>
      (origin as AdminVerificationDetailControllerProvider).verificationId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
