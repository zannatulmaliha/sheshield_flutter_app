import 'package:sheshield/core/cache/cache_box_interface.dart';
import '../../domain/entities/trusted_contact.dart';
import '../../domain/repositories/i_contacts_repository.dart';
import '../datasources/contacts_api_datasource.dart';

/// Thin adapter satisfying [IContactsRepository]. The list is cached
/// with a short TTL -- long enough to skip a redundant round-trip
/// when Home and the Contacts tab both mount in the same session,
/// short enough that a contact added elsewhere shows up quickly.
/// [add]/[remove] always invalidate the cache immediately rather than
/// waiting out the TTL, so the list never looks stale right after a
/// write the user just made.
class ContactsRepositoryImpl implements IContactsRepository {
  ContactsRepositoryImpl(this._dataSource, this._cache);
  final ContactsApiDataSource _dataSource;
  final CacheBox _cache;

  static const _cacheKey = 'contacts:list';
  static const _ttl = Duration(minutes: 2);

  @override
  Future<List<TrustedContact>> list() async {
    final cached = await _cache.read(_cacheKey, ttl: _ttl);
    if (cached != null) {
      final items = (cached['items'] as List).cast<Map<String, dynamic>>();
      return items.map(TrustedContact.fromJson).toList();
    }

    final contacts = await _dataSource.list();
    await _cache.write(_cacheKey, {
      'items': contacts.map((c) => c.toJson()).toList(),
    });
    return contacts;
  }

  @override
  Future<TrustedContact> add({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) async {
    final contact = await _dataSource.add(
      name: name,
      relation: relation,
      phone: phone,
      countryCode: countryCode,
    );
    await _cache.invalidate(_cacheKey);
    return contact;
  }

  @override
  Future<void> remove(String contactId) async {
    await _dataSource.remove(contactId);
    await _cache.invalidate(_cacheKey);
  }
}