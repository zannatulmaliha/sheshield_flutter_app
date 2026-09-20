import 'gender.dart';

/// "user" = protected person, "helper" = responder, "userHelper" = both.
/// Product rule (matches the Go backend's own validation — this is a UI
/// convenience, not the enforcement point): only Gender.female may be a
/// user or userHelper. Everyone else can only be a helper.
enum UserType { user, helper, userHelper }

extension UserTypeJson on UserType {
  String get apiValue => switch (this) {
        UserType.user => 'user',
        UserType.helper => 'helper',
        UserType.userHelper => 'user_helper',
      };

  String get label => switch (this) {
        UserType.user => 'User',
        UserType.helper => 'Helper',
        UserType.userHelper => 'Both',
      };

  static UserType fromApi(String value) => switch (value) {
        'helper' => UserType.helper,
        'user_helper' => UserType.userHelper,
        _ => UserType.user,
      };
}

/// The options to show for a given gender, in display order. Female sees
/// all three; everyone else only ever sees Helper.
List<UserType> allowedUserTypesFor(Gender gender) {
  if (gender == Gender.female) {
    return [UserType.user, UserType.helper, UserType.userHelper];
  }
  return [UserType.helper];
}
