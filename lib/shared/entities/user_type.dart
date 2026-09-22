import 'package:json_annotation/json_annotation.dart';

/// The account's role. A signup screen lets the person choose this
/// (a plain "user", a "helper", or both).
enum UserType {
  @JsonValue('user')
  user,

  @JsonValue('helper')
  helper,

  @JsonValue('user_helper')
  userHelper,
}

extension UserTypeApi on UserType {
  String get apiValue => switch (this) {
        UserType.user => 'user',
        UserType.helper => 'helper',
        UserType.userHelper => 'user_helper',
      };

  static UserType fromApiValue(String value) => switch (value) {
        'helper' => UserType.helper,
        'user_helper' => UserType.userHelper,
        _ => UserType.user,
      };
}