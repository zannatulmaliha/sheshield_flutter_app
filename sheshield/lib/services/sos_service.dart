import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../core/network/api_client.dart';
import '../models/saved_contact.dart';
import 'device_sms.dart';

/// How (or whether) one contact was reached.
enum Delivery { fromPhone, byServer, notDelivered }

class ContactOutcome {
  const ContactOutcome(this.contact, this.delivery, {this.detail});

  final SavedContact contact;
  final Delivery delivery;

  /// For failures: why, in plain language.
  final String? detail;

  bool get delivered => delivery != Delivery.notDelivered;
}

class SosResult {
  const SosResult({required this.outcomes, required this.hadLocation});

  final List<ContactOutcome> outcomes;

  /// False if we couldn't get a location, so the texts had no map link.
  final bool hadLocation;

  int get total => outcomes.length;
  int get deliveredCount => outcomes.where((o) => o.delivered).length;
  bool get allDelivered => deliveredCount == total;
  bool get noneDelivered => deliveredCount == 0;
  List<ContactOutcome> get failed => outcomes.where((o) => !o.delivered).toList();
}

/// Thrown when an SOS can't even be attempted.
class SosException implements Exception {
  const SosException(this.message);
  final String message;

  @override
  String toString() => message;
}

class _ServerDelivery {
  const _ServerDelivery(this.status, this.error);
  final String status; // sent | simulated | failed
  final String? error;
}

class _ServerReport {
  const _ServerReport.reached(this.byContact) : failure = null;
  const _ServerReport.unreachable(this.failure) : byContact = const {};

  final Map<String, _ServerDelivery> byContact;
  final String? failure;
}

/// The SOS flow:
///  1. get the location (never blocks the alert if it can't be had)
///  2. text every contact from this phone's SIM (Android)
///  3. tell the server who that covered; the server texts everyone else
/// and report exactly which contacts were reached and how.
class SosService {
  final _device = DeviceSms();
  final _dio = ApiClient.instance.dio;

  /// Ask for permissions up front, so the SOS itself isn't interrupted by
  /// system dialogs. Denials are fine: the flow degrades instead of failing.
  Future<void> requestPermissions() async {
    try {
      if (await Geolocator.isLocationServiceEnabled()) {
        final permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          await Geolocator.requestPermission();
        }
      }
    } catch (_) {}
    await _device.requestPermission();
  }

  Future<SosResult> trigger({
    required String userName,
    required List<SavedContact> contacts,
  }) async {
    if (contacts.isEmpty) {
      throw const SosException('Add at least one trusted contact first.');
    }

    final position = await _locate();
    final message = _buildMessage(userName, position);

    final device = await _device.sendAll(contacts: contacts, message: message);
    final server = await _notifyServer(position, device.sentIds);

    final outcomes = <ContactOutcome>[];
    for (final c in contacts) {
      if (device.sentIds.contains(c.id)) {
        outcomes.add(ContactOutcome(c, Delivery.fromPhone));
        continue;
      }
      final s = server.byContact[c.id];
      if (s != null && s.status == 'sent') {
        outcomes.add(ContactOutcome(c, Delivery.byServer));
        continue;
      }

      final reasons = <String>[
        if (device.failures[c.id] != null) device.failures[c.id]!,
        if (s != null && s.status == 'simulated')
          "Server texting isn't set up yet"
        else if (s != null)
          (s.error ?? 'Delivery failed')
        else if (server.failure != null)
          server.failure!,
      ];
      outcomes.add(ContactOutcome(
        c,
        Delivery.notDelivered,
        detail: reasons.isEmpty ? 'Not delivered' : reasons.join(' · '),
      ));
    }

    return SosResult(outcomes: outcomes, hadLocation: position != null);
  }

  /// Best effort. A missing location must never stop an SOS.
  Future<Position?> _locate() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return null;
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 6),
        ),
      ).timeout(const Duration(seconds: 8));
    } catch (_) {
      // Timed out or failed: fall back to the last place the phone knew.
      try {
        return await Geolocator.getLastKnownPosition();
      } catch (_) {
        return null; // e.g. web, which has no "last known"
      }
    }
  }

  // Keep in sync with buildMessage in the backend (internal/alert/message.go).
  String _buildMessage(String name, Position? p) {
    if (p == null) return 'SheShield SOS: $name needs help. Location unavailable.';
    final lat = p.latitude.toStringAsFixed(6);
    final lng = p.longitude.toStringAsFixed(6);
    return 'SheShield SOS: $name needs help. Location: https://maps.google.com/?q=$lat,$lng';
  }

  Future<_ServerReport> _notifyServer(Position? position, Set<String> sentByPhone) async {
    try {
      final res = await _dio.post('/api/v1/alerts', data: {
        'latitude': position?.latitude,
        'longitude': position?.longitude,
        'accuracyMeters': position?.accuracy,
        'notifiedByDevice': sentByPhone.toList(),
      });
      final list = res.data['data']['deliveries'] as List<dynamic>;
      final byContact = <String, _ServerDelivery>{};
      for (final raw in list) {
        final d = raw as Map<String, dynamic>;
        byContact[d['contactId'] as String] =
            _ServerDelivery(d['status'] as String, d['error'] as String?);
      }
      return _ServerReport.reached(byContact);
    } on DioException catch (e) {
      return _ServerReport.unreachable(ApiClient.messageFromError(e));
    } catch (_) {
      return const _ServerReport.unreachable('Unexpected reply from the server');
    }
  }
}
