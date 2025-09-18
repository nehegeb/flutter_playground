// modules_test.dart
//
// Unit tests for the [Modules] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/modules/modules.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Modules', () {
    setUp(() {
      // Reset notifiers before each test.
      activeMainModuleNotifier.value = null;
      activeSubModuleNotifier.value = null;
      mainModulesNotifier.value = [];
      subModulesNotifier.value = [];
      Modules.clearDbModulesData();
    });

    test('activeMainModule and activeSubModule are null by default', () {
      expect(Modules.activeMainModule, isNull);
      expect(Modules.activeSubModule, isNull);
    });

    test('emptyMainModule and emptySubModule return instances', () {
      final main = Modules.emptyMainModule;
      final sub = Modules.emptySubModule;
      expect(main, isA<AppMainModule>());
      expect(sub, isA<AppSubModule>());
    });

    test(
      'permittedMainModules and permittedSubModules are empty by default',
      () {
        expect(Modules.permittedMainModules, isEmpty);
        expect(Modules.permittedSubModules, isEmpty);
      },
    );

    test('dbMainModulesData and dbSubModulesData are null after clear', () {
      Modules.clearDbModulesData();
      expect(Modules.dbMainModulesData, isNull);
      expect(Modules.dbSubModulesData, isNull);
    });

    test('AppMainModule.fromMap creates correct instance', () {
      final map = {
        'id': '1',
        'idTitle': 'main',
        'isPublic': true,
        'isHidden': false,
        'isAdministrative': true,
      };
      final main = AppMainModule.fromMap(map);
      expect(main.id, '1');
      expect(main.idTitle, 'main');
      expect(main.isPublic, isTrue);
      expect(main.isHidden, isFalse);
      expect(main.isAdministrative, isTrue);
    });

    test('AppSubModule.fromMap creates correct instance', () {
      final map = {
        'id': '2',
        'idTitle': 'sub',
        'mainModuleIdTitle': 'main',
        'isPublic': false,
        'isHidden': true,
        'isAdministrative': false,
      };
      final sub = AppSubModule.fromMap(map);
      expect(sub.id, '2');
      expect(sub.idTitle, 'sub');
      expect(sub.mainModuleIdTitle, 'main');
      expect(sub.isPublic, isFalse);
      expect(sub.isHidden, isTrue);
      expect(sub.isAdministrative, isFalse);
    });

    // No tests for initDbModulesData() as it requires actual data files.
    // Therefore no setting of active and permitted modules tests either.
    // But if something is broken there, the app wouldn't start properly anyway.
  });
}
