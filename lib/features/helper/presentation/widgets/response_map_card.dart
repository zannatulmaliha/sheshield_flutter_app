import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/core/utils/time_ago.dart';
import 'package:sheshield/features/helper/domain/entities/live_state.dart';
import 'package:url_launcher/url_launcher.dart';

/// Map pinned on the person, with a "Live - 2 min ago" badge once the first
/// live update has arrived.
class ResponseMapCard extends StatelessWidget {
  const ResponseMapCard({
    super.key,
    required this.point,
    required this.liveState,
    required this.palette,
  });

  final LatLng point;
  final LiveState? liveState;
  final AppPalette palette;

  String get _badgeText {
    final live = liveState;
    if (live == null) return 'Location at acceptance';
    final updatedAt = live.updatedAt;
    return 'Live${updatedAt == null ? '' : ' - ${formatTimeAgo(updatedAt)}'}';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 220,
        child: Stack(
          children: [
            FlutterMap(
              // New key per rounded position re-centres the map on updates.
              key: ValueKey(
                '${point.latitude.toStringAsFixed(4)},${point.longitude.toStringAsFixed(4)}',
              ),
              options: MapOptions(
                initialCenter: point,
                initialZoom: 15,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.sheshield.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: point,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: AppTheme.accentRed,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                RichAttributionWidget(
                  alignment: AttributionAlignment.bottomLeft,
                  showFlutterMapAttribution: false,
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: palette.surface.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _badgeText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: palette.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
