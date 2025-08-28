// load_sub_modules_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

List<dynamic>? subModulesData;

/// Loads sub modules JSON file and parses it into a list.
/// It loads the sub modules of the app.
Future<void> loadSubModulesData() async {
  // Display a loading overlay while modules are being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(
    Localization.getText('modules.subModulesDataLoading'),
  );

  // Load the sub modules JSON file.
  try {
    // Load the sub modules data.
    final jsonData = await rootBundle.loadString(
      'lib/app/modules/data/sub_modules.json',
    );
    subModulesData = json.decode(jsonData) as List<dynamic>;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the sub modules are loaded.
  if (subModulesData == null) {
    throw Exception('Sub modules not loaded.');
  }
}
