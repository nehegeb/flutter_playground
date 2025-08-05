// is_mobile_device_notifier_test.dart
//
// Unit tests for IsMobileDeviceNotifier and isMobileDeviceNotifier.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';

void main() {
  group('IsMobileDeviceNotifier', () {
    setUp(() {
      // Reset notifier before each test.
      isMobileDeviceNotifier.value = false;
    });

    test('initial value is false', () {
      expect(isMobileDeviceNotifier.value, isFalse);
      expect(IsMobileDeviceNotifier.isMobile, isFalse);
    });

    test('setMobile updates notifier value', () {
      IsMobileDeviceNotifier.setMobile(true);
      expect(isMobileDeviceNotifier.value, isTrue);
      expect(IsMobileDeviceNotifier.isMobile, isTrue);

      IsMobileDeviceNotifier.setMobile(false);
      expect(isMobileDeviceNotifier.value, isFalse);
      expect(IsMobileDeviceNotifier.isMobile, isFalse);
    });

    testWidgets('ValueListenableBuilder reacts to changes', (
      WidgetTester tester,
    ) async {
      final changes = <bool>[];
      final widget = MaterialApp(
        home: ValueListenableBuilder<bool>(
          valueListenable: isMobileDeviceNotifier,
          builder: (context, value, _) {
            changes.add(value);
            return Text(value ? 'Mobile' : 'Desktop');
          },
        ),
      );
      await tester.pumpWidget(widget);
      expect(changes.last, isFalse);
      isMobileDeviceNotifier.value = true;
      await tester.pump();
      expect(changes.last, isTrue);
    });
  });
}
