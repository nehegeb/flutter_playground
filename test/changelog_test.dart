import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/changelog/changelog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Changelog', () {
    test('changelogData is null before initialization', () {
      expect(Changelog.changelogData, isNull);
    });

    test(
      'initChangelogData loads changelog for main framework by default',
      () async {
        await Changelog.initChangelogData();
        final data = Changelog.changelogData;
        expect(data, isNotNull);
        expect(data, isA<Map<String, dynamic>>());
        expect(data!.isNotEmpty, true);
      },
    );

    test('initChangelogData loads changelog for specific module', () async {
      await Changelog.initChangelogData(module: 'template');
      final data = Changelog.changelogData;
      expect(data, isNotNull);
      expect(data, isA<Map<String, dynamic>>());
      expect(data!.isNotEmpty, true);
    });
  });
}
