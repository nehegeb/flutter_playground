// save_to_cache.dart
//

import 'package:shared_preferences/shared_preferences.dart';

/// Saves a specific [setting] with the given [value] to [SharedPreferences].
Future<void> saveToCache({
  required String setting,
  required Object value,
}) async {
  // Ensure the given [value] is of a type that [SharedPreferences] can handle.
  assert(
    value is int ||
        value is double ||
        value is bool ||
        value is String ||
        value is List<String>,
    'Only int, double, bool, String, and List<String> are allowed for value.',
  );

  // Save the given [setting] with the given [value] to [SharedPreferences], depending on its type.
  final prefs = await SharedPreferences.getInstance();
  if (value is String) {
    await prefs.setString(setting, value);
  } else if (value is int) {
    await prefs.setInt(setting, value);
  } else if (value is double) {
    await prefs.setDouble(setting, value);
  } else if (value is bool) {
    await prefs.setBool(setting, value);
  } else if (value is List<String>) {
    await prefs.setStringList(setting, value);
  }
}
