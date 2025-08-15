// licensing.dart
//

import 'package:flutter_playground/app/licensing/logic/load_license_descriptions_data.dart';
import 'package:flutter_playground/app/licensing/logic/load_used_packages_data.dart';

/// Utility class to access license information.
/// Provides static methods to retrieve package and license information.
///
/// Static Methods:
/// - [getPackageData]: Retrieves the package information for the current module.
/// - [getLicenseData]: Retrieves the license information for the current module.
/// - [initLicensingData]: Initializes the package and licensing data.
class Licensing {
  /// Get the the package information for the current module.
  static Map<String, dynamic>? getPackageData() {
    return packageData;
  }

  /// Get the the license information for the current module.
  static Map<String, dynamic>? getLicenseData() {
    return licenseData;
  }

  /// Loads the licensing data from the JSON files.
  static Future<void> initLicensingData() async {
    await loadUsedPackagesData();
    await loadLicenseDescriptionsData();
  }
}
