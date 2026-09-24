import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:sheshield/features/sos/domain/entities/duress_type.dart';
import 'package:sheshield/features/sos/domain/entities/sos_alert.dart';
import 'package:sheshield/features/sos/domain/repositories/i_sos_repository.dart';
import 'package:sheshield/features/sos/domain/usecases/resolve_sos_alert_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/send_sos_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/trigger_duress_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/update_sos_location_usecase.dart';

part 'sos_provider.g.dart';

/// How often the device's position is re-sent while an alert is active,
/// so the live-tracking page contacts opened from their SMS keeps
/// following the sender instead of freezing at the initial fix.
const _kLocationUpdateInterval = Duration(seconds: 10);

/// Owns the currently-active SOS alert, if any. Starts at `null` --
/// there is nothing to fetch on app launch, unlike helper status,
/// since an alert only exists once the user actually sends one in
/// this session.
@riverpod
class SosController extends _$SosController {
  Timer? _locationTimer;

  @override
  AsyncValue<SosAlert?> build() {
    ref.onDispose(() => _locationTimer?.cancel());
    return const AsyncData(null);
  }

  /// Resolves the device's current position, then sends the alert.
  /// [avConsent] is the real-time answer to "start audio/video recording
  /// for this emergency?" -- passed straight through, never defaulted to
  /// true. Returns null on success, or a message to show the user.
  Future<String?> send({bool avConsent = false}) async {
    state = const AsyncLoading<SosAlert?>().copyWithPrevious(state);

    final position = await getIt<DeviceLocationService>().getCurrentPosition();
    if (position == null) {
      state = const AsyncData(null);
      return 'Location permission is needed to send an SOS alert.';
    }

    final notifiedByDevice = await _sendDeviceSms(position);

    try {
      final alert = await getIt<SendSosUseCase>().call(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracyMeters: position.accuracy,
        notifiedByDevice: notifiedByDevice,
        avConsent: avConsent,
      );
      state = AsyncData(alert);
      _startLiveLocation(alert.id);
      return null;
    } on SosFailure catch (e) {
      state = const AsyncData(null);
      return e.message;
    }
  }

  /// Fires a duress signal (manual panic / hardware pattern / missed
  /// check-in) on the currently active alert -- escalates independent of
  /// the currently matched helper. A no-op if there's no active alert.
  /// Best-effort: a failed call here shouldn't block whatever local UI
  /// (e.g. the panic button) triggered it.
  Future<void> triggerDuress(DuressType type) async {
    final alertId = state.valueOrNull?.id;
    if (alertId == null) return;
    try {
      await getIt<TriggerDuressUseCase>().call(alertId, type);
    } on SosFailure {
      // Swallowed -- the person pressing panic again is the natural retry.
    }
  }

  /// Texts every trusted contact directly from this device's SIM with a
  /// maps link to [position] -- free and immediate, and it still reaches
  /// contacts even if the backend is unreachable or has no SMS provider
  /// configured. Best-effort: any failure (denied permission, no
  /// contacts, a single bad number) just means fewer/no ids come back,
  /// and the server-side send still covers whichever contacts aren't in
  /// the returned list.
  Future<List<String>> _sendDeviceSms(Position position) async {
    try {
      final contacts = await getIt<GetContactsUseCase>().call();
      if (contacts.isEmpty) return const [];

      final mapsUrl =
          'https://maps.google.com/?q=${position.latitude},${position.longitude}';
      final message =
          'SOS! I need help. My live location: $mapsUrl -- sent via SheShield.';

      final numbersById = {
        for (final contact in contacts)
          contact.id: '${contact.countryCode}${contact.phone}',
      };

      return await getIt<DeviceSmsService>().sendToMany(numbersById, message);
    } catch (_) {
      return const [];
    }
  }

  /// Keeps the alert's location fresh on the server every
  /// [_kLocationUpdateInterval] until [markSafe]/[dismiss] stops it.
  /// Best-effort: a single failed refresh (e.g. a flaky connection)
  /// shouldn't interrupt anything the person sees.
  void _startLiveLocation(String alertId) {
    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(_kLocationUpdateInterval, (_) async {
      final position = await getIt<DeviceLocationService>().getCurrentPosition();
      if (position == null) return;
      try {
        await getIt<UpdateSosLocationUseCase>().call(
          alertId: alertId,
          latitude: position.latitude,
          longitude: position.longitude,
          accuracyMeters: position.accuracy,
        );
      } on SosFailure {
        // Swallowed -- next tick tries again.
      }
    });
  }

  /// "I'm Safe": tells the server the alert is resolved (stops the
  /// tracking page updating / alarming) and stops the local location
  /// timer, then clears state so the overlay can be dismissed.
  Future<void> markSafe() async {
    _locationTimer?.cancel();
    final alertId = state.valueOrNull?.id;
    if (alertId != null) {
      try {
        await getIt<ResolveSosAlertUseCase>().call(alertId);
      } on SosFailure {
        // Best-effort -- the person is marking themselves safe either
        // way; a failed resolve call shouldn't block that locally.
      }
    }
    state = const AsyncData(null);
  }

  /// There is no cancel endpoint -- by the time an alert exists,
  /// contacts have already been texted. This only clears the local
  /// "alert sent" UI state so the person can dismiss the overlay.
  void dismiss() {
    _locationTimer?.cancel();
    state = const AsyncData(null);
  }
}