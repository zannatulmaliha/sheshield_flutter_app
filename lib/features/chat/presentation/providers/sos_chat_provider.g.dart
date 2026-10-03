// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sosChatControllerHash() => r'59aaa82b7c55af237a17c77bdbd14b02a6e3d890';

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

abstract class _$SosChatController
    extends BuildlessAutoDisposeNotifier<SosChatState> {
  late final String sosId;

  SosChatState build(
    String sosId,
  );
}

/// One SOS conversation. Polls while the screen is open (auto-disposed, so
/// polling stops when it closes) and owns every state change, so the widget
/// is pure presentation.
///
/// Copied from [SosChatController].
@ProviderFor(SosChatController)
const sosChatControllerProvider = SosChatControllerFamily();

/// One SOS conversation. Polls while the screen is open (auto-disposed, so
/// polling stops when it closes) and owns every state change, so the widget
/// is pure presentation.
///
/// Copied from [SosChatController].
class SosChatControllerFamily extends Family<SosChatState> {
  /// One SOS conversation. Polls while the screen is open (auto-disposed, so
  /// polling stops when it closes) and owns every state change, so the widget
  /// is pure presentation.
  ///
  /// Copied from [SosChatController].
  const SosChatControllerFamily();

  /// One SOS conversation. Polls while the screen is open (auto-disposed, so
  /// polling stops when it closes) and owns every state change, so the widget
  /// is pure presentation.
  ///
  /// Copied from [SosChatController].
  SosChatControllerProvider call(
    String sosId,
  ) {
    return SosChatControllerProvider(
      sosId,
    );
  }

  @override
  SosChatControllerProvider getProviderOverride(
    covariant SosChatControllerProvider provider,
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
  String? get name => r'sosChatControllerProvider';
}

/// One SOS conversation. Polls while the screen is open (auto-disposed, so
/// polling stops when it closes) and owns every state change, so the widget
/// is pure presentation.
///
/// Copied from [SosChatController].
class SosChatControllerProvider
    extends AutoDisposeNotifierProviderImpl<SosChatController, SosChatState> {
  /// One SOS conversation. Polls while the screen is open (auto-disposed, so
  /// polling stops when it closes) and owns every state change, so the widget
  /// is pure presentation.
  ///
  /// Copied from [SosChatController].
  SosChatControllerProvider(
    String sosId,
  ) : this._internal(
          () => SosChatController()..sosId = sosId,
          from: sosChatControllerProvider,
          name: r'sosChatControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sosChatControllerHash,
          dependencies: SosChatControllerFamily._dependencies,
          allTransitiveDependencies:
              SosChatControllerFamily._allTransitiveDependencies,
          sosId: sosId,
        );

  SosChatControllerProvider._internal(
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
  SosChatState runNotifierBuild(
    covariant SosChatController notifier,
  ) {
    return notifier.build(
      sosId,
    );
  }

  @override
  Override overrideWith(SosChatController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SosChatControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<SosChatController, SosChatState>
      createElement() {
    return _SosChatControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SosChatControllerProvider && other.sosId == sosId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sosId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SosChatControllerRef on AutoDisposeNotifierProviderRef<SosChatState> {
  /// The parameter `sosId` of this provider.
  String get sosId;
}

class _SosChatControllerProviderElement
    extends AutoDisposeNotifierProviderElement<SosChatController, SosChatState>
    with SosChatControllerRef {
  _SosChatControllerProviderElement(super.provider);

  @override
  String get sosId => (origin as SosChatControllerProvider).sosId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
