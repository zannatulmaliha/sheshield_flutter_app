/// No display strings live on the enum itself — [label] is the one place
/// that maps to UI text, so adding a language later only touches here.
enum Gender { female, male, other, preferNotToSay }

extension GenderJson on Gender {
  String get apiValue => switch (this) {
        Gender.female => 'female',
        Gender.male => 'male',
        Gender.other => 'other',
        Gender.preferNotToSay => 'preferNotToSay',
      };

  String get label => switch (this) {
        Gender.female => 'Female',
        Gender.male => 'Male',
        Gender.other => 'Other',
        Gender.preferNotToSay => 'Prefer not to say',
      };

  static Gender fromApi(String value) => Gender.values.firstWhere(
        (g) => g.apiValue == value,
        orElse: () => Gender.preferNotToSay,
      );
}
