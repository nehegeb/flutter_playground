// license_expansion_tile.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/localization/localization.dart';
import 'package:flutter_playground/licensing/licensing.dart';
import 'package:flutter_playground/licensing/ui_widgets/license_info.dart';

/// A widget that displays an expansion tile with license information for used packages.
class LicenseExpansionTile extends StatelessWidget {
  const LicenseExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    // Make sure the package data is available.
    final Map<String, dynamic>? packageData = Licensing.getPackageData();
    if (packageData == null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            Localization.getText('licensing.packageNotLoadedError'),
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return ExpansionTile(
      title: Text(Localization.getText('licensing.title')),
      initiallyExpanded: false,
      children: (packageData != null && packageData.isNotEmpty)
          ? packageData.entries
                .map(
                  // Generate a LicenseInfo for each package entry.
                  (entry) => LicenseInfo(
                    packageName: entry.value['name'],
                    copyright: entry.value['copyright'],
                    license: entry.value['license'],
                    packageUrl: entry.value['packageUrl'],
                  ),
                )
                .toList()
          : [],
    );
  }
}
