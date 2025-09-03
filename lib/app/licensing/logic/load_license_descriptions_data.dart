// load_license_descriptions_data.dart
//

import 'dart:io';
import 'dart:convert';
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

Map<String, dynamic>? licenseData;

/// Loads license JSON file and parses it into a map.
Future<void> loadLicenseDescriptionsData() async {
  // Display a loading overlay while license data is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('licensing.licenseDataLoading'));

  // Load the license descriptions JSON file.
  try {
    final file = File('lib/app/licensing/data/license_descriptions.json');

    // Load the license descriptions data.
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      licenseData = json.decode(jsonData) as Map<String, dynamic>?;
    } else {
      licenseData = {};
    }
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the license data is loaded.
  if (licenseData == null) {
    throw Exception('License data not loaded.');
  }
}
