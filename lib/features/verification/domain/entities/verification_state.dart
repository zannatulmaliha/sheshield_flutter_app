/// Where a helper's ID review stands. Wire values match the backend's four
/// states (internal/verification).
enum VerificationState {
  none('none'),
  pending('pending'),
  approved('approved'),
  rejected('rejected');

  const VerificationState(this.wireValue);

  final String wireValue;

  /// Unknown values read as [none], which only ever offers the upload form.
  static VerificationState fromWireValue(String? value) =>
      VerificationState.values.firstWhere(
        (state) => state.wireValue == value,
        orElse: () => none,
      );
}
