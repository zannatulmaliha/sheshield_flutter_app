abstract class CacheBox {
  Future<Map<String, dynamic>?> read(
    String key, {
    required Duration ttl,
  });

  Future<void> write(
    String key,
    Map<String, dynamic> value,
  );

  Future<void> invalidate(String key);
}