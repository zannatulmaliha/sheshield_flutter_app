import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';

part 'blocked_user.freezed.dart';
part 'blocked_user.g.dart';

/// One row of GET /api/v1/blocks -- mirrors the Go backend's Block exactly
/// (internal/report/model.go). blockerId is always the caller's own uid;
/// kept for symmetry with the backend response rather than omitted.
@freezed
class BlockedUser with _$BlockedUser {
  const factory BlockedUser({
    required String blockerId,
    required String blockedId,
    @DateTimeConverter() required DateTime createdAt,
  }) = _BlockedUser;

  factory BlockedUser.fromJson(Map<String, dynamic> json) => _$BlockedUserFromJson(json);
}
