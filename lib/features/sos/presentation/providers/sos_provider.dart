import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_trusted_contacts_usecase.dart';
import 'package:sheshield/features/contacts/presentation/providers/contacts_use_case_providers.dart';
import 'package:sheshield/features/sos/domain/entities/duress_type.dart';
import 'package:sheshield/features/sos/domain/entities/sos_alert.dart';
import 'package:sheshield/features/sos/domain/usecases/resolve_sos_alert_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/send_sos_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/trigger_duress_usecase.dart';
import 'package:sheshield/features/sos/domain/usecases/update_sos_location_usecase.dart';
import 'package:sheshield/features/sos/presentation/providers/device_sos_notifier.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_use_case_providers.dart';

part 'sos_provider.g.dart';

/// How often the position is re-sent while an alert is active, so the
/// tracking page contacts opened from their SMS keeps following the sender.
const _locationUpdateInterval = Duration(seconds: 10);

/// Owns the currently active SOS alert, if any. Starts at `null`: an alert
/// only exists once the user sends one this session.
@riverpod
class SosController extends _$SosController {
  late final SendSosUseCase _sendSos = ref.read(sendSosUseCaseProvider);
  late final TriggerDuressUseCase _triggerDuress =
      ref.read(triggerDuressUseCaseProvider);
  late final UpdateSosLocationUseCase _updateLocation =
      ref.read(updateSosLocationUseCaseProvider);
  late final ResolveSosAlertUseCase _resolveAlert =
      ref.read(resolveSosAlertUseCaseProvider);
  late final DeviceLocationService _locationService =
      ref.read(deviceLocationServiceProvider);
  late final GetTrustedContactsUseCase _getTrustedContacts =
      ref.read(getTrustedContactsUseCaseProvider);
  late final DeviceSmsService _smsService = ref.read(deviceSmsServiceProvider);
  late final DeviceSosNotifier _deviceNotifier = DeviceSosNotifier(
    getTrustedContacts: _getTrustedContacts,
    smsService: _smsService,
  );

  Timer? _locationTimer;

  @override
  AsyncValue<SosAlert?> build() {
    ref.onDispose(() => _locationTimer?.cancel());
    return const AsyncData(null);
  }

  /// Resolves the position, texts contacts from the SIM, then sends the
  /// alert. [avConsent] is the live answer to "start audio/video recording?"
  /// and is never defaulted to true. [trigger] records what fired the SOS
  /// ("manual", "voice", "motion_fall", ...) so helpers see a plain reason.
  /// Returns null on success, or a message to show the user.
  Future<String?> send({bool avConsent = false, String trigger = 'manual'}) async {
    state = const AsyncLoading<SosAlert?>().copyWithPrevious(state);

    final position = await _locationService.getCurrentPosition();
    if (position == null) {
      state = const AsyncData(null);
      return 'Location permission is needed to send an SOS alert.';
    }

    final notifiedByDevice = await _deviceNotifier.notifyContacts(position);

    try {
      final alert = await _sendSos(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracyMeters: position.accuracy,
        notifiedByDevice: notifiedByDevice,
        avConsent: avConsent,
        trigger: trigger,
      );
      state = AsyncData(alert);
      _startLiveLocation(alert.id);
      return null;
    } on AppFailure catch (failure) {
      state = const AsyncData(null);
      return failure.message;
    }
  }

  /// Escalates the active alert independent of the matched helper. A no-op
  /// without an active alert. Best-effort: pressing panic again is the retry.
  Future<void> triggerDuress(DuressType type) async {
    final alertId = state.valueOrNull?.id;
    if (alertId == null) return;
    try {
      await _triggerDuress(alertId, type);
    } on AppFailure {
      // swallowed
    }
  }

  /// Best-effort: a failed refresh never interrupts the person.
  void _startLiveLocation(String alertId) {
    _locationTimer?.cancel();
    _locationTimer = Timer.periodic(_locationUpdateInterval, (_) async {
      final position = await _locationService.getCurrentPosition();
      if (position == null) return;
      try {
        await _updateLocation(
          alertId: alertId,
          latitude: position.latitude,
          longitude: position.longitude,
          accuracyMeters: position.accuracy,
        );
      } on AppFailure {
        // next tick tries again
      }
    });
  }

  /// "I'm Safe": tells the server, stops the local timer, clears state.
  Future<void> markSafe() async {
    _locationTimer?.cancel();
    final alertId = state.valueOrNull?.id;
    if (alertId != null) {
      try {
        await _resolveAlert(alertId);
      } on AppFailure {
        // The person is safe either way; don't block that locally.
      }
    }
    state = const AsyncData(null);
  }

  /// There is no cancel endpoint: contacts were already texted. This only
  /// clears the local "alert sent" state.
  void dismiss() {
    _locationTimer?.cancel();
    state = const AsyncData(null);
  }
}
