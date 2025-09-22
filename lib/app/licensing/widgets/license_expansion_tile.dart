// license_expansion_tile.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/licensing/licensing.dart';
import 'package:flutter_playground/app/licensing/widgets/license_info.dart';

/// A widget that displays an expansion tile with license information for used packages.
class LicenseExpansionTile extends StatelessWidget {
  const LicenseExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    // Make sure the package data is available.
    final Map<String, dynamic>? packageData = Licensing.dbPackageData;
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
      tilePadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
      childrenPadding: EdgeInsets.fromLTRB(0, 0, 0, 12),
      shape: const Border(
        bottom: BorderSide(color: Colors.grey, width: 1),
      ), // Only bottom border when expanded.
      initiallyExpanded: false,
      children: [
        // Contribution to the Flutter Framework Core.
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {}, // Prevents collapsing when clicked on a child.
          child: LicenseInfo(
            packageName: "flutter_framework_core",
            copyright: "2025 Markus Kramer",
            license: "MIT",
            packageUrl: "https://github.com/nehegeb/flutter_framework_core",
          ),
        ),

        // List all used packages for this app.
        if (packageData.isNotEmpty)
          ...packageData.entries.map(
            (entry) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {}, // Prevents collapsing when clicked on a child.
              child: LicenseInfo(
                packageName: entry.value['name'],
                copyright: entry.value['copyright'],
                license: entry.value['license'],
                packageUrl: entry.value['packageUrl'],
              ),
            ),
          ),
      ],
    );
  }
}
