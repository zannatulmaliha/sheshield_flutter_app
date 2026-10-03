/// Server-side state of the alert a helper holds.
enum LiveAlertStatus {
  accepted('accepted'),
  resolved('resolved'),
  active('active');

  const LiveAlertStatus(this.wireValue);

  final String wireValue;

  static LiveAlertStatus fromWireValue(String? value) =>
      LiveAlertStatus.values.firstWhere(
        (status) => status.wireValue == value,
        orElse: () => accepted,
      );
}
