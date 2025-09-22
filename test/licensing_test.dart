// licensing_test.dart
//
// Unit tests for [Licensing] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/licensing/licensing.dart';

void main() {
  group('Licensing', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    setUp(() {
      Licensing.clearDbLicensingData();
    });

    test('dbPackageData and dbLicenseData are null after clear', () {
      Licensing.clearDbLicensingData();
      expect(Licensing.dbPackageData, isNull);
      expect(Licensing.dbLicenseData, isNull);
    });

    test('initDbLicensingData loads data', () async {
      await Licensing.initDbLicensingData();
      expect(
        Licensing.dbPackageData,
        isNotNull,
        reason: 'dbPackageData should be loaded',
      );
      expect(
        Licensing.dbLicenseData,
        isNotNull,
        reason: 'dbLicenseData should be loaded',
      );
    });

    test('clearDbLicensingData sets data to null', () async {
      await Licensing.initDbLicensingData();
      Licensing.clearDbLicensingData();
      expect(
        Licensing.dbPackageData,
        isNull,
        reason: 'dbPackageData should be null after clear',
      );
      expect(
        Licensing.dbLicenseData,
        isNull,
        reason: 'dbLicenseData should be null after clear',
      );
    });
  });
}
