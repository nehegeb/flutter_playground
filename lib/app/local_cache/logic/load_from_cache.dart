// load_from_cache.dart
//

import 'package:flutter_playground/app/local_cache/local_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Loads a specific [setting] from [SharedPreferences].
/// If the setting does not exist, it returns null.
Future<dynamic> loadFromCache({required String setting}) async {
  final prefs = await SharedPreferences.getInstance();

  // If the given [setting] is 'allSettings', return all settings.
  if (setting == 'allSettings') {
    return Map<String, dynamic>.fromEntries(
      prefs.getKeys().map((key) => MapEntry(key, prefs.get(key))),
    );
  }

  // Check if the given [setting] exists in [SharedPreferences].
  final settingExists = await LocalCache.check(setting: setting);
  if (!settingExists) {
    // Return null if the setting does not exist.
    return null;
  }

  // Try to get the given [setting] from [SharedPreferences] with its correct type.
  dynamic value;
  if (prefs.containsKey(setting)) {
    final object = prefs.get(setting);
    if (object is String) {
      value = prefs.getString(setting);
    } else if (object is int) {
      value = prefs.getInt(setting);
    } else if (object is double) {
      value = prefs.getDouble(setting);
    } else if (object is bool) {
      value = prefs.getBool(setting);
    } else if (object is List<String>) {
      value = prefs.getStringList(setting);
    } else {
      value = object;
    }
  } else {
    value = null;
  }

  return value;
}
