import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sheshield/core/cache/cache_box.dart';
import 'package:sheshield/core/cache/cache_box_interface.dart';
import 'package:sheshield/core/cache/cached_entry.dart';

Future<CacheBox> createCacheBox() async {
  final appDir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [CachedEntrySchema],
    directory: appDir.path,
  );

  return IsarCacheBox(isar);
}