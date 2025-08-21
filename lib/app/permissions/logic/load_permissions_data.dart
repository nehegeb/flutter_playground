// load_permissions_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

List<dynamic>? permissionsData;

/// Loads permissions JSON file and parses it into a list.
Future<void> loadPermissionsData() async {
  // Display a loading overlay while permissions data is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(
    Localization.getText('permissions.permissionsDataLoading'),
  );

  // Load the permissions data JSON file.
  try {
    // Load the permissions data.
    final jsonData = await rootBundle.loadString(
      'lib/app/permissions/data/permissions.json',
    );
    permissionsData = json.decode(jsonData) as List<dynamic>?;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the permissions data is loaded.
  if (permissionsData == null) {
    throw Exception('Permissions data not loaded.');
  }
}
