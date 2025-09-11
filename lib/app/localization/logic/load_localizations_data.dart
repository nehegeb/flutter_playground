// load_localizations_data.dart
//
// This loads the localizations data from JSON files.
// NOTE: This is read only! The JSON files cannot be modified during runtime.
// This is okay, because the localizations won't change during runtime.

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/app_helper/widgets/loading_overlay.dart';
import 'package:flutter_playground/app/localization/localization.dart';

Map<String, dynamic>?
localizationDataPrimary; // Primary language data is always loaded.
Map<String, dynamic>?
localizationDataSecondary; // Secondary language data for localization.

/// Loads localization JSON files and parses them into maps.
/// Only loads the primary language and the given secondary [languageId], if any.
Future<void> loadLocalizationsData(String? languageId) async {
  // Display a loading overlay while localizations are being loaded.
  // NOTE: Cannot use localized text here as it is not loaded yet.
  LoadingOverlay.initiate('Loading localizations...');

  // Load the localization JSON files.
  try {
    String loadLanguageId = '';

    loadLanguageId = defaultLanguageId;
    final file = 'lib/app/localization/data/localization_$loadLanguageId.json';

    // Load the primary localization data.
    final jsonData = await rootBundle.loadString(file);
    localizationDataPrimary = json.decode(jsonData) as Map<String, dynamic>;

    // Make sure the proper primary localization data is loaded.
    if (localizationDataPrimary == null ||
        localizationDataPrimary!['languageId'] as String != loadLanguageId) {
      throw Exception('Primary localization "$loadLanguageId" not loaded.');
    }

    // Additionally load the given secondary [languageId] if different.
    localizationDataSecondary = null; // Reset secondary localization data.
    if (languageId != null && languageId != defaultLanguageId) {
      loadLanguageId = languageId;
      final file =
          'lib/app/localization/data/localization_$loadLanguageId.json';

      // Load secondary localization data if requested.
      final jsonData = await rootBundle.loadString(file);
      localizationDataSecondary =
          json.decode(jsonData) as Map<String, dynamic>?;

      // Make sure the proper secondary localization data is loaded.
      if (localizationDataSecondary == null ||
          localizationDataSecondary!['languageId'] as String !=
              loadLanguageId) {
        throw Exception('Secondary localization "$loadLanguageId" not loaded.');
      }
    }
  } catch (e) {
    // NOTE: This 'catch' is necessary to handle localization data files that do not exist (yet).
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }
}
