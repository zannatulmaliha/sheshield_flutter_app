import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/helper/domain/entities/helper_status.dart';

part 'helper_status_model.freezed.dart';
part 'helper_status_model.g.dart';

/// Wire shape of `GET/PUT /helper/status`. Also the cached form (the
/// repository stores `toJson()`), so a cache read can never drift from
/// what the server sends.
@freezed
class HelperStatusModel with _$HelperStatusModel {
  const HelperStatusModel._();

  const factory HelperStatusModel({
    @Default(false) bool isActive,
    @Default(3.0) double radiusKm,
    @Default(false) bool mutualConnectionOptIn,
  }) = _HelperStatusModel;

  factory HelperStatusModel.fromJson(Map<String, dynamic> json) =>
      _$HelperStatusModelFromJson(json);

  HelperStatus toEntity() => HelperStatus(
        isActive: isActive,
        radiusKm: radiusKm,
        mutualConnectionOptIn: mutualConnectionOptIn,
      );
}
