// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$checkInControllerHash() => r'fa055d8be16b806b067e0049e8dfe804cb7a1e56';

/// A safety countdown the person sets before doing something risky (walking
/// home alone, meeting a stranger, ...). If it reaches zero without them
/// checking in, an SOS goes out on their behalf via [SosController.send] --
/// the exact same alert (live location + every trusted contact) a manual SOS
/// press triggers.
///
/// Ticks once a second with a plain [Timer], which only ever fires while
/// this app process is alive and in the foreground. There is deliberately
/// no WorkManager/AlarmManager-backed background service behind it yet, so
/// a fully backgrounded (and especially a killed) app will NOT fire the
/// automatic SOS -- the same class of limitation already called out for
/// [PushService] on this codebase's MIUI test devices. Good enough for "I
/// forgot to check in while the app was open"; not yet a substitute for a
/// true OS-level background timer.
///
/// Copied from [CheckInController].
@ProviderFor(CheckInController)
final checkInControllerProvider =
    AutoDisposeNotifierProvider<CheckInController, CheckInState>.internal(
  CheckInController.new,
  name: r'checkInControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$checkInControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CheckInController = AutoDisposeNotifier<CheckInState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
