import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheManager {
  static Future<void> saveDataToCache(
      String key, String jsonData) async {
    final file = await DefaultCacheManager().putFile(
      key,
      utf8.encode(jsonData),
    );
  }

  static Future<Map<String, dynamic>> loadDataFromCache(String key) async {
    final file = await DefaultCacheManager().getFileFromCache(key);
    if (file != null) {
      return jsonDecode(utf8.decode(await file.file.readAsBytes()));
    } else {
      return {};
    }
  }

  static Future<List<Map<String, dynamic>>> loadArrayDataFromCache(String key) async {
    final file = await DefaultCacheManager().getFileFromCache(key);
    if (file != null) {
      return jsonDecode(utf8.decode(await file.file.readAsBytes()));
    } else {
      return [];
    }
  }
}
