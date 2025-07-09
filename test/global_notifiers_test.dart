import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/helpers/global_notifiers.dart';

void main() {
  group('Global Notifiers', () {
    // Test that currentModuleNotifier updates its value and notifies listeners.
    test('currentModuleNotifier updates and notifies listeners', () {
      String? notifiedValue;
      final listener = () {
        notifiedValue = currentModuleNotifier.value;
      };
      // Add a listener to the notifier.
      currentModuleNotifier.addListener(listener);
      // Change the value and check that the listener is notified.
      currentModuleNotifier.value = 'FirebaseModule';
      expect(notifiedValue, 'FirebaseModule');
      currentModuleNotifier.value = 'DashboardModule';
      expect(notifiedValue, 'DashboardModule');
      // Remove the listener after the test.
      currentModuleNotifier.removeListener(listener);
    });
  });
}
