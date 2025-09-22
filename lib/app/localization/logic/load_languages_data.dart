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

List<dynamic>? languagesData;

/// Loads the languages JSON file and parses it into a list.
/// It loads the languages for the app.
Future<void> loadLanguagesData() async {
  if (kIsWeb) {
    // Web apps cannot access local files! Remove this exception after switching to a proper database.
    appRouter.go('/500-internal-server-error');
    throw Exception('Web platform is not supported for "dart:io".');
  }

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
  } catch (e) {
    throw Exception('Loading languages data failed: $e');
  }

  // Make sure the languages data is loaded.
  if (languagesData == null) {
    throw Exception('Languages data not loaded.');
  }
}
