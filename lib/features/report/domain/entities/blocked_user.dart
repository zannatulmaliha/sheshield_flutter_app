import 'package:freezed_annotation/freezed_annotation.dart';

part 'blocked_user.freezed.dart';

/// Someone the signed-in person has blocked. `blockerId` is always the
/// caller's own uid; kept so the entity mirrors what the server tracks.
@freezed
class BlockedUser with _$BlockedUser {
  const factory BlockedUser({
    required String blockerId,
    required String blockedId,
    required DateTime createdAt,
  }) = _BlockedUser;
}
