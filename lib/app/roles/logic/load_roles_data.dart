// load_roles_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

List<dynamic>? rolesData;

/// Loads roles JSON file and parses it into a list.
Future<void> loadRolesData() async {
  // Display a loading overlay while roles data is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('roles.rolesDataLoading'));

  // Load the roles data JSON file.
  try {
    // Load the roles data.
    final jsonData = await rootBundle.loadString(
      'lib/app/roles/data/roles.json',
    );
    rolesData = json.decode(jsonData) as List<dynamic>?;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the roles data is loaded.
  if (rolesData == null) {
    throw Exception('Roles data not loaded.');
  }
}
