/// The account's role: a plain user, a helper, or both. Chosen at signup.
enum UserType {
  user('user'),
  helper('helper'),
  userHelper('user_helper');

  const UserType(this.wireValue);

  final String wireValue;

  /// Unknown values read as a plain user: the least-privileged role.
  static UserType fromWireValue(String? value) => UserType.values
      .firstWhere((type) => type.wireValue == value, orElse: () => user);
}
