// load_changelog_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

Map<String, dynamic>? changelog;

/// Loads changelog JSON files and parses them into maps.
/// It loads the changelog for the specified module.
/// If no moudule is specified, it loads the changelog for the main framework.
Future<void> loadChangelogData(String? module) async {
  // Display a loading overlay while changelog is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('changelog.loading'));

  // Specify the path to the changelog file based on the module.
  String modulePath = '';
  if (module == null || module.isEmpty || module == 'main') {
    modulePath = 'lib/app/changelog/data/changelog.json';
  } else {
    modulePath = 'lib/modules/$module/changelog/changelog.json';
  }

  // Load the changelog file from the specified module.
  try {
    // Load the changelog.
    final jsonData = await rootBundle.loadString(modulePath);
    changelog = json.decode(jsonData) as Map<String, dynamic>;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the changelog is loaded.
  if (changelog == null) {
    throw Exception('Changelog for module $module not loaded.');
  }
}
