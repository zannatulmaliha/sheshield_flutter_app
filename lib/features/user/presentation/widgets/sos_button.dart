import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_confirm_sheet.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_pulse_rings.dart';

/// Large pulsing SOS button. Tapping opens a confirmation sheet before the
/// emergency alert is sent.
class SosButton extends HookConsumerWidget {
  const SosButton({super.key, this.size = 132});

  static const _pulseDuration = Duration(milliseconds: 1800);

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final pulse = useAnimationController(duration: _pulseDuration);

    useEffect(() {
      pulse.repeat();
      return null;
    }, [pulse],);

    return GestureDetector(
      onTap: () => showSosConfirmSheet(context),
      child: SizedBox(
        width: size * 1.7,
        height: size * 1.7,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SosPulseRings(animation: pulse, buttonSize: size, color: palette.sosStart),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: palette.sosGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: palette.sosEnd.withValues(alpha: 0.45),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_moon_rounded, color: Colors.white, size: size * 0.30),
                  const SizedBox(height: 4),
                  Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: size * 0.18,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
