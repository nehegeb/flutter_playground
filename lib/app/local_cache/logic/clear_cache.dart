// clear_cache.dart
//

import 'package:shared_preferences/shared_preferences.dart';

/// Deletes all settings from [SharedPreferences].
Future<void> clearCache() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
