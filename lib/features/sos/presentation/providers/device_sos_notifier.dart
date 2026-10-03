import 'package:geolocator/geolocator.dart';
import 'package:sheshield/core/services/device_sms_service.dart';
import 'package:sheshield/features/contacts/domain/usecases/get_trusted_contacts_usecase.dart';

/// Texts every trusted contact straight from this phone's SIM with a maps
/// link: free, immediate, and it still reaches contacts when the backend is
/// unreachable or has no SMS provider configured.
class DeviceSosNotifier {
  const DeviceSosNotifier({
    required GetTrustedContactsUseCase getTrustedContacts,
    required DeviceSmsService smsService,
  })  : _getTrustedContacts = getTrustedContacts,
        _smsService = smsService;

  final GetTrustedContactsUseCase _getTrustedContacts;
  final DeviceSmsService _smsService;

  /// Returns the ids of contacts reached. Best-effort: any failure (denied
  /// permission, no contacts, one bad number) just means fewer ids, and the
  /// server-side send covers whoever is missing.
  Future<List<String>> notifyContacts(Position position) async {
    try {
      final contacts = await _getTrustedContacts();
      if (contacts.isEmpty) return const [];

      final mapsUrl =
          'https://maps.google.com/?q=${position.latitude},${position.longitude}';
      final numbersById = {
        for (final contact in contacts)
          contact.id: '${contact.countryCode}${contact.phone}',
      };
      return await _smsService.sendToMany(
        numbersById,
        'SOS! I need help. My live location: $mapsUrl -- sent via SheShield.',
      );
    } catch (_) {
      return const [];
    }
  }
}
