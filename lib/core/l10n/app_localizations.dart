import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'SheShield'**
  String get appName;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Log in'**
  String get alreadyHaveAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @countryCode.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get countryCode;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get genderFemale;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get genderMale;

  /// No description provided for @genderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get genderOther;

  /// No description provided for @genderPreferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get genderPreferNotToSay;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get errorInvalidEmail;

  /// No description provided for @errorShortPassword.
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get errorShortPassword;

  /// No description provided for @errorInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get errorInvalidPhone;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @iWantTo.
  ///
  /// In en, this message translates to:
  /// **'I want to'**
  String get iWantTo;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get selectCountry;

  /// No description provided for @roleAskForHelp.
  ///
  /// In en, this message translates to:
  /// **'Ask for help'**
  String get roleAskForHelp;

  /// No description provided for @roleRespondToAlerts.
  ///
  /// In en, this message translates to:
  /// **'Respond to alerts'**
  String get roleRespondToAlerts;

  /// No description provided for @roleBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get roleBoth;

  /// No description provided for @onlyRoleAvailable.
  ///
  /// In en, this message translates to:
  /// **'{role} — the only role available for this account'**
  String onlyRoleAvailable(String role);

  /// No description provided for @helperDashboard.
  ///
  /// In en, this message translates to:
  /// **'Helper Dashboard'**
  String get helperDashboard;

  /// No description provided for @nearbyAlertsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No active alerts nearby} =1{1 alert nearby} other{{count} alerts nearby}}'**
  String nearbyAlertsCount(int count);

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @sendEmergencyAlert.
  ///
  /// In en, this message translates to:
  /// **'Send Emergency Alert?'**
  String get sendEmergencyAlert;

  /// No description provided for @sendEmergencyAlertBody.
  ///
  /// In en, this message translates to:
  /// **'Your trusted contacts will get your live location and a call for help immediately.'**
  String get sendEmergencyAlertBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @sendSos.
  ///
  /// In en, this message translates to:
  /// **'Send SOS'**
  String get sendSos;

  /// No description provided for @sosAlertSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert Sent'**
  String get sosAlertSentTitle;

  /// No description provided for @sosNotifiedFallback.
  ///
  /// In en, this message translates to:
  /// **'Your emergency contacts have been notified.'**
  String get sosNotifiedFallback;

  /// No description provided for @sosNotifiedAll.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 contact was notified} other{All {count} contacts were notified}}'**
  String sosNotifiedAll(int count);

  /// No description provided for @sosNotifiedPartial.
  ///
  /// In en, this message translates to:
  /// **'Notified {sent} of {total} contacts — {failed} failed to reach.'**
  String sosNotifiedPartial(int sent, int total, int failed);

  /// No description provided for @imSafe.
  ///
  /// In en, this message translates to:
  /// **'I\'m Safe'**
  String get imSafe;

  /// No description provided for @greetingHi.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name} 👋'**
  String greetingHi(String name);

  /// No description provided for @homeTagline.
  ///
  /// In en, this message translates to:
  /// **'{gender, select, female{Stay safe, stay confident} male{Watching out for the people you love} other{Stay strong, stay ready}}'**
  String homeTagline(String gender);

  /// No description provided for @tapForEmergencyAlert.
  ///
  /// In en, this message translates to:
  /// **'Tap for Emergency Alert'**
  String get tapForEmergencyAlert;

  /// No description provided for @youAreProtected.
  ///
  /// In en, this message translates to:
  /// **'You\'re Protected'**
  String get youAreProtected;

  /// No description provided for @liveLocationSharingCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Live location sharing is ON for 1 trusted contact} other{Live location sharing is ON for {count} trusted contacts}}'**
  String liveLocationSharingCount(int count);

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @fakeCall.
  ///
  /// In en, this message translates to:
  /// **'Fake Call'**
  String get fakeCall;

  /// No description provided for @shareLocation.
  ///
  /// In en, this message translates to:
  /// **'Share Location'**
  String get shareLocation;

  /// No description provided for @recordEvidence.
  ///
  /// In en, this message translates to:
  /// **'Record Evidence'**
  String get recordEvidence;

  /// No description provided for @safeRoute.
  ///
  /// In en, this message translates to:
  /// **'Safe Route'**
  String get safeRoute;

  /// No description provided for @checkInTimer.
  ///
  /// In en, this message translates to:
  /// **'Check-In Timer'**
  String get checkInTimer;

  /// No description provided for @checkInSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a check-in timer'**
  String get checkInSheetTitle;

  /// No description provided for @checkInSheetBody.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t check in before time\'s up, we\'ll automatically send an SOS with your live location to your trusted contacts.'**
  String get checkInSheetBody;

  /// No description provided for @checkInStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start {minutes}-minute timer'**
  String checkInStartButton(int minutes);

  /// No description provided for @checkInAlreadyRunningTitle.
  ///
  /// In en, this message translates to:
  /// **'Check-in already running'**
  String get checkInAlreadyRunningTitle;

  /// No description provided for @checkInAlreadyRunningBody.
  ///
  /// In en, this message translates to:
  /// **'{time} left before an automatic SOS goes out to your trusted contacts.'**
  String checkInAlreadyRunningBody(String time);

  /// No description provided for @checkInImSafeCancel.
  ///
  /// In en, this message translates to:
  /// **'I\'m Safe — Cancel'**
  String get checkInImSafeCancel;

  /// No description provided for @checkInBannerCountdown.
  ///
  /// In en, this message translates to:
  /// **'{time} until auto-SOS'**
  String checkInBannerCountdown(String time);

  /// No description provided for @checkInImSafe.
  ///
  /// In en, this message translates to:
  /// **'I\'m Safe'**
  String get checkInImSafe;

  /// No description provided for @checkInSosSentMessage.
  ///
  /// In en, this message translates to:
  /// **'You didn\'t check in in time — an SOS was sent automatically.'**
  String get checkInSosSentMessage;

  /// No description provided for @trustedContacts.
  ///
  /// In en, this message translates to:
  /// **'Trusted Contacts'**
  String get trustedContacts;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @addContactToEnableSos.
  ///
  /// In en, this message translates to:
  /// **'Add a contact to enable SOS'**
  String get addContactToEnableSos;

  /// No description provided for @contactsWillBeAlerted.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 contact will be alerted} other{{count} contacts will be alerted}}'**
  String contactsWillBeAlerted(int count);

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @emergencyInfo.
  ///
  /// In en, this message translates to:
  /// **'Emergency Info'**
  String get emergencyInfo;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @userTypeUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userTypeUser;

  /// No description provided for @userTypeHelper.
  ///
  /// In en, this message translates to:
  /// **'Helper'**
  String get userTypeHelper;

  /// No description provided for @userTypeUserHelper.
  ///
  /// In en, this message translates to:
  /// **'User & Helper'**
  String get userTypeUserHelper;

  /// No description provided for @homeAddress.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get homeAddress;

  /// No description provided for @tapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap to add'**
  String get tapToAdd;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotificationsYetTitle.
  ///
  /// In en, this message translates to:
  /// **'No alerts yet'**
  String get noNotificationsYetTitle;

  /// No description provided for @noNotificationsYetBody.
  ///
  /// In en, this message translates to:
  /// **'Your past SOS alerts will show up here.'**
  String get noNotificationsYetBody;

  /// No description provided for @alertStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get alertStatusActive;

  /// No description provided for @alertStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get alertStatusResolved;

  /// No description provided for @alertStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get alertStatusAccepted;

  /// No description provided for @privacyPermissions.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Permissions'**
  String get privacyPermissions;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose appearance'**
  String get chooseTheme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
