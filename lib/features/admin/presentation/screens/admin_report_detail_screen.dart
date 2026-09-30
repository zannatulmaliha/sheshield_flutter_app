import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/core/di/injection.dart';
import '../../domain/entities/admin_report_detail.dart';
import '../../domain/repositories/i_admin_repository.dart';
import '../../domain/usecases/get_report_detail_usecase.dart';
import '../../domain/usecases/review_report_usecase.dart';
import '../providers/admin_queue_provider.dart';

/// One report plus the reported account's full audit trail -- everything
/// a reviewer needs on one screen (mirrors `admin reports show <id>`).
/// Two independent actions live here: reviewing the report itself
/// (dismiss / actioned, with an optional false-SOS flag), and the spec's
/// §6 fast-track helper suspension, which is deliberately NOT gated on
/// the review being finished first -- a credible danger report suspends
/// immediately, review happens after.
class AdminReportDetailScreen extends ConsumerStatefulWidget {
  const AdminReportDetailScreen({super.key, required this.reportId});
  final String reportId;

  @override
  ConsumerState<AdminReportDetailScreen> createState() =>
      _AdminReportDetailScreenState();
}

class _AdminReportDetailScreenState
    extends ConsumerState<AdminReportDetailScreen> {
  late Future<AdminReportDetail> _future;
  final _resolutionController = TextEditingController();
  final _suspendReasonController = TextEditingController();
  bool _busy = false;
  bool _markFalseSos = false;

  @override
  void initState() {
    super.initState();
    _future = getIt<GetReportDetailUseCase>().call(widget.reportId);
  }

  @override
  void dispose() {
    _resolutionController.dispose();
    _suspendReasonController.dispose();
    super.dispose();
  }

  Future<void> _review(ReviewDecision decision) async {
    if (_resolutionController.text.trim().isEmpty) {
      _showSnack('A short resolution note is required.');
      return;
    }
    setState(() => _busy = true);
    try {
      await ref.read(adminQueueControllerProvider.notifier).review(
            reportId: widget.reportId,
            decision: decision,
            resolution: _resolutionController.text.trim(),
            markFalseSos: _markFalseSos,
          );
      if (mounted) Navigator.of(context).pop();
    } on AdminFailure catch (e) {
      _showSnack(e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _suspend(String uid) async {
    if (_suspendReasonController.text.trim().isEmpty) {
      _showSnack('A reason is required before suspending.');
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Suspend this helper now?'),
        content: const Text(
          'This immediately suspends them and releases any SOS they currently hold, '
          'before this report is reviewed. Use this only for a credible danger report -- '
          'ordinary abuse should go through Dismiss/Actioned instead.',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Suspend',
                style: TextStyle(color: AppTheme.accentRed)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _busy = true);
    try {
      final released =
          await ref.read(adminQueueControllerProvider.notifier).suspendHelper(
                uid: uid,
                reason: _suspendReasonController.text.trim(),
              );
      _showSnack(released != null
          ? 'Suspended. Released SOS $released to standby.'
          : 'Suspended.');
    } on AdminFailure catch (e) {
      _showSnack(e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.adminReportDetailTitle),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: FutureBuilder<AdminReportDetail>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          final detail = snapshot.data!;
          final report = detail.report;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
            children: [
              _sectionCard(colors, title: 'Report', children: [
                _row(colors, 'Category', report.category),
                _row(colors, 'Reported by', report.reporterRole),
                _row(colors, 'Status', report.reviewStatus),
                _row(
                    colors,
                    'Filed',
                    DateFormat.yMMMd()
                        .add_jm()
                        .format(report.createdAt.toLocal())),
                if (report.sosId != null)
                  _row(colors, 'Linked SOS', report.sosId!),
              ]),
              const SizedBox(height: 16),
              _sectionCard(colors,
                  title: 'Audit trail (reported account)',
                  children: [
                    if (detail.auditTrail.isEmpty)
                      Text('No audit entries.',
                          style: TextStyle(color: colors.textSecondary))
                    else
                      ...detail.auditTrail.map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${DateFormat.yMMMd().add_jm().format(e.createdAt.toLocal())} — ${e.action} (by ${e.actorId})',
                            style: TextStyle(
                                fontSize: 13, color: colors.textPrimary),
                          ),
                        ),
                      ),
                  ]),
              if (report.isPending) ...[
                const SizedBox(height: 16),
                _sectionCard(colors, title: 'Review', children: [
                  TextField(
                    controller: _resolutionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Resolution note (required)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  CheckboxListTile(
                    value: _markFalseSos,
                    onChanged: (v) =>
                        setState(() => _markFalseSos = v ?? false),
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Mark linked SOS as false (feeds review, never auto-restricts)',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _busy
                              ? null
                              : () => _review(ReviewDecision.dismissed),
                          child: const Text('Dismiss'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _busy
                              ? null
                              : () => _review(ReviewDecision.actioned),
                          child: const Text('Actioned'),
                        ),
                      ),
                    ],
                  ),
                ]),
                const SizedBox(height: 16),
                _sectionCard(colors,
                    title: 'Fast-track suspension (§6)',
                    children: [
                      Text(
                        'Only for a credible report that a helper endangered a requester. '
                        'Suspends immediately, before review completes.',
                        style: TextStyle(
                            fontSize: 12, color: colors.textSecondary),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _suspendReasonController,
                        decoration: const InputDecoration(
                          labelText: 'Reason (required)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.accentRed),
                          onPressed:
                              _busy ? null : () => _suspend(report.reportedId),
                          child: const Text('Suspend helper now'),
                        ),
                      ),
                    ]),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _sectionCard(AppPalette colors,
      {required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.textSecondary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: colors.textPrimary)),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _row(AppPalette colors, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 110,
              child: Text(label,
                  style: TextStyle(fontSize: 12, color: colors.textSecondary))),
          Expanded(
              child: Text(value,
                  style: TextStyle(fontSize: 13, color: colors.textPrimary))),
        ],
      ),
    );
  }
}
