/// One contact's delivery outcome. `simulated` means the server's SMS is
/// log-only (dev): nothing really went out.
enum DeliveryStatus {
  sent('sent'),
  simulated('simulated'),
  failed('failed');

  const DeliveryStatus(this.wireValue);

  final String wireValue;

  /// Unknown values read as failed: never claim a delivery we can't confirm.
  static DeliveryStatus fromWireValue(String? value) => DeliveryStatus.values
      .firstWhere((status) => status.wireValue == value, orElse: () => failed);
}
