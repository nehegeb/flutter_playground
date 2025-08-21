// delete_from_cache.dart
//

import 'package:shared_preferences/shared_preferences.dart';

/// Deletes a specific setting from [SharedPreferences].
Future<void> deleteFromCache({required String setting}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(setting);
}
