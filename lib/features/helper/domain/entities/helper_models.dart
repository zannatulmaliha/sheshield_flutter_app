import 'accepted_alert.dart';

DateTime? _dt(Object? v) => v is String ? DateTime.tryParse(v) : null;

/// Dashboard numbers, computed on the server from the helper's real
/// response records (never hard-coded).
class HelperStats {
  const HelperStats({this.responses = 0, this.completed = 0, this.resolved = 0, this.successRate = 0, this.avgResponseMinutes});
  final int responses;
  final int completed;
  final int resolved;
  final int successRate;
  final double? avgResponseMinutes;

  factory HelperStats.fromJson(Map<String, dynamic> j) => HelperStats(
        responses: (j['responses'] as num?)?.toInt() ?? 0,
        completed: (j['completed'] as num?)?.toInt() ?? 0,
        resolved: (j['resolved'] as num?)?.toInt() ?? 0,
        successRate: (j['successRate'] as num?)?.toInt() ?? 0,
        avgResponseMinutes: (j['avgResponseMinutes'] as num?)?.toDouble(),
      );

  String get avgLabel => avgResponseMinutes == null ? '--' : '${avgResponseMinutes!.round()}m';
  String get successLabel => completed == 0 ? '--' : '$successRate%';
}

class HelperHistoryItem {
  const HelperHistoryItem({
    required this.id,
    required this.alertId,
    required this.label,
    required this.acceptedAt,
    required this.outcome,
    this.arrivedAt,
    this.endedAt,
    this.responseMinutes,
  });
  final String id;
  final String alertId;
  final String label;
  final DateTime acceptedAt;
  final DateTime? arrivedAt;
  final DateTime? endedAt;

  /// active | resolved | released
  final String outcome;
  final double? responseMinutes;

  factory HelperHistoryItem.fromJson(Map<String, dynamic> j) => HelperHistoryItem(
        id: j['id'] as String,
        alertId: j['alertId'] as String,
        label: (j['label'] as String?) ?? 'SOS',
        acceptedAt: _dt(j['acceptedAt']) ?? DateTime.now(),
        arrivedAt: _dt(j['arrivedAt']),
        endedAt: _dt(j['endedAt']),
        outcome: (j['outcome'] as String?) ?? 'active',
        responseMinutes: (j['responseMinutes'] as num?)?.toDouble(),
      );
}

enum ResponseStage {
  none,
  enRoute,
  arrived,
  assisting;

  String get wire => switch (this) {
        none => '',
        enRoute => 'en_route',
        arrived => 'arrived',
        assisting => 'assisting',
      };

  String get label => switch (this) {
        none => 'Accepted',
        enRoute => 'En route',
        arrived => 'Arrived',
        assisting => 'Assisting',
      };

  static ResponseStage parse(String? s) => switch (s) {
        'en_route' => enRoute,
        'arrived' => arrived,
        'assisting' => assisting,
        _ => none,
      };
}

/// The helper's in-progress response (GET /helper/responses/current).
class MyResponse {
  const MyResponse({
    required this.alert,
    required this.stage,
    required this.label,
    required this.riskLevel,
    required this.duressActive,
  });
  final AcceptedAlert alert;
  final ResponseStage stage;
  final String label;
  final String riskLevel;
  final bool duressActive;

  factory MyResponse.fromJson(Map<String, dynamic> j) => MyResponse(
        alert: AcceptedAlert.fromJson(j),
        stage: ResponseStage.parse(j['progress'] as String?),
        label: (j['label'] as String?) ?? 'SOS',
        riskLevel: (j['riskLevel'] as String?) ?? 'high',
        duressActive: j['duressActive'] as bool? ?? false,
      );
}

/// Polled while responding (GET /helper/alerts/{id}/live).
class LiveState {
  const LiveState({
    required this.status,
    this.latitude,
    this.longitude,
    this.updatedAt,
    this.stage = ResponseStage.none,
    this.duressActive = false,
    this.connectivityLost = false,
  });
  final String status; // accepted | resolved | active
  final double? latitude;
  final double? longitude;
  final DateTime? updatedAt;
  final ResponseStage stage;
  final bool duressActive;
  final bool connectivityLost;

  bool get isOpen => status == 'accepted';
  bool get endedByRequester => status == 'resolved';
  bool get lostLock => status == 'active';

  factory LiveState.fromJson(Map<String, dynamic> j) => LiveState(
        status: (j['status'] as String?) ?? 'accepted',
        latitude: (j['latitude'] as num?)?.toDouble(),
        longitude: (j['longitude'] as num?)?.toDouble(),
        updatedAt: _dt(j['updatedAt']),
        stage: ResponseStage.parse(j['progress'] as String?),
        duressActive: j['duressActive'] as bool? ?? false,
        connectivityLost: j['connectivityLost'] as bool? ?? false,
      );
}
