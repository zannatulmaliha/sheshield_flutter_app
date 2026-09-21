import 'package:flutter/foundation.dart';
import '../models/saved_contact.dart';
import 'contact_cache.dart';
import 'contact_service.dart';

/// The single, shared list of the user's trusted contacts. The Home screen
/// (SOS button, "N contacts will be alerted") and the Contacts screen both
/// read from this, so they can never disagree.
///
/// Starts from the on-phone cache (instant, works offline), then refreshes
/// from the server.
class ContactsStore extends ChangeNotifier {
  ContactsStore({required this.userId, required this.onSessionExpired});

  final String userId;

  /// Called when the server rejects the login token.
  final VoidCallback onSessionExpired;

  final _service = ContactService();
  final _cache = ContactCache();

  List<SavedContact> contacts = const [];

  /// True until the first load finishes (from cache or server).
  bool loading = true;

  /// Set only when we have nothing to show and the server couldn't be reached.
  String? error;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  Future<void> init() async {
    final cached = await _cache.read(userId);
    if (cached != null) {
      contacts = cached;
      loading = false;
      _notify();
    }
    await refresh(showSpinner: cached == null);
  }

  Future<void> refresh({bool showSpinner = false}) async {
    if (showSpinner) {
      loading = true;
      error = null;
      _notify();
    }
    try {
      contacts = await _service.list();
      error = null;
      await _cache.write(userId, contacts);
    } on ContactException catch (e) {
      if (e.unauthorized) {
        onSessionExpired();
        return;
      }
      // If we already have contacts (cached), stay quiet and keep them.
      if (contacts.isEmpty) error = e.message;
    } catch (_) {
      if (contacts.isEmpty) error = 'Something went wrong. Please try again.';
    }
    loading = false;
    _notify();
  }

  /// Throws [ContactException] on failure (already handles an expired login).
  Future<SavedContact> add({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) async {
    try {
      final c = await _service.add(
        name: name,
        relation: relation,
        phone: phone,
        countryCode: countryCode,
      );
      contacts = [...contacts, c];
      await _cache.write(userId, contacts);
      _notify();
      return c;
    } on ContactException catch (e) {
      if (e.unauthorized) onSessionExpired();
      rethrow;
    }
  }

  Future<void> remove(String id) async {
    try {
      await _service.delete(id);
      contacts = contacts.where((c) => c.id != id).toList();
      await _cache.write(userId, contacts);
      _notify();
    } on ContactException catch (e) {
      if (e.unauthorized) onSessionExpired();
      rethrow;
    }
  }
}
