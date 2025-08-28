// hide_popup_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

/// Hides the currently displayed [PopupDialog], if any.
/// It checks the [isPopupDialogDisplayedNotifier] to determine
/// if the dialog is currently shown.
void hidePopupDialog({required BuildContext context}) {
  // Check if the [PopupDialog] is currently displayed.
  if (isPopupDialogDisplayedNotifier.value) {
    // Hide the [PopupDialog].
    Navigator.of(context).pop();

    // Set the [isPopupDialogDisplayedNotifier] to false.
    isPopupDialogDisplayedNotifier.value = false;

    // Set the [PopupDialogMessageNotifier] to null.
    popupDialogMessageNotifier.value = null;
  }
}
