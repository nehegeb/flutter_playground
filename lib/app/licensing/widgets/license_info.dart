// license_info.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/licensing/licensing.dart';
import 'package:flutter_playground/app/licensing/widgets/license_popup.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';

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
    // Make sure the license data is available.
    final Map<String, dynamic>? licenseData = Licensing.dbLicenseData;
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
    final String licName = licenseData[license]?['name'] ?? '';
    final String licDescription = licenseData[license]?['description'] ?? '';
    final String licSource = licenseData[license]?['source'] ?? '';

    // A function to show the [LicensePopup] widget.
    showLicensePopup() {
      showDialog(
        context: context,
        builder: (context) =>
            LicensePopup(licDescription: licDescription, licSource: licSource),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: showLicensePopup,
        child: SizedBox(
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
                      // Package name.
                      TextSpan(
                        text: packageName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: '\n',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextSpan(
                        text: '\n',
                        style: Theme.of(
                          context,
                        ).textTheme.titleSmall?.copyWith(fontSize: 2),
                      ),

                      // Copyright information.
                      TextSpan(
                        text: 'Copyright (c) $copyright',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: '\n',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      // License information.
                      TextSpan(
                        text: 'Licensed under the $licName.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: '\n',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),

                      // Package URL.
                      AppHelper.toRichText(
                        packageUrl,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
