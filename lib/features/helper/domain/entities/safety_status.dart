/// The live duress/connectivity signals for an alert a helper is currently
/// responding to -- see the Trust & Safety spec's §8. Polled, not pushed.
class SafetyStatus {
  const SafetyStatus({required this.duressActive, required this.connectivityLost});

  final bool duressActive;
  final bool connectivityLost;
}
