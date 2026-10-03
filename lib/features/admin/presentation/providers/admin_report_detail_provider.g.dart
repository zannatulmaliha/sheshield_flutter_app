// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_report_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminReportDetailControllerHash() =>
    r'26c9b487c5f1356337b922fa0b5edde9b82a2cc0';

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

abstract class _$AdminReportDetailController
    extends BuildlessAutoDisposeAsyncNotifier<AdminReportDetail> {
  late final String reportId;

  FutureOr<AdminReportDetail> build(
    String reportId,
  );
}

/// One report with its audit trail. Always fetched fresh (never reused
/// from the queue): the same reviewer may act on a report from two
/// devices, so a possibly-stale copy is the wrong trade-off.
///
/// Copied from [AdminReportDetailController].
@ProviderFor(AdminReportDetailController)
const adminReportDetailControllerProvider = AdminReportDetailControllerFamily();

/// One report with its audit trail. Always fetched fresh (never reused
/// from the queue): the same reviewer may act on a report from two
/// devices, so a possibly-stale copy is the wrong trade-off.
///
/// Copied from [AdminReportDetailController].
class AdminReportDetailControllerFamily
    extends Family<AsyncValue<AdminReportDetail>> {
  /// One report with its audit trail. Always fetched fresh (never reused
  /// from the queue): the same reviewer may act on a report from two
  /// devices, so a possibly-stale copy is the wrong trade-off.
  ///
  /// Copied from [AdminReportDetailController].
  const AdminReportDetailControllerFamily();

  /// One report with its audit trail. Always fetched fresh (never reused
  /// from the queue): the same reviewer may act on a report from two
  /// devices, so a possibly-stale copy is the wrong trade-off.
  ///
  /// Copied from [AdminReportDetailController].
  AdminReportDetailControllerProvider call(
    String reportId,
  ) {
    return AdminReportDetailControllerProvider(
      reportId,
    );
  }

  @override
  AdminReportDetailControllerProvider getProviderOverride(
    covariant AdminReportDetailControllerProvider provider,
  ) {
    return call(
      provider.reportId,
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
  String? get name => r'adminReportDetailControllerProvider';
}

/// One report with its audit trail. Always fetched fresh (never reused
/// from the queue): the same reviewer may act on a report from two
/// devices, so a possibly-stale copy is the wrong trade-off.
///
/// Copied from [AdminReportDetailController].
class AdminReportDetailControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AdminReportDetailController,
        AdminReportDetail> {
  /// One report with its audit trail. Always fetched fresh (never reused
  /// from the queue): the same reviewer may act on a report from two
  /// devices, so a possibly-stale copy is the wrong trade-off.
  ///
  /// Copied from [AdminReportDetailController].
  AdminReportDetailControllerProvider(
    String reportId,
  ) : this._internal(
          () => AdminReportDetailController()..reportId = reportId,
          from: adminReportDetailControllerProvider,
          name: r'adminReportDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adminReportDetailControllerHash,
          dependencies: AdminReportDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              AdminReportDetailControllerFamily._allTransitiveDependencies,
          reportId: reportId,
        );

  AdminReportDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reportId,
  }) : super.internal();

  final String reportId;

  @override
  FutureOr<AdminReportDetail> runNotifierBuild(
    covariant AdminReportDetailController notifier,
  ) {
    return notifier.build(
      reportId,
    );
  }

  @override
  Override overrideWith(AdminReportDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdminReportDetailControllerProvider._internal(
        () => create()..reportId = reportId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reportId: reportId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AdminReportDetailController,
      AdminReportDetail> createElement() {
    return _AdminReportDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminReportDetailControllerProvider &&
        other.reportId == reportId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reportId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AdminReportDetailControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AdminReportDetail> {
  /// The parameter `reportId` of this provider.
  String get reportId;
}

class _AdminReportDetailControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AdminReportDetailController,
        AdminReportDetail> with AdminReportDetailControllerRef {
  _AdminReportDetailControllerProviderElement(super.provider);

  @override
  String get reportId =>
      (origin as AdminReportDetailControllerProvider).reportId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
