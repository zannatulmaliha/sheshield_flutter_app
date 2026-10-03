// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helper_response_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helperResponseControllerHash() =>
    r'd9e823ea0d084e01f20071f3133e8ed98f694e55';

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

abstract class _$HelperResponseController
    extends BuildlessAutoDisposeNotifier<HelperResponseState> {
  late final String alertId;
  late final ResponseStage initialStage;

  HelperResponseState build(
    String alertId,
    ResponseStage initialStage,
  );
}

/// Everything about one held alert: polls `GET /helper/alerts/{id}/live`
/// (the server is the authority; after it resolves or the lock is lost the
/// live call stops returning coordinates), tracks the stage, and performs
/// stage / resolve / back-out. Action methods throw `AppFailure`; the
/// widget shows it.
///
/// Copied from [HelperResponseController].
@ProviderFor(HelperResponseController)
const helperResponseControllerProvider = HelperResponseControllerFamily();

/// Everything about one held alert: polls `GET /helper/alerts/{id}/live`
/// (the server is the authority; after it resolves or the lock is lost the
/// live call stops returning coordinates), tracks the stage, and performs
/// stage / resolve / back-out. Action methods throw `AppFailure`; the
/// widget shows it.
///
/// Copied from [HelperResponseController].
class HelperResponseControllerFamily extends Family<HelperResponseState> {
  /// Everything about one held alert: polls `GET /helper/alerts/{id}/live`
  /// (the server is the authority; after it resolves or the lock is lost the
  /// live call stops returning coordinates), tracks the stage, and performs
  /// stage / resolve / back-out. Action methods throw `AppFailure`; the
  /// widget shows it.
  ///
  /// Copied from [HelperResponseController].
  const HelperResponseControllerFamily();

  /// Everything about one held alert: polls `GET /helper/alerts/{id}/live`
  /// (the server is the authority; after it resolves or the lock is lost the
  /// live call stops returning coordinates), tracks the stage, and performs
  /// stage / resolve / back-out. Action methods throw `AppFailure`; the
  /// widget shows it.
  ///
  /// Copied from [HelperResponseController].
  HelperResponseControllerProvider call(
    String alertId,
    ResponseStage initialStage,
  ) {
    return HelperResponseControllerProvider(
      alertId,
      initialStage,
    );
  }

  @override
  HelperResponseControllerProvider getProviderOverride(
    covariant HelperResponseControllerProvider provider,
  ) {
    return call(
      provider.alertId,
      provider.initialStage,
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
  String? get name => r'helperResponseControllerProvider';
}

/// Everything about one held alert: polls `GET /helper/alerts/{id}/live`
/// (the server is the authority; after it resolves or the lock is lost the
/// live call stops returning coordinates), tracks the stage, and performs
/// stage / resolve / back-out. Action methods throw `AppFailure`; the
/// widget shows it.
///
/// Copied from [HelperResponseController].
class HelperResponseControllerProvider extends AutoDisposeNotifierProviderImpl<
    HelperResponseController, HelperResponseState> {
  /// Everything about one held alert: polls `GET /helper/alerts/{id}/live`
  /// (the server is the authority; after it resolves or the lock is lost the
  /// live call stops returning coordinates), tracks the stage, and performs
  /// stage / resolve / back-out. Action methods throw `AppFailure`; the
  /// widget shows it.
  ///
  /// Copied from [HelperResponseController].
  HelperResponseControllerProvider(
    String alertId,
    ResponseStage initialStage,
  ) : this._internal(
          () => HelperResponseController()
            ..alertId = alertId
            ..initialStage = initialStage,
          from: helperResponseControllerProvider,
          name: r'helperResponseControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$helperResponseControllerHash,
          dependencies: HelperResponseControllerFamily._dependencies,
          allTransitiveDependencies:
              HelperResponseControllerFamily._allTransitiveDependencies,
          alertId: alertId,
          initialStage: initialStage,
        );

  HelperResponseControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.alertId,
    required this.initialStage,
  }) : super.internal();

  final String alertId;
  final ResponseStage initialStage;

  @override
  HelperResponseState runNotifierBuild(
    covariant HelperResponseController notifier,
  ) {
    return notifier.build(
      alertId,
      initialStage,
    );
  }

  @override
  Override overrideWith(HelperResponseController Function() create) {
    return ProviderOverride(
      origin: this,
      override: HelperResponseControllerProvider._internal(
        () => create()
          ..alertId = alertId
          ..initialStage = initialStage,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        alertId: alertId,
        initialStage: initialStage,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<HelperResponseController,
      HelperResponseState> createElement() {
    return _HelperResponseControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HelperResponseControllerProvider &&
        other.alertId == alertId &&
        other.initialStage == initialStage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, alertId.hashCode);
    hash = _SystemHash.combine(hash, initialStage.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HelperResponseControllerRef
    on AutoDisposeNotifierProviderRef<HelperResponseState> {
  /// The parameter `alertId` of this provider.
  String get alertId;

  /// The parameter `initialStage` of this provider.
  ResponseStage get initialStage;
}

class _HelperResponseControllerProviderElement
    extends AutoDisposeNotifierProviderElement<HelperResponseController,
        HelperResponseState> with HelperResponseControllerRef {
  _HelperResponseControllerProviderElement(super.provider);

  @override
  String get alertId => (origin as HelperResponseControllerProvider).alertId;
  @override
  ResponseStage get initialStage =>
      (origin as HelperResponseControllerProvider).initialStage;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
