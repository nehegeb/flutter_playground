// changelog.dart
//

import 'package:flutter_playground/app/changelog/logic/load_changelog.dart';

/// Utility class to access changelog data.
/// Provides static methods to access to all changelogs, regardless of the module.
///
/// Static Methods:
/// - [changelogData]: Returns the changelog data for the current module.
/// - [initChangelogData]: Initializes the changelog for a specific module.
class Changelog {
  // Get the changelog information for the current module.
  static Map<String, dynamic>? get changelogData {
    return changelog;
  }

  /// Initializes the changelog for a specific module.
  /// If no module is specified, it defaults to the main framework.
  static Future<void> initChangelogData({String module = ''}) async {
    // If no module is specified, default to the main framework.
    if (module.isEmpty) {
      module = 'main';
    }

    // Load the changelog file for the specified module.
    await loadChangelog(module);
  }
}
