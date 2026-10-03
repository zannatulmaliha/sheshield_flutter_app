import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/features/helper/domain/entities/helper_status.dart';
import 'package:sheshield/features/helper/domain/usecases/get_helper_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/set_helper_status_usecase.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_use_case_providers.dart';

part 'helper_status_provider.g.dart';

/// Owns "am I active, and at what radius". [toggleActive], [setRadius] and
/// [setMutualConnectionOptIn] are the only ways anything else in the app
/// changes this state.
@riverpod
class HelperStatusController extends _$HelperStatusController {
  static const _fallback = HelperStatus(isActive: false, radiusKm: 3);

  late final GetHelperStatusUseCase _getHelperStatus =
      ref.read(getHelperStatusUseCaseProvider);
  late final SetHelperStatusUseCase _setHelperStatus =
      ref.read(setHelperStatusUseCaseProvider);
  late final DeviceLocationService _locationService =
      ref.read(deviceLocationServiceProvider);

  @override
  Future<HelperStatus> build() async {
    try {
      return await _getHelperStatus();
    } on AppFailure {
      // Can't read status -> default to inactive. Never guess "on": that
      // would put someone in the responder pool without them choosing to be.
      return _fallback;
    }
  }

  /// Returns null on success, or a message to show the person.
  Future<String?> toggleActive(bool isActive) async {
    final previous = state.valueOrNull ?? _fallback;

    double? latitude;
    double? longitude;
    if (isActive) {
      final position = await _locationService.getCurrentPosition();
      if (position == null) return 'Location permission is needed to go active.';
      latitude = position.latitude;
      longitude = position.longitude;
    }

    state = const AsyncLoading<HelperStatus>().copyWithPrevious(state);
    try {
      final updated = await _setHelperStatus(
        isActive: isActive,
        radiusKm: previous.radiusKm,
        latitude: latitude,
        longitude: longitude,
        mutualConnectionOptIn: previous.mutualConnectionOptIn,
      );
      state = AsyncData(updated);
      return null;
    } on AppFailure catch (failure) {
      state = AsyncData(previous);
      return failure.message;
    }
  }

  /// Re-sends the helper's position while active. The server only matches
  /// alerts against a location updated within the last 15 minutes, so
  /// without this the nearby list silently empties. Best-effort.
  Future<void> refreshLocation() async {
    final current = state.valueOrNull;
    if (current == null || !current.isActive) return;
    try {
      final position = await _locationService.getCurrentPosition();
      if (position == null) return;
      // Deliberately does NOT assign `state`: the nearby-alerts controller
      // watches this provider, so changing it here would loop.
      await _setHelperStatus(
        isActive: true,
        radiusKm: current.radiusKm,
        latitude: position.latitude,
        longitude: position.longitude,
        mutualConnectionOptIn: current.mutualConnectionOptIn,
      );
    } on AppFailure {
      // keep the last known position
    } catch (_) {
      // location plugin errors are equally non-fatal here
    }
  }

  /// Updates the local radius at once (the slider must never feel laggy),
  /// then syncs to the server only while active.
  Future<void> setRadius(double radiusKm) async {
    final previous = state.valueOrNull;
    if (previous == null) return;
    state = AsyncData(previous.copyWith(radiusKm: radiusKm));
    if (!previous.isActive) return;
    try {
      await _setHelperStatus(
        isActive: true,
        radiusKm: radiusKm,
        mutualConnectionOptIn: previous.mutualConnectionOptIn,
      );
    } on AppFailure {
      // Leave the slider where the person put it; the next successful
      // sync reconciles with the server.
    }
  }

  /// Helper side of the §10 double opt-in (verified helpers only,
  /// server-side). Optimistic like [setRadius].
  Future<void> setMutualConnectionOptIn(bool isOptedIn) async {
    final previous = state.valueOrNull;
    if (previous == null) return;
    state = AsyncData(previous.copyWith(mutualConnectionOptIn: isOptedIn));
    try {
      state = AsyncData(
        await _setHelperStatus(
          isActive: previous.isActive,
          radiusKm: previous.radiusKm,
          mutualConnectionOptIn: isOptedIn,
        ),
      );
    } on AppFailure {
      state = AsyncData(previous);
    }
  }
}
