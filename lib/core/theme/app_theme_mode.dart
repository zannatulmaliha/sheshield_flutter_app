/// The user's chosen appearance for the app's light-mode screens (Home,
/// Contacts, Profile, SOS, Notifications, Verification, Check-in). "system"
/// follows the device's own light/dark setting; Auth and Helper keep their
/// own fixed dark theme regardless of this choice (see AppTheme.dark).
enum AppThemeMode {
  system,
  light,
  dark;

  static AppThemeMode fromKey(String? key) => switch (key) {
        'light' => AppThemeMode.light,
        'dark' => AppThemeMode.dark,
        _ => AppThemeMode.system,
      };

  String get key => name;
}
