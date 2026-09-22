import 'package:sheshield/core/cache/cache_box_interface.dart';
import 'package:sheshield/core/cache/web_cache_box.dart';

Future<CacheBox> createCacheBox() async {
  return WebCacheBox();
}