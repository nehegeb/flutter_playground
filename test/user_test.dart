// user_test.dart
//
// Unit tests for the [User] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/user/user.dart';
import 'package:flutter_playground/app/roles/roles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('User', () {
    setUp(() {
      appUserNotifier.value = null;
      User.clearDbUsersData();
    });

    test('user getter returns null by default', () {
      expect(User.user, isNull);
    });

    test('emptyUser returns an AppUser', () {
      final empty = User.emptyUser;
      expect(empty, isA<AppUser>());
    });

    test('dbUsersData is null after clear', () {
      User.clearDbUsersData();
      expect(User.dbUsersData, isNull);
    });

    test('AppUser.fromMap creates correct instance', () {
      final map = {
        'id': '1',
        'email': 'test@example.com',
        'name': 'Test User',
        'title': 'Tester',
        'passwordHash': 'hash',
        'passwordSalt': 'salt',
        'roles': [Roles.emptyRole],
        'permissions': ['read', 'write'],
      };
      final user = AppUser.fromMap(map);
      expect(user.id, '1');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.title, 'Tester');
      expect(user.passwordHash, 'hash');
      expect(user.passwordSalt, 'salt');
      expect(user.roles, isA<List<AppRole>>());
      expect(user.permissions, containsAll(['read', 'write']));
    });

    // No tests for initDbUsersData() as it requires actual data files.
    // But if something is broken there, the app wouldn't start properly anyway.
  });
}
