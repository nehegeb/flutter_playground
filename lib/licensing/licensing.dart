/// licensing.dart
///
library licensing;

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'package:flutter_playground/helpers/helper_widgets.dart';
import 'package:flutter_playground/helpers/loading_overlay.dart';

Map<String, dynamic>? licenseData;

/// Loads license JSON files and parses them into maps.
Future<void> _loadLicenseDescriptions() async {
  // Display a loading overlay while license data is being loaded.
  await Future.delayed(const Duration(milliseconds: 10));
  LoadingOverlay.initiate(Localization.getText('aboutPage.licLoading'));

  // Load the license file.
  try {
    final jsonData = await rootBundle.loadString(
      'lib/licensing/license_descriptions.json',
    );
    licenseData = json.decode(jsonData) as Map<String, dynamic>;
  } finally {
    // Dismiss the loading overlay after loading is complete.
    LoadingOverlay.dismiss();
  }
}

/// Widget to display the license information.
class LicenseInfo extends StatelessWidget {
  final String packageName;
  final String copyright;
  final String license;
  final String packageUrl;

  const LicenseInfo({
    super.key,
    required this.packageName,
    required this.copyright,
    required this.license,
    required this.packageUrl,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      license == "MIT" || license == "BSD3",
      'Only the following licenses are available currently: MIT, BSD3',
    );

    // Make sure the licenseData is available.
    if (licenseData == null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          Localization.getText('aboutPage.licError'),
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    // Get the information for the given license from the data.
    final String licName = licenseData?[license]?['name'] ?? '';
    final String licDescription = licenseData?[license]?['description'] ?? '';
    final String licSource = licenseData?[license]?['source'] ?? '';

    return SizedBox(
      width: double.infinity, // Make the widget take full width.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: packageName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  TextSpan(
                    text: '\n',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: 'Copyright (c) $copyright',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: '\n',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: 'Licensed under the $licName.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: ' ',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: IconButton(
                      icon: const Icon(Icons.help_outline, size: 16),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: Localization.getText('aboutPage.licDetails'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => _LicensePopup(
                            licDescription: licDescription,
                            licSource: licSource,
                          ),
                        );
                      },
                    ),
                  ),
                  TextSpan(
                    text: '\n',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Helpers.toRichText(
                    packageUrl,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _LicensePopup extends StatelessWidget {
  final String licDescription;
  final String licSource;

  const _LicensePopup({required this.licDescription, required this.licSource});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: 400,
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Text(
                          licDescription,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),
                        RichText(
                          text: Helpers.toRichText(
                            '${Localization.getText('aboutPage.licSource')}: $licSource',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Provides access to license information.
///
/// Static Methods:
/// - [of]: Returns a Licensing instance.
/// - [initLicensingData]: Initializes the licensing data by loading it from JSON files.
class Licensing {
  /// Loads the licensing data from the JSON files.
  static Future<void> initLicensingData() async {
    await _loadLicenseDescriptions();
  }
}
