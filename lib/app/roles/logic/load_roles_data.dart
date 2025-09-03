// load_roles_data.dart
//

import 'dart:io';
import 'dart:convert';
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

List<dynamic>? rolesData;

/// Loads roles JSON file and parses it into a list.
Future<void> loadRolesData() async {
  // Display a loading overlay while roles data is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('roles.rolesDataLoading'));

  // Load the roles data JSON file.
  try {
    final file = File('lib/app/roles/data/roles.json');

    // Load the roles data.
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      rolesData = json.decode(jsonData) as List<dynamic>?;
    } else {
      rolesData = [];
    }
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the roles data is loaded.
  if (rolesData == null) {
    throw Exception('Roles data not loaded.');
  }
}
