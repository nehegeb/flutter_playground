// load_used_packages_data.dart
//

import 'dart:io';
import 'dart:convert';
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

Map<String, dynamic>? packageData;

/// Loads license JSON file and parses it into a map.
Future<void> loadUsedPackagesData() async {
  // Display a loading overlay while package data is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('licensing.packageDataLoading'));

  // Load the used packages JSON file.
  try {
    final file = File('lib/app/licensing/data/used_packages.json');

    // Load the used packages data.
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      packageData = json.decode(jsonData) as Map<String, dynamic>?;
    } else {
      packageData = {};
    }
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the package data is loaded.
  if (packageData == null) {
    throw Exception('Package data not loaded.');
  }
}
