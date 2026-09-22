import 'dart:convert';

import 'package:isar/isar.dart';

import 'cached_entry.dart';
import 'cache_box_interface.dart';

class IsarCacheBox implements CacheBox {
  IsarCacheBox(this._isar);

  final Isar _isar;

  @override
  Future<Map<String, dynamic>?> read(
    String key, {
    required Duration ttl,
  }) async {
    final entry = await _isar.cachedEntrys
        .filter()
        .cacheKeyEqualTo(key)
        .findFirst();

    if (entry == null) return null;

    if (DateTime.now().difference(entry.cachedAt) > ttl) {
      return null;
    }

    return jsonDecode(entry.json) as Map<String, dynamic>;
  }

  @override
  Future<void> write(
    String key,
    Map<String, dynamic> value,
  ) async {
    final entry = CachedEntry()
      ..cacheKey = key
      ..json = jsonEncode(value)
      ..cachedAt = DateTime.now();

    await _isar.writeTxn(
      () => _isar.cachedEntrys.put(entry),
    );
  }

  @override
  Future<void> invalidate(String key) async {
    await _isar.writeTxn(
      () => _isar.cachedEntrys
          .filter()
          .cacheKeyEqualTo(key)
          .deleteAll(),
    );
  }
}