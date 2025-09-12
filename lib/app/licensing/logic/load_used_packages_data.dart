// load_used_packages_data.dart
//
// This loads the used packages data from a JSON file.
// NOTE: This is read only! The JSON file cannot be modified during runtime.
// This is okay, because the used packages won't change during runtime.

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Map<String, dynamic>? packageData;

/// Loads license JSON file and parses it into a map.
Future<void> loadUsedPackagesData() async {
  // Load the used packages JSON file.
  try {
    final file = 'lib/app/licensing/data/used_packages.json';

    // Load the used packages data.
    final jsonData = await rootBundle.loadString(file);
    packageData = json.decode(jsonData) as Map<String, dynamic>?;
  } catch (e) {
    throw Exception('Loading packages data failed: $e');
  }

  // Make sure the package data is loaded.
  if (packageData == null) {
    throw Exception('Package data not loaded.');
  }
}
