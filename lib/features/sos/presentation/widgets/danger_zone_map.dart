import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/sos/domain/entities/danger_zone.dart';
import 'package:sheshield/features/sos/domain/entities/danger_zone_risk.dart';
import 'package:url_launcher/url_launcher.dart';

/// ~1.1km grid cells need slightly more than half their size as a circle
/// radius so adjacent cells visually tile without gaps.
const _zoneCircleRadiusMeters = 600.0;

Color _colorFor(DangerZoneRisk risk, AppPalette palette) => switch (risk) {
      DangerZoneRisk.low => palette.success,
      DangerZoneRisk.medium => palette.warning,
      DangerZoneRisk.high => palette.sosEnd,
    };

/// The Danger Zone heat map: same `FlutterMap`/`TileLayer` (OpenStreetMap)
/// setup as `ResponseMapCard`, with one colored circle per grid cell
/// instead of a single marker.
class DangerZoneMap extends StatelessWidget {
  const DangerZoneMap({
    super.key,
    required this.center,
    required this.zones,
    required this.palette,
  });

  final LatLng center;
  final List<DangerZone> zones;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: center,
        initialZoom: 14,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.sheshield.app',
        ),
        CircleLayer(
          circles: [
            for (final zone in zones)
              CircleMarker(
                point: LatLng(zone.latitude, zone.longitude),
                radius: _zoneCircleRadiusMeters,
                useRadiusInMeter: true,
                color: _colorFor(zone.riskLevel, palette).withValues(alpha: 0.35),
                borderStrokeWidth: 0,
              ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: center,
              width: 32,
              height: 32,
              child: Icon(Icons.my_location, color: palette.textPrimary, size: 28),
            ),
          ],
        ),
        RichAttributionWidget(
          alignment: AttributionAlignment.bottomLeft,
          showFlutterMapAttribution: false,
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}
