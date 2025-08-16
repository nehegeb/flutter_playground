// load_main_modules_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

List<dynamic>? mainModules;

/// Loads main modules JSON files and parses them into maps.
/// It loads the main modules of the app.
Future<void> loadMainModulesData() async {
  // Display a loading overlay while modules are being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('modules.mainModulesLoading'));

  // Load the main modules file.
  try {
    // Load the main modules.
    final jsonData = await rootBundle.loadString(
      'lib/app/modules/data/main_modules.json',
    );
    mainModules = json.decode(jsonData) as List<dynamic>;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the main modules are loaded.
  if (mainModules == null) {
    throw Exception('Main modules not loaded.');
  }
}
