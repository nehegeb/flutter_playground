// load_main_modules_data.dart
//

import 'dart:io';
import 'dart:convert';
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

List<dynamic>? mainModulesData;

/// Loads main modules JSON file and parses it into a list.
/// It loads the main modules of the app.
Future<void> loadMainModulesData() async {
  // Display a loading overlay while modules are being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(
    Localization.getText('modules.mainModulesDataLoading'),
  );

  // Load the main modules JSON file.
  try {
    final file = File('lib/app/modules/data/main_modules.json');

    // Load the main modules data.
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      mainModulesData = json.decode(jsonData) as List<dynamic>?;
    } else {
      mainModulesData = [];
    }
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the main modules are loaded.
  if (mainModulesData == null) {
    throw Exception('Main modules not loaded.');
  }
}
