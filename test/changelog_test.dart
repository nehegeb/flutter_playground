// changelog_test.dart
//
// Unit tests for Changelog.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/changelog/changelog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Changelog', () {
    test('changelogData is null before initialization', () {
      expect(Changelog.dbChangelogData, isNull);
    });

    test(
      'initChangelogData loads changelog for main framework by default',
      () async {
        await Changelog.initDbChangelogData();
        final data = Changelog.dbChangelogData;
        expect(data, isNotNull);
        expect(data, isA<Map<String, dynamic>>());
        expect(data!.isNotEmpty, true);
      },
    );

    test('initChangelogData loads changelog for specific module', () async {
      await Changelog.initDbChangelogData(module: 'template');
      final data = Changelog.dbChangelogData;
      expect(data, isNotNull);
      expect(data, isA<Map<String, dynamic>>());
      expect(data!.isNotEmpty, true);
    });
  });
}
