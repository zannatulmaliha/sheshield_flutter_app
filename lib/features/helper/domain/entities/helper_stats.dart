import 'package:freezed_annotation/freezed_annotation.dart';

part 'helper_stats.freezed.dart';

/// Dashboard numbers, computed on the server from the helper's real
/// response records (never hard-coded).
@freezed
class HelperStats with _$HelperStats {
  const HelperStats._();

  const factory HelperStats({
    @Default(0) int responses,
    @Default(0) int completed,
    @Default(0) int resolved,
    @Default(0) int successRate,
    double? avgResponseMinutes,
  }) = _HelperStats;

  String get avgLabel => avgResponseMinutes == null
      ? '--'
      : '${avgResponseMinutes!.round()}m';

  String get successLabel => completed == 0 ? '--' : '$successRate%';
}
