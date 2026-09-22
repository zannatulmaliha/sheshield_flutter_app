import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/features/sos/domain/entities/sos_alert.dart';
import 'package:sheshield/features/sos/domain/repositories/i_sos_repository.dart';
import 'package:sheshield/features/sos/domain/usecases/send_sos_usecase.dart';

part 'sos_provider.g.dart';

/// Owns the currently-active SOS alert, if any. Starts at `null` --
/// there is nothing to fetch on app launch, unlike helper status,
/// since an alert only exists once the user actually sends one in
/// this session.
@riverpod
class SosController extends _$SosController {
  @override
  AsyncValue<SosAlert?> build() => const AsyncData(null);

  /// Resolves the device's current position, then sends the alert.
  /// Returns null on success, or a message to show the user.
  Future<String?> send() async {
    state = const AsyncLoading<SosAlert?>().copyWithPrevious(state);

    final position = await getIt<DeviceLocationService>().getCurrentPosition();
    if (position == null) {
      state = const AsyncData(null);
      return 'Location permission is needed to send an SOS alert.';
    }

    try {
      final alert = await getIt<SendSosUseCase>().call(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracyMeters: position.accuracy,
        // The device doesn't attempt its own SMS send yet, so nothing
        // is pre-notified -- the server texts every trusted contact.
        notifiedByDevice: const [],
      );
      state = AsyncData(alert);
      return null;
    } on SosFailure catch (e) {
      state = const AsyncData(null);
      return e.message;
    }
  }

  /// There is no cancel endpoint -- by the time an alert exists,
  /// contacts have already been texted. This only clears the local
  /// "alert sent" UI state so the person can dismiss the overlay.
  void dismiss() {
    state = const AsyncData(null);
  }
}