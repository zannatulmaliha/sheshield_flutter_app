import 'package:another_telephony/telephony.dart';

/// Thin wrapper so nothing above core/ imports the telephony plugin
/// directly. Sends texts straight from the device's own SIM instead of
/// through a paid third-party SMS API, so an SOS alert can reach
/// trusted contacts immediately and for free, even if the backend is
/// unreachable. Android only -- iOS never allows an app to send SMS
/// without the user tapping Send in the Messages UI, so there
/// [sendToMany] always returns an empty list.
class DeviceSmsService {
  final Telephony _telephony = Telephony.instance;

  /// Sends [message] to each phone number in [numbersById] (contact id
  /// -> phone number) directly via the device's SIM. Returns the ids
  /// whose send call completed without throwing -- callers use this to
  /// avoid asking the server to notify the same contact twice, per
  /// [SendSosUseCase]'s `notifiedByDevice` parameter. A returned id
  /// means the OS accepted the message for sending, not that the
  /// carrier has delivered it yet.
  Future<List<String>> sendToMany(
    Map<String, String> numbersById,
    String message,
  ) async {
    final granted = await _telephony.requestPhoneAndSmsPermissions;
    if (granted != true) return const [];

    final sent = <String>[];
    for (final entry in numbersById.entries) {
      try {
        await _telephony.sendSms(
          to: entry.value,
          message: message,
          isMultipart: true,
        );
        sent.add(entry.key);
      } catch (_) {
        // Skip this contact; the others still get attempted, and the
        // server-side send (for ids not in the returned list) covers it.
      }
    }
    return sent;
  }
}
