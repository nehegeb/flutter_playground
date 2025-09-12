// load_changelog_data.dart
//
// This loads the changelog data from a JSON file.
// NOTE: This is read only! The JSON file cannot be modified during runtime.
// This is okay, because the changelog won't change during runtime.

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Map<String, dynamic>? changelogData;

/// Loads changelog JSON file and parses it into a map.
/// It loads the changelog for the specified [module].
/// If no module is specified, it loads the changelog for the main framework.
Future<void> loadChangelogData(String? module) async {
  // If no [module] is given, it defaults to the 'main' [AppMainModule].
  module = module != null && module.isNotEmpty ? module : 'main';

  // Load the changelog JSON file from the given [module].
  try {
    final file = 'lib/modules/$module/changelog/changelog.json';

    // Load the changelog data.
    final jsonData = await rootBundle.loadString(file);
    changelogData = json.decode(jsonData) as Map<String, dynamic>;
  } catch (e) {
    throw Exception('Loading changelog data failed: $e');
  }

  // Make sure the changelog data is loaded.
  if (changelogData == null) {
    throw Exception('Changelog data for module $module not loaded.');
  }
}
