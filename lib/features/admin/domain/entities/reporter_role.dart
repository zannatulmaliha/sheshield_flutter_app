/// Who filed a report. `system` is an automated rate-limit flag.
enum ReporterRole {
  user('user'),
  helper('helper'),
  system('system'),
  unknown('');

  const ReporterRole(this.wireValue);

  final String wireValue;

  static ReporterRole fromWireValue(String? value) => ReporterRole.values
      .firstWhere((role) => role.wireValue == value, orElse: () => unknown);
}
