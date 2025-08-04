// changelog.dart
//

import 'package:flutter_playground/app/changelog/logic_widgets/load_changelog.dart';

/// Provides access to changelog entries all across the app.
/// It gives access to all changelogs, regardless of the module.
///
/// Static Methods:
/// - [initChangelogData]: Initializes the changelog for a specific module.
/// - [getChangelogData]: Retrieves the changelog information for the current module.
/// - [getLog]: Returns changelogs for a specific module and version.
/// - [getVersions]: Returns a list of all version numbers for the given module.
class Changelog {
  /// Initializes the changelog for a specific module.
  /// If no module is specified, it defaults to the main framework.
  static Future<Map<String, dynamic>> initChangelogData({
    String module = '',
  }) async {
    // Load the changelog file for the specified module.
    await loadChangelog(module);

    // If no module is specified, default to the main framework.
    if (module.isEmpty) {
      module = 'main';
    }

    // Return the loaded changelog.
    return changelog ?? {};
  }

  /// Get the the changelog information for the current module.
  static Map<String, dynamic>? getChangelogData() {
    return changelog;
  }

  // /// Returns a Changelog for a specific module and version.
  // /// If no module is specified, it returns the log of the main framework.
  // /// If no version is specified, it returns the log of the latest version.
  // static Future<Map<String, dynamic>> getLog(
  //   String? module,
  //   String? version,
  // ) async {
  //   // Load the changelog file for the specified module.
  //   await loadChangelog(module);

  //   // If no version is specified, select the current version.
  //   if (version == null || version.isEmpty) {
  //     version = changelog?['current_version'] as String?;
  //   }

  //   // Check if the changelog contains the specified version.
  //   if (!changelog!.containsKey('versions') ||
  //       !changelog!['versions'].containsKey(version)) {
  //     throw Exception(
  //       'Changelog for module $module for version $version not found.',
  //     );
  //   }

  //   // Get the changelog for the specified version.
  //   final log = changelog!['versions'][version] as Map<String, dynamic>;

  //   return log;
  // }

  // /// Returns a list of all version numbers for the given module.
  // static Future<List<String>> getVersions(String? module) async {
  //   // Load the changelog for the specified module.
  //   await loadChangelog(module);

  //   // Get the versions as a list of strings, if any.
  //   final versionsMap = changelog?['versions'] as Map<String, dynamic>?;

  //   // If no versions are found, return an empty list.
  //   if (versionsMap == null) return [];

  //   // Return the keys of the versions map as a list of strings.
  //   return versionsMap.keys.cast<String>().toList();
  // }
}
