// load_sub_modules_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

List<dynamic>? subModules;

/// Loads sub modules JSON files and parses them into maps.
/// It loads the sub modules of the app.
Future<void> loadSubModulesData() async {
  // Display a loading overlay while modules are being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('modules.subModulesLoading'));

  // Load the sub modules file.
  try {
    // Load the sub modules.
    final jsonData = await rootBundle.loadString(
      'lib/app/modules/data/sub_modules.json',
    );
    subModules = json.decode(jsonData) as List<dynamic>;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the sub modules are loaded.
  if (subModules == null) {
    throw Exception('Sub modules not loaded.');
  }
}
