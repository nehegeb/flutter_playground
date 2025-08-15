// load_modules_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

Map<String, dynamic>? modules;

/// Loads modules JSON files and parses them into maps.
/// It loads the modules of the app.
Future<void> loadModulesData() async {
  // Display a loading overlay while modules are being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('modules.loading'));

  // Load the modules file.
  try {
    // Load the modules.
    final jsonData = await rootBundle.loadString(
      'lib/app/modules/data/modules.json',
    );
    modules = json.decode(jsonData) as Map<String, dynamic>;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the modules are loaded.
  if (modules == null) {
    throw Exception('Modules not loaded.');
  }
}
