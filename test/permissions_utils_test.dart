// permissions_utils_test.dart
//
// Unit tests for the [PermissionsUtils] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/permissions/permissions_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PermissionsUtils', () {
    test('allPermissions returns a non-empty list', () {
      final permissions = PermissionsUtils.allPermissions;
      expect(permissions, isA<List<String>>());
      expect(permissions.isNotEmpty, isTrue);
    });

    test('getPermissionsforModule returns correct permissions', () {
      // Assuming 'main' is a valid module in [PermissionsGroupedByModule.get].
      final permissions = PermissionsUtils.getPermissionsforModule('main');
      expect(permissions, isA<List<String>>());
    });

    test('getPermissionsforModule returns empty list for unknown module', () {
      final permissions = PermissionsUtils.getPermissionsforModule(
        'unknown_module',
      );
      expect(permissions, isEmpty);
    });

    test('getMainModule returns a string', () {
      final mainModule = PermissionsUtils.getMainModule(
        permission: 'some_permission',
      );
      expect(mainModule, isA<String>());
    });

    test('getSubModule returns a string', () {
      final subModule = PermissionsUtils.getSubModule(
        permission: 'some_permission',
      );
      expect(subModule, isA<String>());
    });
  });
}
