// load_license_descriptions_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

Map<String, dynamic>? licenseData;

/// Loads license JSON files and parses them into maps.
Future<void> loadLicenseDescriptionsData() async {
  // Display a loading overlay while license data is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('licensing.licenseLoading'));

  // Load the license descriptions file.
  try {
    final jsonData = await rootBundle.loadString(
      'lib/app/licensing/data/license_descriptions.json',
    );
    licenseData = json.decode(jsonData) as Map<String, dynamic>;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the license data is loaded.
  if (licenseData == null) {
    throw Exception('License data not loaded.');
  }
}
