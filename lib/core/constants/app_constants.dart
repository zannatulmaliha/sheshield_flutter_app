/// App-wide constants. No secrets belong in this file.
/// API keys are injected at build time via --dart-define / native config
/// (see README "Secrets & API Keys") — never hardcoded here.
class AppConstants {
  AppConstants._();

  static const String appName = 'SheShield';
  static const String prefsVoiceEnabled = 'voice_protection_enabled';

  // Firestore collection names
  static const String usersCollection = 'users';
  static const String contactsSubcollection = 'trustedContacts';
  static const String alertsCollection = 'alerts';
  static const String sosHistorySubcollection = 'sos_alerts';

  // Cloud Function names (must exist in functions/ and be deployed —
  // see README "Backend functions" for why this matters)
  static const String fnSendSosPush = 'sendSOSNotification';
  static const String fnSendSosEmail = 'sendSOSEmails';

  static const int sosCountdownSeconds = 5;
  static const int minContactPhoneLength = 8;
  static const int maxTrustedContacts = 10;
}
