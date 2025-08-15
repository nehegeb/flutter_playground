// load_used_packages_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

Map<String, dynamic>? packageData;

/// Loads license JSON files and parses them into maps.
Future<void> loadUsedPackagesData() async {
  // Display a loading overlay while package data is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('licensing.packageLoading'));

  // Load the used packages file.
  try {
    final jsonData = await rootBundle.loadString(
      'lib/app/licensing/data/used_packages.json',
    );
    packageData = json.decode(jsonData) as Map<String, dynamic>?;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the package data is loaded.
  if (packageData == null) {
    throw Exception('Package data not loaded.');
  }
}
