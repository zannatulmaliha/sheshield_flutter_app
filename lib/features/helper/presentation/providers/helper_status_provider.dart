import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/features/helper/domain/entities/helper_status.dart';
import 'package:sheshield/features/helper/domain/repositories/i_helper_repository.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_helper_status_usecase.dart';

part 'helper_status_provider.g.dart';

/// Owns "am I active, and at what radius". [toggleActive] and
/// [setRadius] are the only way anything else in the app changes this
/// state -- both go through the domain use cases, never straight to
/// the repository.
@riverpod
class HelperStatusController extends _$HelperStatusController {
  static const _fallback = HelperStatus(isActive: false, radiusKm: 3);

  @override
  Future<HelperStatus> build() async {
    try {
      return await getIt<GetHelperStatusUseCase>().call();
    } on HelperFailure {
      // Can't read status -> default to inactive. Never guess "on":
      // that would put someone in the responder pool without them
      // having chosen to be there.
      return _fallback;
    }
  }

  /// Returns null on success, or a message to show the user.
  Future<String?> toggleActive(bool value) async {
    final previous = state.valueOrNull ?? _fallback;

    double? lat, lng;
    if (value) {
      final position = await getIt<DeviceLocationService>().getCurrentPosition();
      if (position == null) return 'Location permission is needed to go active.';
      lat = position.latitude;
      lng = position.longitude;
    }

    state = const AsyncLoading<HelperStatus>().copyWithPrevious(state);
    try {
      final updated = await getIt<SetHelperStatusUseCase>().call(
        isActive: value,
        radiusKm: previous.radiusKm,
        latitude: lat,
        longitude: lng,
      );
      state = AsyncData(updated);
      return null;
    } on HelperFailure catch (e) {
      state = AsyncData(previous);
      return e.message;
    }
  }

  /// Optimistically updates the local radius immediately (the slider
  /// must never feel laggy), then syncs it to the server only if
  /// currently active.
  Future<void> setRadius(double km) async {
    final previous = state.valueOrNull;
    if (previous == null) return;
    state = AsyncData(previous.copyWith(radiusKm: km));
    if (!previous.isActive) return;
    try {
      await getIt<SetHelperStatusUseCase>().call(isActive: true, radiusKm: km);
    } on HelperFailure {
      // Leave the slider where the user put it; the next successful
      // sync (or the next toggle) reconciles with the server.
    }
  }
}
