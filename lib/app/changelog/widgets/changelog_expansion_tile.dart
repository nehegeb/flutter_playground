// changelog_expansion_tile.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/changelog/changelog.dart';
import 'package:flutter_playground/app/changelog/widgets/version_expansion_tile.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// A widget that displays all changelog entries for a specific module.
class ChangelogExpansionTile extends StatelessWidget {
  final String module;

  const ChangelogExpansionTile({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    // Make sure the changelog data is available.
    final Map<String, dynamic>? changelogData = Changelog.changelogData;
    if (changelogData == null) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            Localization.getText('changelog.notLoadedError'),
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    // Get all module versions from the changelog data.
    final Map<String, dynamic>? moduleVersions = changelogData['versions'];

    // Define the title text based on the module name.
    final moduleTitle = (module == '' || module == 'main')
        ? Localization.getText('appName')
        : Localization.getText('modules.$module.title');
    final title = Localization.getText(
      'changelog.title',
    ).replaceAll('<<module>>', moduleTitle);

    return ExpansionTile(
      title: Text(title),
      children: [
        if (moduleVersions != null && moduleVersions.isNotEmpty)
          ...moduleVersions.entries.map((entry) {
            final String version = entry.key;
            final Map<String, dynamic> data = entry.value;
            // Generate a VersionExpansionTile for each version entry.
            return VersionExpansionTile(version: version, versionData: data);
          }),
      ],
    );
  }
}
