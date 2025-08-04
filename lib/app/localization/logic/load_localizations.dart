// load_localizations.dart
//

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_playground/app/misc/widgets/loading_overlay.dart';

Map<String, dynamic>? localizationPrimary; // English is always loaded.
Map<String, dynamic>? localizationSecondary; // Secondary localization.

/// Loads localization JSON files and parses them into maps.
/// Only loads English and the specified language, if any.
Future<void> loadLocalizations(String? language) async {
  // Display a loading overlay while localizations are being loaded.
  // NOTE: Cannot use localization text here as it is not loaded yet.
  LoadingOverlay.initiate('Loading localizations...');

  // Load the localization files.
  try {
    // Load the primary localization (English).
    final jsonEn = await rootBundle.loadString(
      'lib/app/localization/data/localization_english.json',
    );
    localizationPrimary = json.decode(jsonEn) as Map<String, dynamic>;

    // Make sure the primary localization is loaded.
    if (localizationPrimary == null) {
      throw Exception('Primary localization not loaded.');
    }

    // Additionally load the requested language if different.
    bool hasSecondaryLocalization = true;
    switch (language) {
      case 'de':
        // Load German localization if requested.
        final jsonDe = await rootBundle.loadString(
          'lib/app/localization/data/localization_german.json',
        );
        localizationSecondary = json.decode(jsonDe) as Map<String, dynamic>;
        break;
      // NOTE: Add more languages here as needed.
      default:
        // No secondary localization available.
        localizationSecondary = null;
        hasSecondaryLocalization = false;
    }

    // Make sure the secondary localization is loaded.
    if (hasSecondaryLocalization && localizationSecondary == null) {
      throw Exception('Secondary localization not loaded.');
    }
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }
}
