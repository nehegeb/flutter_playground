// dismiss_popup_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

/// Dismisses the currently displayed [PopupDialog], if any.
///
/// It checks the [isPopupDialogDisplayedNotifier] to determine
/// if the dialog is currently displayed.
/// If [onDismiss] is given, always execute the callback.
void dismissPopupDialog({
  required BuildContext context,
  VoidCallback? onDismiss,
}) {
  // If [onDismiss] is given, always execute the callback.
  onDismiss?.call();

  // Check if the [PopupDialog] is currently displayed.
  if (isPopupDialogDisplayedNotifier.value) {
    // Dismiss the [PopupDialog].
    AppPopup.hide();
    Navigator.of(context).maybePop();

    // Reset all [PopupDialog] notifiers.
    isPopupDialogDisplayedNotifier.value = false;
    isConfirmationButtonActiveNotifier.value = true;
    popupDialogMessageNotifier.value = null;
    popupDialogDataNotifier.value = null;
  }
}
