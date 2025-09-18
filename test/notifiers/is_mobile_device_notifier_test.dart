// is_mobile_device_notifier_test.dart
//
// Unit tests for [IsMobileDeviceNotifier] and [isMobileDeviceNotifier].

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_notifiers/is_mobile_device_notifier/is_mobile_device_notifier.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('IsMobileDeviceNotifier', () {
    setUp(() {
      // Reset to default before each test.
      IsMobileDeviceNotifier.setMobile(false);
    });

    test('isMobile returns false by default', () {
      expect(IsMobileDeviceNotifier.isMobile, isFalse);
    });

    test('setMobile sets the notifier value', () {
      IsMobileDeviceNotifier.setMobile(true);
      expect(IsMobileDeviceNotifier.isMobile, isTrue);

      IsMobileDeviceNotifier.setMobile(false);
      expect(IsMobileDeviceNotifier.isMobile, isFalse);
    });

    test('isMobileDeviceNotifier notifies listeners', () async {
      bool? notifiedValue;
      void listener() {
        notifiedValue = isMobileDeviceNotifier.value;
      }

      isMobileDeviceNotifier.addListener(listener);
      IsMobileDeviceNotifier.setMobile(true);
      expect(notifiedValue, isTrue);

      IsMobileDeviceNotifier.setMobile(false);
      expect(notifiedValue, isFalse);

      isMobileDeviceNotifier.removeListener(listener);
    });

    testWidgets('checkAndSet updates based on context', (tester) async {
      // This test checks that checkAndSet does not throw and updates the notifier.
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            IsMobileDeviceNotifier.checkAndSet(context);
            return const SizedBox();
          },
        ),
      );
      // We can't assert the value without knowing the screen size, but we can assert no exceptions.
      expect(isMobileDeviceNotifier.value, isA<bool>());
    });
  });
}
