// licensing_test.dart
//
// Unit tests for Licensing.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/licensing/licensing.dart';
import 'package:flutter_playground/app/licensing/logic/load_license_descriptions_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Licensing', () {
    setUp(() {
      // Reset licenseData before each test if possible.
      licenseData = null;
    });

    test('initLicensingData loads license data if not loaded', () async {
      licenseData = null;
      await Licensing.initDbLicensingData();
      expect(licenseData, isNotNull, reason: 'License data should be loaded');
      expect(licenseData is Map, true, reason: 'License data should be a Map');
      expect(
        licenseData!.isNotEmpty,
        true,
        reason: 'License data should not be empty',
      );
    });

    test('initLicensingData does not reload if already loaded', () async {
      licenseData = {'dummy': 'data'};
      await Licensing.initDbLicensingData();
      expect(
        licenseData,
        equals({'dummy': 'data'}),
        reason: 'License data should not be reloaded',
      );
    });
  });
}
