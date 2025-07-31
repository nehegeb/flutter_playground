// license_info.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'package:flutter_playground/licensing/licensing.dart';
import 'package:flutter_playground/licensing/ui_widgets/license_popup.dart';
import 'package:flutter_playground/misc/logic_widgets/helper_methods.dart';

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

    // Make sure the license data is available.
    final Map<String, dynamic>? licenseData = Licensing.getLicenseData();
    if (licenseData == null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            Localization.getText('licensing.licenseNotLoadedError'),
            style: const TextStyle(color: Colors.red),
          ),
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
                      tooltip: Localization.getText('licensing.licenseDetails'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => LicensePopup(
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
