import 'package:flutter/foundation.dart';
import 'package:telephony_sms/telephony_sms.dart';
import '../models/saved_contact.dart';

class DeviceSmsResult {
  const DeviceSmsResult({this.sentIds = const {}, this.failures = const {}});

  /// Contacts the phone confirmed it sent to.
  final Set<String> sentIds;

  /// contactId -> plain-language reason it didn't go out.
  final Map<String, String> failures;
}

/// Texts contacts from the phone's own SIM (Android only). Works on any
/// carrier and with no internet, because SMS uses the cellular network, not
/// mobile data. On iPhone, web and desktop this does nothing and the server
/// sends instead.
///
/// All use of the telephony_sms package is kept in this one file.
class DeviceSms {
  static bool get isSupported => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  final _sms = TelephonySMS();

  /// Returns whether we may send. Shows the system prompt if not yet decided.
  Future<bool> requestPermission() async {
    if (!isSupported) return false;
    try {
      return await _sms.requestPermission();
    } catch (_) {
      return false;
    }
  }

  /// One contact at a time, because Android throttles bursts of texts and the
  /// plugin confirms each send with the radio before returning.
  Future<DeviceSmsResult> sendAll({
    required List<SavedContact> contacts,
    required String message,
  }) async {
    if (!isSupported || !await requestPermission()) return const DeviceSmsResult();

    final sent = <String>{};
    final failures = <String, String>{};
    for (final c in contacts) {
      try {
        await _sms.sendSMS(phone: c.fullNumber, message: message);
        sent.add(c.id);
      } catch (e) {
        failures[c.id] = _reason(e);
      }
    }
    return DeviceSmsResult(sentIds: sent, failures: failures);
  }

  /// Turns the plugin's error code into something a person can act on.
  /// Reads `code.name` dynamically so this file doesn't depend on the
  /// plugin's exception class names.
  String _reason(Object e) {
    String code;
    try {
      code = (e as dynamic).code.name as String;
    } catch (_) {
      return "Couldn't text from this phone";
    }
    return switch (code) {
      'noSmsSubscription' || 'noDefaultSmsApp' => 'Set a default SIM for SMS in phone settings',
      'simAbsent' => 'No SIM card in this phone',
      'simError' => 'SIM card problem',
      'noService' || 'radioOff' || 'radioNotAvailable' => 'No mobile signal (or airplane mode)',
      'noTelephony' => "This device can't send SMS",
      'permissionDenied' || 'permissionNotDeclared' => 'SMS permission not granted',
      'limitExceeded' => 'Too many texts sent recently',
      'sendTimeout' => "Couldn't confirm the text was sent",
      _ => "Couldn't text from this phone",
    };
  }
}
