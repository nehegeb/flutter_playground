// load_languages_data.dart
//
// This loads the languages data from a JSON file.
// NOTE: This must be read and write, because the data might change during runtime.
// NOTE: This won't work for web apps, because web apps cannot access local files!
//
// DEV: For web apps, the JSON file needs to be outsourced into a proper database!

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_playground/app/app_router/app_router.dart';
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

List<dynamic>? languagesData;

/// Loads the languages JSON file and parses it into a list.
/// It loads the languages for the app.
Future<void> loadLanguagesData() async {
  if (kIsWeb) {
    // Web apps cannot access local files! Remove this exception after switching to a proper database.
    appRouter.go('/500-internal-server-error');
    throw Exception('Web platform is not supported for "dart:io".');
  }

  // Display a loading overlay while languages are being loaded.
  // But before displaying the loading overlay, wait for the UI to settle.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(
    Localization.getText('localization.languagesDataLoading'),
  );

  // Load the languages JSON file.
  try {
    final file = File('lib/app/localization/data/languages.json');

    // Load the languages data.
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      languagesData = json.decode(jsonData) as List<dynamic>?;
    } else {
      languagesData = [];
    }
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }

  // Make sure the languages data is loaded.
  if (languagesData == null) {
    throw Exception('Languages data not loaded.');
  }
}
