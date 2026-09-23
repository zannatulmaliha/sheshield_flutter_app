import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/device_location_service.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_contacts_usecase.dart';

part 'share_location_provider.g.dart';

/// One-shot "send my current location now" -- a lighter-weight sibling
/// of [SosController.send] that skips the backend alert/live-tracking
/// entirely and just texts a maps pin to every trusted contact.
@riverpod
class ShareLocationController extends _$ShareLocationController {
  @override
  FutureOr<void> build() {}

  /// Returns null on success, or a message to show the user.
  Future<String?> share() async {
    state = const AsyncLoading();

    final position = await getIt<DeviceLocationService>().getCurrentPosition();
    if (position == null) {
      state = const AsyncData(null);
      return 'Location permission is needed to share your location.';
    }

    final contacts = await getIt<GetContactsUseCase>().call();
    if (contacts.isEmpty) {
      state = const AsyncData(null);
      return 'Add a trusted contact first.';
    }

    final mapsUrl =
        'https://maps.google.com/?q=${position.latitude},${position.longitude}';
    final message = "Here's my current location: $mapsUrl -- sent via SheShield.";

    final numbersById = {
      for (final contact in contacts)
        contact.id: '${contact.countryCode}${contact.phone}',
    };

    final sent = await getIt<DeviceSmsService>().sendToMany(numbersById, message);
    state = const AsyncData(null);
    if (sent.isEmpty) {
      return "Couldn't send SMS -- check SMS permission.";
    }
    return null;
  }
}
