enum DangerZoneRisk {
  low('low'),
  medium('medium'),
  high('high');

  const DangerZoneRisk(this.wireValue);

  final String wireValue;

  /// Unknown values read as low: an unrecognized tier should never paint a
  /// cell as more alarming than the data actually says.
  static DangerZoneRisk fromWireValue(String? value) => DangerZoneRisk.values
      .firstWhere((level) => level.wireValue == value, orElse: () => low);
}
