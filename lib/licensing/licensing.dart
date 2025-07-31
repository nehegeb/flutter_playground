// licensing.dart
//

import 'package:flutter_playground/licensing/logic_widgets/load_license_descriptions.dart';
import 'package:flutter_playground/licensing/logic_widgets/load_used_packages.dart';

/// Provides access to license information.
///
/// Static Methods:
/// - [initLicensingData]: Initializes the licensing data by loading it from JSON files.
/// - [getPackageData]: Retrieves the package information for the current module.
class Licensing {
  /// Loads the licensing data from the JSON files.
  static Future<void> initLicensingData() async {
    // Only load the license and package data if it hasn't been loaded yet.
    if (packageData == null) {
      await loadUsedPackages();
    }
    if (licenseData == null) {
      await loadLicenseDescriptions();
    }
  }

  /// Get the the package information for the current module.
  static Map<String, dynamic>? getPackageData() {
    return packageData;
  }

  /// Get the the license information for the current module.
  static Map<String, dynamic>? getLicenseData() {
    return licenseData;
  }
}
