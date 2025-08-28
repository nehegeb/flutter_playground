// load_languages_data.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

List<dynamic>? languagesData;

/// Loads the languages JSON file and parses it into a list.
/// It loads the languages for the app.
Future<void> loadLanguagesData() async {
  // Display a loading overlay while languages are being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(
    Localization.getText('localization.languagesDataLoading'),
  );

  // Load the languages JSON file.
  try {
    // Load the languages data.
    final jsonData = await rootBundle.loadString(
      'lib/app/localization/data/languages.json',
    );
    languagesData = json.decode(jsonData) as List<dynamic>?;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the languages data is loaded.
  if (languagesData == null) {
    throw Exception('Languages data not loaded.');
  }
}
