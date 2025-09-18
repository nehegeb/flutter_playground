// app_popup_test.dart
//
// Unit tests for the [AppPopup] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppPopup Notifiers', () {
    setUp(() {
      isPopupDialogDisplayedNotifier.value = false;
      isPopupDialogVisibleNotifier.value = true;
      isConfirmationButtonActiveNotifier.value = true;
      popupDialogMessageNotifier.value = null;
      popupDialogDataNotifier.value = null;
    });

    test('isActive returns correct value', () {
      isPopupDialogDisplayedNotifier.value = false;
      expect(AppPopup.isActive, isFalse);
      isPopupDialogDisplayedNotifier.value = true;
      expect(AppPopup.isActive, isTrue);
    });

    test('hide and show update isPopupDialogVisibleNotifier', () {
      AppPopup.hide();
      expect(isPopupDialogVisibleNotifier.value, isFalse);
      AppPopup.show();
      expect(isPopupDialogVisibleNotifier.value, isTrue);
    });

    test(
      'activateConfirmationButton and deactivateConfirmationButton update notifier',
      () {
        AppPopup.deactivateConfirmationButton();
        expect(isConfirmationButtonActiveNotifier.value, isFalse);
        AppPopup.activateConfirmationButton();
        expect(isConfirmationButtonActiveNotifier.value, isTrue);
      },
    );

    test('updateMessage updates popupDialogMessageNotifier', () {
      AppPopup.updateMessage(message: 'Test message');
      expect(popupDialogMessageNotifier.value, 'Test message');
    });
  });

  // Widget tests for dialog methods would require a widget environment and are best tested with integration/widget tests.
}
