// ignore_for_file: invalid_annotation_target
// `@JsonKey` on a freezed constructor parameter is the documented freezed
// pattern; the analyzer's annotation-target check doesn't know freezed
// moves it onto the generated class, so it flags a false positive here.
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/features/chat/domain/entities/responder_state.dart';

part 'responder_state_model.freezed.dart';
part 'responder_state_model.g.dart';

/// Wire shape of `GET /alerts/{id}/responder`.
@freezed
class ResponderStateModel with _$ResponderStateModel {
  const ResponderStateModel._();

  const factory ResponderStateModel({
    @Default('') String status,
    @Default(false) bool helperAccepted,
    @JsonKey(name: 'helperProgress') @Default('') String progress,
  }) = _ResponderStateModel;

  factory ResponderStateModel.fromJson(Map<String, dynamic> json) =>
      _$ResponderStateModelFromJson(json);

  ResponderState toEntity() => ResponderState(
        status: status,
        helperAccepted: helperAccepted,
        progress: ResponderProgress.fromWireValue(progress),
      );
}
