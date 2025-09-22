// changelog.dart
//

import 'package:flutter_playground/app/changelog/logic/load_changelog_data.dart';

/// Utility class to access changelog data.
/// Provides static methods to access to all changelogs, regardless of the module.
///
/// Static Methods:
/// - [dbChangelogData]: Returns the changelog data for the current module.
/// - [initDbChangelogData]: Initializes the changelog data for a specific module.
/// - [clearDbChangelogData]: Clears the changelog data from the app.
class Changelog {
  // Get the loaded changelog information for the current module.
  static Map<String, dynamic>? get dbChangelogData {
    return changelogData;
  }

  /// Initializes the changelog for a specific module.
  /// If no module is specified, it defaults to the main framework.
  static Future<void> initDbChangelogData({String module = ''}) async {
    // If no module is specified, default to the main framework.
    if (module.isEmpty) {
      module = 'main';
    }

    // Load the changelog data for the specified module.
    await loadChangelogData(module);
  }

  /// Clear the loaded changelog data of the database from the app.
  static void clearDbChangelogData() {
    changelogData = null;
  }
}
