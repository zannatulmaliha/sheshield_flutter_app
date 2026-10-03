import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/auth/data/models/app_user_model.dart';

part 'auth_session_model.freezed.dart';
part 'auth_session_model.g.dart';

/// Wire shape of a login / signup response: `{ token, user }`.
@freezed
class AuthSessionModel with _$AuthSessionModel {
  const factory AuthSessionModel({
    required String token,
    required AppUserModel user,
  }) = _AuthSessionModel;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionModelFromJson(json);
}
