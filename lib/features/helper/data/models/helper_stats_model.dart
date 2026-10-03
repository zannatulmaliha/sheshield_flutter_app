import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/helper_stats.dart';

part 'helper_stats_model.freezed.dart';
part 'helper_stats_model.g.dart';

/// Wire shape of `GET /helper/stats`.
@freezed
class HelperStatsModel with _$HelperStatsModel {
  const HelperStatsModel._();

  const factory HelperStatsModel({
    @Default(0) int responses,
    @Default(0) int completed,
    @Default(0) int resolved,
    @Default(0) int successRate,
    double? avgResponseMinutes,
  }) = _HelperStatsModel;

  factory HelperStatsModel.fromJson(Map<String, dynamic> json) =>
      _$HelperStatsModelFromJson(json);

  HelperStats toEntity() => HelperStats(
        responses: responses,
        completed: completed,
        resolved: resolved,
        successRate: successRate,
        avgResponseMinutes: avgResponseMinutes,
      );
}
