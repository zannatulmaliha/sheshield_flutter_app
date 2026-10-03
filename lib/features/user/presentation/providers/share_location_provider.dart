import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/service_providers.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_trusted_contacts_usecase.dart';
import 'package:sheshield/features/contacts/presentation/providers/contacts_use_case_providers.dart';

part 'share_location_provider.g.dart';

/// One-shot "send my current location now": a lighter sibling of
/// `SosController.send` that skips the backend alert / live tracking and
/// just texts a maps pin to every trusted contact.
@riverpod
class ShareLocationController extends _$ShareLocationController {
  late final DeviceLocationService _locationService =
      ref.read(deviceLocationServiceProvider);
  late final DeviceSmsService _smsService = ref.read(deviceSmsServiceProvider);
  late final GetTrustedContactsUseCase _getTrustedContacts =
      ref.read(getTrustedContactsUseCaseProvider);

  @override
  FutureOr<void> build() {}

  /// Returns null on success, or a message to show the user.
  Future<String?> share() async {
    state = const AsyncLoading();

    final position = await _locationService.getCurrentPosition();
    if (position == null) {
      state = const AsyncData(null);
      return 'Location permission is needed to share your location.';
    }

    final contacts = await _getTrustedContacts();
    if (contacts.isEmpty) {
      state = const AsyncData(null);
      return 'Add a trusted contact first.';
    }

    final mapsUrl =
        'https://maps.google.com/?q=${position.latitude},${position.longitude}';
    final numbersById = {
      for (final contact in contacts)
        contact.id: '${contact.countryCode}${contact.phone}',
    };

    final reachedIds = await _smsService.sendToMany(
      numbersById,
      "Here's my current location: $mapsUrl -- sent via SheShield.",
    );
    state = const AsyncData(null);
    return reachedIds.isEmpty ? "Couldn't send SMS -- check SMS permission." : null;
  }
}
