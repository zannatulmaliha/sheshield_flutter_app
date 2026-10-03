/// How a past response ended.
enum ResponseOutcome {
  active('active'),
  resolved('resolved'),
  released('released');

  const ResponseOutcome(this.wireValue);

  final String wireValue;

  static ResponseOutcome fromWireValue(String? value) =>
      ResponseOutcome.values.firstWhere(
        (outcome) => outcome.wireValue == value,
        orElse: () => active,
      );
}
