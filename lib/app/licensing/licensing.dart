// licensing.dart
//

import 'package:flutter_playground/app/licensing/logic/load_license_descriptions_data.dart';
import 'package:flutter_playground/app/licensing/logic/load_used_packages_data.dart';

/// Utility class to access license information.
/// Provides static methods to retrieve package and license information.
///
/// Static Methods:
/// - [dbPackageData]: Gets the package information for the current module.
/// - [dbLicenseData]: Gets the license information for the current module.
/// - [initDbLicensingData]: Initializes the package and licensing data for the app.
/// - [clearDbLicensingData]: Clears the licensing data from the app.
class Licensing {
  /// Get the loaded package information for the current module.
  static Map<String, dynamic>? get dbPackageData {
    return packageData;
  }

  /// Get the loaded license information for the current module.
  static Map<String, dynamic>? get dbLicenseData {
    return licenseData;
  }

  /// Loads the licensing data from the database for the app.
  static Future<void> initDbLicensingData() async {
    await loadUsedPackagesData();
    await loadLicenseDescriptionsData();
  }

  /// Clear the loaded licensing data of the database from the app.
  static void clearDbLicensingData() {
    packageData = null;
    licenseData = null;
  }
}
