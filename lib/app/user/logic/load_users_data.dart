// load_users_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

List<dynamic>? usersData;

/// Loads user JSON files and parses them into maps.
Future<void> loadUsersData() async {
  // Display a loading overlay while user data is being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('users.loading'));

  // Load the user data file.
  try {
    final jsonData = await rootBundle.loadString(
      'lib/app/user/data/users.json',
    );
    usersData = json.decode(jsonData) as List<dynamic>?;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the user data is loaded.
  if (usersData == null) {
    throw Exception('User data not loaded.');
  }
}
