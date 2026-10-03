import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';

/// "Update response status" buttons plus Mark as resolved. Resolving is
/// only offered once the helper has arrived.
class ResponseStagePanel extends StatelessWidget {
  const ResponseStagePanel({
    super.key,
    required this.currentStage,
    required this.isBusy,
    required this.palette,
    required this.onStageSelected,
    required this.onResolve,
  });

  static const _selectableStages = [
    ResponseStage.enRoute,
    ResponseStage.arrived,
    ResponseStage.assisting,
  ];
  static const _doneColor = Color(0xFF16A34A);

  final ResponseStage currentStage;
  final bool isBusy;
  final AppPalette palette;
  final ValueChanged<ResponseStage> onStageSelected;
  final VoidCallback onResolve;

  String _labelFor(ResponseStage stage) => switch (stage) {
        ResponseStage.enRoute => 'En route to location',
        ResponseStage.arrived => 'Arrived at location',
        ResponseStage.assisting => 'Currently assisting',
        ResponseStage.none => 'Accepted',
      };

  IconData _iconFor(ResponseStage stage) => switch (stage) {
        ResponseStage.enRoute => Icons.navigation_rounded,
        ResponseStage.arrived => Icons.place_rounded,
        ResponseStage.assisting || ResponseStage.none => Icons.shield_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final hasArrived = currentStage.hasReached(ResponseStage.arrived);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Update response status',
            style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          for (final stage in _selectableStages)
            _StageButton(
              label: _labelFor(stage),
              icon: currentStage.hasReached(stage)
                  ? Icons.check_circle_rounded
                  : _iconFor(stage),
              isDone: currentStage.hasReached(stage),
              onPressed: isBusy || currentStage.hasReached(stage)
                  ? null
                  : () => onStageSelected(stage),
              palette: palette,
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isBusy || !hasArrived ? null : onResolve,
              icon: const Icon(Icons.verified_rounded),
              label: Text(
                hasArrived ? 'Mark as resolved' : 'Mark as resolved (after you arrive)',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _doneColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StageButton extends StatelessWidget {
  const _StageButton({
    required this.label,
    required this.icon,
    required this.isDone,
    required this.onPressed,
    required this.palette,
  });

  final String label;
  final IconData icon;
  final bool isDone;
  final VoidCallback? onPressed;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            foregroundColor:
                isDone ? ResponseStagePanel._doneColor : palette.textPrimary,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          ),
        ),
      ),
    );
  }
}
