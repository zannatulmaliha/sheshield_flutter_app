// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_verification_image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminVerificationImageControllerHash() =>
    r'a95050538e99d78cdaba46a539a034520a42f754';

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

abstract class _$AdminVerificationImageController
    extends BuildlessAutoDisposeAsyncNotifier<Uint8List> {
  late final String verificationId;
  late final VerificationImageKind kind;

  FutureOr<Uint8List> build(
    String verificationId,
    VerificationImageKind kind,
  );
}

/// Bytes of one uploaded verification photo (empty when unavailable).
///
/// Copied from [AdminVerificationImageController].
@ProviderFor(AdminVerificationImageController)
const adminVerificationImageControllerProvider =
    AdminVerificationImageControllerFamily();

/// Bytes of one uploaded verification photo (empty when unavailable).
///
/// Copied from [AdminVerificationImageController].
class AdminVerificationImageControllerFamily
    extends Family<AsyncValue<Uint8List>> {
  /// Bytes of one uploaded verification photo (empty when unavailable).
  ///
  /// Copied from [AdminVerificationImageController].
  const AdminVerificationImageControllerFamily();

  /// Bytes of one uploaded verification photo (empty when unavailable).
  ///
  /// Copied from [AdminVerificationImageController].
  AdminVerificationImageControllerProvider call(
    String verificationId,
    VerificationImageKind kind,
  ) {
    return AdminVerificationImageControllerProvider(
      verificationId,
      kind,
    );
  }

  @override
  AdminVerificationImageControllerProvider getProviderOverride(
    covariant AdminVerificationImageControllerProvider provider,
  ) {
    return call(
      provider.verificationId,
      provider.kind,
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
  String? get name => r'adminVerificationImageControllerProvider';
}

/// Bytes of one uploaded verification photo (empty when unavailable).
///
/// Copied from [AdminVerificationImageController].
class AdminVerificationImageControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        AdminVerificationImageController, Uint8List> {
  /// Bytes of one uploaded verification photo (empty when unavailable).
  ///
  /// Copied from [AdminVerificationImageController].
  AdminVerificationImageControllerProvider(
    String verificationId,
    VerificationImageKind kind,
  ) : this._internal(
          () => AdminVerificationImageController()
            ..verificationId = verificationId
            ..kind = kind,
          from: adminVerificationImageControllerProvider,
          name: r'adminVerificationImageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adminVerificationImageControllerHash,
          dependencies: AdminVerificationImageControllerFamily._dependencies,
          allTransitiveDependencies:
              AdminVerificationImageControllerFamily._allTransitiveDependencies,
          verificationId: verificationId,
          kind: kind,
        );

  AdminVerificationImageControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.verificationId,
    required this.kind,
  }) : super.internal();

  final String verificationId;
  final VerificationImageKind kind;

  @override
  FutureOr<Uint8List> runNotifierBuild(
    covariant AdminVerificationImageController notifier,
  ) {
    return notifier.build(
      verificationId,
      kind,
    );
  }

  @override
  Override overrideWith(AdminVerificationImageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdminVerificationImageControllerProvider._internal(
        () => create()
          ..verificationId = verificationId
          ..kind = kind,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        verificationId: verificationId,
        kind: kind,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AdminVerificationImageController,
      Uint8List> createElement() {
    return _AdminVerificationImageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminVerificationImageControllerProvider &&
        other.verificationId == verificationId &&
        other.kind == kind;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, verificationId.hashCode);
    hash = _SystemHash.combine(hash, kind.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AdminVerificationImageControllerRef
    on AutoDisposeAsyncNotifierProviderRef<Uint8List> {
  /// The parameter `verificationId` of this provider.
  String get verificationId;

  /// The parameter `kind` of this provider.
  VerificationImageKind get kind;
}

class _AdminVerificationImageControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        AdminVerificationImageController,
        Uint8List> with AdminVerificationImageControllerRef {
  _AdminVerificationImageControllerProviderElement(super.provider);

  @override
  String get verificationId =>
      (origin as AdminVerificationImageControllerProvider).verificationId;
  @override
  VerificationImageKind get kind =>
      (origin as AdminVerificationImageControllerProvider).kind;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
