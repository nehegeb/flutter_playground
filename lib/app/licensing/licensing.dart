// licensing.dart
//

import 'package:flutter_playground/app/licensing/logic/load_license_descriptions.dart';
import 'package:flutter_playground/app/licensing/logic/load_used_packages.dart';

/// Utility class to access license information.
/// Provides static methods to retrieve package and license information.
///
/// Static Methods:
/// - [initLicensingData]: Initializes the package and licensing data.
/// - [getPackageData]: Retrieves the package information for the current module.
/// - [getLicenseData]: Retrieves the license information for the current module.
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
