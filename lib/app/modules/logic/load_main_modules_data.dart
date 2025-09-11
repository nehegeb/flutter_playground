// load_main_modules_data.dart
//
// This loads the main modules data from a JSON file.
// NOTE: This must be read and write, because the data might change during runtime.
// NOTE: This won't work for web apps, because web apps cannot access local files!
//
// DEV: For web apps, the JSON file needs to be outsourced into a proper database!

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

List<dynamic>? mainModulesData;

/// Loads main modules JSON file and parses it into a list.
/// It loads the main modules of the app.
Future<void> loadMainModulesData() async {
  if (kIsWeb) {
    // Web apps cannot access local files! Remove this exception after switching to a proper database.
    appRouter.go('/500-internal-server-error');
    throw Exception('Web platform is not supported for "dart:io".');
  }

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
