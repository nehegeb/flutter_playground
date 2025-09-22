// roles_test.dart
//
// Unit tests for the [Roles] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/roles/roles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Roles', () {
    setUp(() {
      Roles.clearDbRolesData();
    });

    test('emptyRole returns an AppRole', () {
      final role = Roles.emptyRole;
      expect(role, isA<AppRole>());
    });

    test('dbRolesData is null after clear', () {
      Roles.clearDbRolesData();
      expect(Roles.dbRolesData, isNull);
    });

    test('AppRole.fromMap creates correct instance', () {
      final map = {
        'id': '1',
        'idTitle': 'admin',
        'mainModuleIdTitle': 'main',
        'subModuleIdTitle': 'sub',
        'isDefaultRole': true,
        'permissions': ['read', 'write'],
      };
      final role = AppRole.fromMap(map);
      expect(role.id, '1');
      expect(role.idTitle, 'admin');
      expect(role.mainModuleIdTitle, 'main');
      expect(role.subModuleIdTitle, 'sub');
      expect(role.isDefaultRole, isTrue);
      expect(role.permissions, containsAll(['read', 'write']));
    });

    test('getRole returns null if roles data is not loaded', () {
      final role = Roles.getRole(roleId: '1');
      expect(role, isNull);
    });

    // No tests for initDbRolesData() as it requires actual data files.
    // But if something is broken there, the app wouldn't start properly anyway.
  });
}
