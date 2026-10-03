import 'package:sheshield/core/cache/cache_box_interface.dart';
import 'package:sheshield/features/contacts/data/datasources/contacts_api_datasource.dart';
import 'package:sheshield/features/contacts/data/models/trusted_contact_model.dart';
import 'package:sheshield/features/contacts/domain/entities/contact_invite.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';
import 'package:sheshield/features/contacts/domain/repositories/contacts_repository.dart';

/// Caches the contact list briefly so Home and the Contacts tab mounting
/// together share one round-trip. Writes invalidate immediately so the
/// list never looks stale right after the person's own change.
class ContactsRepositoryImpl implements ContactsRepository {
  const ContactsRepositoryImpl(this._apiDataSource, this._cache);

  static const _cacheKey = 'contacts:list';
  static const _cacheTtl = Duration(minutes: 2);

  final ContactsApiDataSource _apiDataSource;
  final CacheBox _cache;

  @override
  Future<List<TrustedContact>> fetchContacts() async {
    final cachedModels = await _readCachedModels();
    if (cachedModels != null) return _toEntities(cachedModels);

    final models = await _apiDataSource.fetchContacts();
    await _cache.write(_cacheKey, {
      'items': models.map((model) => model.toJson()).toList(),
    });
    return _toEntities(models);
  }

  @override
  Future<TrustedContact> addContact({
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
  }) async {
    final model = await _apiDataSource.addContact(
      name: name,
      relation: relation,
      phone: phone,
      countryCode: countryCode,
    );
    await _cache.invalidate(_cacheKey);
    return model.toEntity();
  }

  @override
  Future<void> removeContact(String contactId) async {
    await _apiDataSource.removeContact(contactId);
    await _cache.invalidate(_cacheKey);
  }

  @override
  Future<ContactInvite> createInvite(String contactId) async =>
      (await _apiDataSource.createInvite(contactId)).toEntity();

  @override
  Future<void> acceptInvite(String code) => _apiDataSource.acceptInvite(code);

  Future<List<TrustedContactModel>?> _readCachedModels() async {
    final cached = await _cache.read(_cacheKey, ttl: _cacheTtl);
    if (cached == null) return null;
    final items = (cached['items'] as List).cast<Map<String, dynamic>>();
    return items.map(TrustedContactModel.fromJson).toList();
  }

  List<TrustedContact> _toEntities(List<TrustedContactModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
