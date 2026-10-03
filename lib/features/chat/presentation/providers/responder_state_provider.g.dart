// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responder_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$responderStateControllerHash() =>
    r'4341e21458fdca5c987d49a17189ce3da881aec9';

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

abstract class _$ResponderStateController
    extends BuildlessAutoDisposeNotifier<ResponderState?> {
  late final String sosId;

  ResponderState? build(
    String sosId,
  );
}

/// Has a helper accepted this SOS yet, and how far along are they? Polls
/// while something is watching it (auto-disposed). `null` until the first
/// answer arrives. A failed poll is not fatal: the next tick tries again.
///
/// Copied from [ResponderStateController].
@ProviderFor(ResponderStateController)
const responderStateControllerProvider = ResponderStateControllerFamily();

/// Has a helper accepted this SOS yet, and how far along are they? Polls
/// while something is watching it (auto-disposed). `null` until the first
/// answer arrives. A failed poll is not fatal: the next tick tries again.
///
/// Copied from [ResponderStateController].
class ResponderStateControllerFamily extends Family<ResponderState?> {
  /// Has a helper accepted this SOS yet, and how far along are they? Polls
  /// while something is watching it (auto-disposed). `null` until the first
  /// answer arrives. A failed poll is not fatal: the next tick tries again.
  ///
  /// Copied from [ResponderStateController].
  const ResponderStateControllerFamily();

  /// Has a helper accepted this SOS yet, and how far along are they? Polls
  /// while something is watching it (auto-disposed). `null` until the first
  /// answer arrives. A failed poll is not fatal: the next tick tries again.
  ///
  /// Copied from [ResponderStateController].
  ResponderStateControllerProvider call(
    String sosId,
  ) {
    return ResponderStateControllerProvider(
      sosId,
    );
  }

  @override
  ResponderStateControllerProvider getProviderOverride(
    covariant ResponderStateControllerProvider provider,
  ) {
    return call(
      provider.sosId,
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
  String? get name => r'responderStateControllerProvider';
}

/// Has a helper accepted this SOS yet, and how far along are they? Polls
/// while something is watching it (auto-disposed). `null` until the first
/// answer arrives. A failed poll is not fatal: the next tick tries again.
///
/// Copied from [ResponderStateController].
class ResponderStateControllerProvider extends AutoDisposeNotifierProviderImpl<
    ResponderStateController, ResponderState?> {
  /// Has a helper accepted this SOS yet, and how far along are they? Polls
  /// while something is watching it (auto-disposed). `null` until the first
  /// answer arrives. A failed poll is not fatal: the next tick tries again.
  ///
  /// Copied from [ResponderStateController].
  ResponderStateControllerProvider(
    String sosId,
  ) : this._internal(
          () => ResponderStateController()..sosId = sosId,
          from: responderStateControllerProvider,
          name: r'responderStateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$responderStateControllerHash,
          dependencies: ResponderStateControllerFamily._dependencies,
          allTransitiveDependencies:
              ResponderStateControllerFamily._allTransitiveDependencies,
          sosId: sosId,
        );

  ResponderStateControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sosId,
  }) : super.internal();

  final String sosId;

  @override
  ResponderState? runNotifierBuild(
    covariant ResponderStateController notifier,
  ) {
    return notifier.build(
      sosId,
    );
  }

  @override
  Override overrideWith(ResponderStateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ResponderStateControllerProvider._internal(
        () => create()..sosId = sosId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sosId: sosId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ResponderStateController, ResponderState?>
      createElement() {
    return _ResponderStateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResponderStateControllerProvider && other.sosId == sosId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sosId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ResponderStateControllerRef
    on AutoDisposeNotifierProviderRef<ResponderState?> {
  /// The parameter `sosId` of this provider.
  String get sosId;
}

class _ResponderStateControllerProviderElement
    extends AutoDisposeNotifierProviderElement<ResponderStateController,
        ResponderState?> with ResponderStateControllerRef {
  _ResponderStateControllerProviderElement(super.provider);

  @override
  String get sosId => (origin as ResponderStateControllerProvider).sosId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
