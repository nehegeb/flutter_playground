// load_license_descriptions_data.dart
//
// This loads the license descriptions data from a JSON file.
// NOTE: This is read only! The JSON file cannot be modified during runtime.
// This is okay, because the license descriptions won't change during runtime.

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Map<String, dynamic>? licenseData;

/// Loads license JSON file and parses it into a map.
Future<void> loadLicenseDescriptionsData() async {
  // Load the license descriptions JSON file.
  try {
    final file = 'lib/app/licensing/data/license_descriptions.json';

    // Load the license descriptions data.
    final jsonData = await rootBundle.loadString(file);
    licenseData = json.decode(jsonData) as Map<String, dynamic>?;
  } catch (e) {
    throw Exception('Loading license data failed: $e');
  }

  // Make sure the license data is loaded.
  if (licenseData == null) {
    throw Exception('License data not loaded.');
  }
}
