import 'package:geolocator/geolocator.dart';

/// Thin wrapper so nothing above core/ imports the geolocator plugin
/// directly. Returns null on any denial rather than throwing --
/// callers (e.g. HelperStatusController) decide how to react, instead
/// of a permission dialog surfacing as an unhandled exception.
class DeviceLocationService {
  Future<Position?> getCurrentPosition() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }
    return Geolocator.getCurrentPosition();
  }
}
