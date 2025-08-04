// check_in_cache.dart
//

import 'package:shared_preferences/shared_preferences.dart';

/// Checks if a specific setting exists in SharedPreferences.
/// Returns true if the setting exists, false otherwise.
Future<bool> checkInCache({required String setting}) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(setting) ? true : false;
}
