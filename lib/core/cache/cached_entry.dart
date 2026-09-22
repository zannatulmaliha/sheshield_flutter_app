import 'package:isar/isar.dart';

part 'cached_entry.g.dart';

/// One cached API response, stored as raw JSON text under an
/// arbitrary string key (e.g. "contacts:list", "helper:status").
/// [CacheBox] is the only thing that reads or writes this collection.
@collection
class CachedEntry {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String cacheKey;

  late String json;
  late DateTime cachedAt;
}
