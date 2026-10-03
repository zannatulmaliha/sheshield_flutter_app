enum RiskLevel {
  high('high'),
  medium('medium');

  const RiskLevel(this.wireValue);

  final String wireValue;

  /// Unknown values read as high: never under-state a possible emergency.
  static RiskLevel fromWireValue(String? value) => RiskLevel.values
      .firstWhere((level) => level.wireValue == value, orElse: () => high);
}
