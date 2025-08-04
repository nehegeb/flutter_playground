// local_cache.dart
//

import 'package:flutter_playground/app/local_cache/logic/check_in_cache.dart';
import 'package:flutter_playground/app/local_cache/logic/save_to_cache.dart';
import 'package:flutter_playground/app/local_cache/logic/load_from_cache.dart';
import 'package:flutter_playground/app/local_cache/logic/delete_from_cache.dart';
import 'package:flutter_playground/app/local_cache/logic/clear_cache.dart';

/// Utility class for saving and loading app settings using SharedPreferences.
///
/// Static Methods:
/// - [check]: Checks if a specific setting exists in local storage.
/// - [save]: Saves a given setting to local storage.
/// - [load]: Loads a given setting from local storage.
/// - [delete]: Deletes a given setting from local storage.
/// - [clear]: Clears all settings from local storage.
/// - [debug]: Displays all settings in local storage for debugging purposes.
class LocalCache {
  /// Check for a specific setting in SharedPreferences.
  /// Returns true if the setting exists, false otherwise.
  static Future<bool> check({required String setting}) async {
    return await checkInCache(setting: setting);
  }

  /// Save a specific setting to SharedPreferences.
  static Future<void> save({
    required String setting,
    required Object value,
  }) async {
    // Ensure the value is of a type that SharedPreferences can handle.
    assert(
      value is int ||
          value is double ||
          value is bool ||
          value is String ||
          value is List<String>,
      'Only int, double, bool, String, and List<String> are allowed for value.',
    );

    // Save the setting.
    await saveToCache(setting: setting, value: value);
  }

  /// Load a specific setting from SharedPreferences.
  static Future<dynamic> load({required String setting}) async {
    return await loadFromCache(setting: setting);
  }

  /// Delete a specific setting from SharedPreferences.
  static Future<void> delete({required String setting}) async {
    await deleteFromCache(setting: setting);
  }

  /// Delete all settings from SharedPreferences.
  static Future<void> clear() async {
    await clearCache();
  }

  /// Display all settings in SharedPreferences for debugging purposes.
  static Future<void> debug() async {
    final allSettings = await LocalCache.load(setting: 'allSettings');
    if (allSettings is Map<String, dynamic>) {
      print('All settings in local cache:');
      allSettings.forEach((key, value) {
        print('  $key - $value');
      });
    } else {
      print('No settings found in local cache.');
    }
  }
}
