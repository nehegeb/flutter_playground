import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/licensing/licensing.dart';
import 'package:flutter_playground/app/licensing/logic_widgets/load_license_descriptions.dart';

void main() {
  group('Licensing', () {
    setUp(() {
      // Reset licenseData before each test if possible.
      licenseData = null;
    });

    test('initLicensingData loads license data if not loaded', () async {
      licenseData = null;
      await Licensing.initLicensingData();
      expect(licenseData, isNotNull, reason: 'License data should be loaded');
    });

    test('initLicensingData does not reload if already loaded', () async {
      licenseData = {'dummy': 'data'};
      await Licensing.initLicensingData();
      expect(
        licenseData,
        equals({'dummy': 'data'}),
        reason: 'License data should not be reloaded',
      );
    });
  });
}
