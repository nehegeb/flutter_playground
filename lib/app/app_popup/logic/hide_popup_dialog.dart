// hide_popup_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

/// Hides the currently displayed [PopupDialog], if any.
///
/// It checks the [isPopupDialogDisplayedNotifier] to determine
/// if the dialog is currently shown.
/// If [onHide] is given, always execute the callback.
void hidePopupDialog({required BuildContext context, VoidCallback? onHide}) {
  // If [onHide] is given, always execute the callback.
  onHide?.call();

  // Check if the [PopupDialog] is currently displayed.
  if (isPopupDialogDisplayedNotifier.value) {
    // Hide the [PopupDialog].
    Navigator.of(context).maybePop();

    // Set the [isPopupDialogDisplayedNotifier] to false.
    isPopupDialogDisplayedNotifier.value = false;

    // Set the [popupDialogDataNotifier] to null.
    popupDialogDataNotifier.value = null;

    // Note: Do NOT set the [PopupDialogMessageNotifier] to null!
    // This is, because the 'Navigator' takes too long and
    // if the text is changed here, the [PopupDialog] "flickers".
    // Just keep the last message in the notifier, it won't hurt.
  }
}
