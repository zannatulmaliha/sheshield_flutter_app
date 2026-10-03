import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_entry.freezed.dart';

/// One action recorded against the reported account.
@freezed
class AuditEntry with _$AuditEntry {
  const factory AuditEntry({
    required String id,
    required String actorId,
    required String action,
    required DateTime createdAt,
    String? targetId,
  }) = _AuditEntry;
}
