import 'dart:convert';

import 'cache_box_interface.dart';

class WebCacheBox implements CacheBox {
  WebCacheBox();

  final Map<String, _CacheEntry> _cache = {};

  @override
  Future<Map<String, dynamic>?> read(
    String key, {
    required Duration ttl,
  }) async {
    final entry = _cache[key];

    if (entry == null) return null;

    if (DateTime.now().difference(entry.cachedAt) > ttl) {
      _cache.remove(key);
      return null;
    }

    return jsonDecode(entry.json) as Map<String, dynamic>;
  }

  @override
  Future<void> write(
    String key,
    Map<String, dynamic> value,
  ) async {
    _cache[key] = _CacheEntry(
      json: jsonEncode(value),
      cachedAt: DateTime.now(),
    );
  }

  @override
  Future<void> invalidate(String key) async {
    _cache.remove(key);
  }
}

class _CacheEntry {
  const _CacheEntry({
    required this.json,
    required this.cachedAt,
  });

  final String json;
  final DateTime cachedAt;
}