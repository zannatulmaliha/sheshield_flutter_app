/// A nearby SOS alert as seen by a helper before responding. Only a
/// rough area, distance and WHAT is happening (never who) are exposed here;
/// the exact address and phone number are revealed only after
/// AcceptAlertUseCase succeeds (see [AcceptedAlert]). The entity
/// structurally cannot carry precise coordinates or identity.
class NearbyAlert {
  const NearbyAlert({
    required this.id,
    this.roughArea = 'Nearby',
    required this.distanceMeters,
    required this.createdAt,
    this.mutualConnection = false,
    this.trigger = 'manual',
    this.label = 'SOS button pressed',
    this.riskLevel = 'high',
    this.duressActive = false,
  });

  final String id;
  final String roughArea;
  final double distanceMeters;
  final DateTime createdAt;
  final bool mutualConnection;

  /// What fired the SOS: manual | voice | motion_fall | motion_sprint |
  /// motion_struggle | motion_inactive | missed_checkin.
  final String trigger;

  /// Plain-language reason shown on the card ("Possible fall detected").
  final String label;

  /// "high" | "medium".
  final String riskLevel;
  final bool duressActive;

  bool get isHighRisk => riskLevel == 'high';

  factory NearbyAlert.fromJson(Map<String, dynamic> json) => NearbyAlert(
        id: json['id'] as String,
        roughArea: (json['roughArea'] as String?) ?? 'Nearby',
        distanceMeters: (json['distanceMeters'] as num).toDouble(),
        createdAt: DateTime.tryParse((json['createdAt'] as String?) ?? '') ?? DateTime.now(),
        mutualConnection: json['mutualConnection'] as bool? ?? false,
        trigger: (json['trigger'] as String?) ?? 'manual',
        label: (json['label'] as String?) ?? 'SOS button pressed',
        riskLevel: (json['riskLevel'] as String?) ?? 'high',
        duressActive: json['duressActive'] as bool? ?? false,
      );

  String get distanceLabel => distanceMeters < 1000
      ? '${distanceMeters.round()} m away'
      : '${(distanceMeters / 1000).toStringAsFixed(1)} km away';

  /// Rough walking/driving ETA at ~25 km/h average urban speed -- an
  /// estimate for triage only; the helper's map app gives the real one.
  int get etaMinutes => (distanceMeters / 1000 / 25 * 60).ceil().clamp(1, 999);
}
