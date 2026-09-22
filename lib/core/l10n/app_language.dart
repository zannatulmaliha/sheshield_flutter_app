import 'package:flutter/widgets.dart';

/// Every language SheShield ships with. Adding one means: add a case
/// here, add `app_<code>.arb`, add the locale to `l10n.yaml`'s
/// generated `supportedLocales` (done for you by `flutter gen-l10n`),
/// and register it in [LocaleRepositoryImpl.parse].
enum AppLanguage {
  english('en'),
  bangla('bn');

  const AppLanguage(this.languageCode);

  final String languageCode;

  Locale get locale => Locale(languageCode);

  /// Shown inside the language's own script, not translated -- a
  /// language's own name is conventionally never localized (English
  /// speakers still see "বাংলা" in the picker, not "Bangla").
  String get nativeName => switch (this) {
        AppLanguage.english => 'English',
        AppLanguage.bangla => 'বাংলা',
      };

  static AppLanguage? fromLanguageCode(String? code) => switch (code) {
        'en' => AppLanguage.english,
        'bn' => AppLanguage.bangla,
        _ => null,
      };
}