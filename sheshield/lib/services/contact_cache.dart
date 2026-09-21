import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/saved_contact.dart';

/// A copy of the signed-in user's trusted contacts, kept on the phone so an
/// SOS can text them even when there's no internet to ask the server.
/// Stored in secure storage because phone numbers are personal data.
class ContactCache {
  static const _key = 'sheshield_contacts_cache';
  final _storage = const FlutterSecureStorage();

  /// Returns null if there's no cache, or it belongs to a different user.
  Future<List<SavedContact>?> read(String userId) async {
    try {
      final raw = await _storage.read(key: _key);
      if (raw == null) return null;
      final json = jsonDecode(raw) as Map<String, dynamic>;
      if (json['userId'] != userId) return null;
      return (json['contacts'] as List<dynamic>)
          .map((e) => SavedContact.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null; // a broken cache is the same as no cache
    }
  }

  Future<void> write(String userId, List<SavedContact> contacts) async {
    try {
      await _storage.write(
        key: _key,
        value: jsonEncode({
          'userId': userId,
          'contacts': contacts.map((c) => c.toJson()).toList(),
        }),
      );
    } catch (_) {
      // Caching is a convenience; never fail the real operation because of it.
    }
  }

  Future<void> clear() async {
    try {
      await _storage.delete(key: _key);
    } catch (_) {}
  }
}
