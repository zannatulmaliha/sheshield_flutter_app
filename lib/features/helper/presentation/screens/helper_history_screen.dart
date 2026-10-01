import 'package:flutter/material.dart';
import 'package:sheshield/features/helper/presentation/helper_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/features/helper/domain/entities/helper_models.dart';
import '../providers/helper_extras_provider.dart';

class HelperHistoryScreen extends ConsumerWidget {
  const HelperHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(helperHistoryProvider);
    return RefreshIndicator(
      onRefresh: () async => ref.refresh(helperHistoryProvider.future),
      child: history.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => ListView(children: [Padding(padding: EdgeInsets.all(32), child: Center(child: Text('$e')))]),
        data: (items) => items.isEmpty
            ? ListView(children: [Padding(padding: EdgeInsets.all(48), child: Center(child: Text('No responses yet.\nAlerts you accept will show up here.', textAlign: TextAlign.center, style: TextStyle(color: context.hp.textSecondary))))])
            : ListView.separated(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 110),
                itemCount: items.length,
                separatorBuilder: (_, __) => SizedBox(height: 10),
                itemBuilder: (_, i) => _HistoryCard(item: items[i]),
              ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.item});
  final HelperHistoryItem item;

  @override
  Widget build(BuildContext context) {
    final (color, text, icon) = switch (item.outcome) {
      'resolved' => (Color(0xFF16A34A), 'Resolved', Icons.check_circle_rounded),
      'released' => (Color(0xFFD97706), 'Handed back', Icons.undo_rounded),
      _ => (Color(0xFF2563EB), 'In progress', Icons.directions_run_rounded),
    };
    final d = item.acceptedAt.toLocal();
    final date = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(color: context.hp.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Icon(icon, color: color, size: 30),
        SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.label, style: TextStyle(color: context.hp.textPrimary, fontWeight: FontWeight.w800)),
            SizedBox(height: 2),
            Text(date, style: TextStyle(color: context.hp.textSecondary, fontSize: 12)),
            if (item.responseMinutes != null)
              Text('Arrived in ${item.responseMinutes!.round()} min', style: TextStyle(color: context.hp.textSecondary, fontSize: 12)),
          ]),
        ),
        Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12)),
      ]),
    );
  }
}