import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/report/domain/entities/blocked_user.dart';

part 'blocked_user_model.freezed.dart';
part 'blocked_user_model.g.dart';

/// Wire shape of one row of `GET /api/v1/blocks`.
@freezed
class BlockedUserModel with _$BlockedUserModel {
  const BlockedUserModel._();

  const factory BlockedUserModel({
    required String blockerId,
    required String blockedId,
    @DateTimeConverter() required DateTime createdAt,
  }) = _BlockedUserModel;

  factory BlockedUserModel.fromJson(Map<String, dynamic> json) =>
      _$BlockedUserModelFromJson(json);

  BlockedUser toEntity() => BlockedUser(
        blockerId: blockerId,
        blockedId: blockedId,
        createdAt: createdAt,
      );
}
