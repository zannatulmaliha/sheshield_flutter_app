/// `accepted` means a helper holds the alert (the only state with a chat).
enum AlertStatus {
  active('active'),
  accepted('accepted'),
  resolved('resolved');

  const AlertStatus(this.wireValue);

  final String wireValue;

  static AlertStatus fromWireValue(String? value) => AlertStatus.values
      .firstWhere((status) => status.wireValue == value, orElse: () => resolved);
}
