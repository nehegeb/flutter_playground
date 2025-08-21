// load_changelog_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

Map<String, dynamic>? changelogData;

/// Loads changelog JSON file and parses it into a map.
/// It loads the changelog for the specified [module].
/// If no module is specified, it loads the changelog for the main framework.
Future<void> loadChangelogData(String? module) async {
  // Display a loading overlay while changelog is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(
    Localization.getText('changelog.changelogDataLoading'),
  );

  // Specify the path to the changelog JSON file based on the given [module].
  String modulePath = '';
  if (module == null || module.isEmpty || module == 'main') {
    modulePath = 'lib/app/changelog/data/changelog.json';
  } else {
    modulePath = 'lib/modules/$module/changelog/changelog.json';
  }

  // Load the changelog JSON file from the given [module].
  try {
    // Load the changelog data.
    final jsonData = await rootBundle.loadString(modulePath);
    changelogData = json.decode(jsonData) as Map<String, dynamic>;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the changelog data is loaded.
  if (changelogData == null) {
    throw Exception('Changelog data for module $module not loaded.');
  }
}
