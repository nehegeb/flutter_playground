// changelog_test.dart
//
// Unit tests for the [Changelog] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/changelog/changelog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Changelog', () {
    setUp(() {
      Changelog.clearDbChangelogData();
    });

    test('dbChangelogData is null after clear', () {
      Changelog.clearDbChangelogData();
      expect(Changelog.dbChangelogData, isNull);
    });

    test('initDbChangelogData loads data for main module', () async {
      await Changelog.initDbChangelogData();
      expect(Changelog.dbChangelogData, isNotNull);
      expect(Changelog.dbChangelogData, isA<Map<String, dynamic>>());
    });

    test('initDbChangelogData loads data for a specific module', () async {
      await Changelog.initDbChangelogData(module: 'main');
      expect(Changelog.dbChangelogData, isNotNull);
      expect(Changelog.dbChangelogData, isA<Map<String, dynamic>>());
    });

    test('clearDbChangelogData sets dbChangelogData to null', () async {
      await Changelog.initDbChangelogData();
      Changelog.clearDbChangelogData();
      expect(Changelog.dbChangelogData, isNull);
    });
  });
}
