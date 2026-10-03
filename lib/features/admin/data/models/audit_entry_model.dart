import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/admin/domain/entities/audit_entry.dart';

part 'audit_entry_model.freezed.dart';
part 'audit_entry_model.g.dart';

/// Wire shape of one `audit.Entry` of the reported account's trail.
@freezed
class AuditEntryModel with _$AuditEntryModel {
  const AuditEntryModel._();

  const factory AuditEntryModel({
    @Default('') String id,
    @Default('') String actorId,
    @Default('') String action,
    @DateTimeConverter() required DateTime createdAt,
    String? targetId,
  }) = _AuditEntryModel;

  factory AuditEntryModel.fromJson(Map<String, dynamic> json) =>
      _$AuditEntryModelFromJson(json);

  AuditEntry toEntity() => AuditEntry(
        id: id,
        actorId: actorId,
        action: action,
        createdAt: createdAt,
        targetId: targetId,
      );
}
