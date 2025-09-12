// app_popup.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/logic/show_success_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_failed_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_information_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_warning_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_error_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_loading_dialog.dart';
import 'package:flutter_playground/app/app_popup/logic/show_widget_dialog.dart';
import 'package:flutter_playground/app/app_popup/logic/update_popup_dialog_message.dart';
import 'package:flutter_playground/app/app_popup/logic/dismiss_popup_dialog.dart';
import 'package:flutter_playground/app/app_popup/logic/set_confirmation_buttons_active.dart';
import 'package:flutter_playground/app/app_popup/logic/set_confirmation_buttons_inactive.dart';

/// Notifier whether the [PopupDialog] is currently displayed.
final ValueNotifier<bool> isPopupDialogDisplayedNotifier = ValueNotifier<bool>(
  false,
);

/// Notifier whether the [PopupDialog] is currently visible.
final ValueNotifier<bool> isPopupDialogVisibleNotifier = ValueNotifier<bool>(
  true,
);

/// Notifier whether the confirm, yes and save buttons are active on the [PopupDialog].
final ValueNotifier<bool> isConfirmationButtonActiveNotifier =
    ValueNotifier<bool>(true);

/// Notifier for the [message] displayed on the [PopupDialog].
final ValueNotifier<String?> popupDialogMessageNotifier =
    ValueNotifier<String?>(null);

/// Notifier for the data displayed on the [widget] of the [PopupDialog].
final ValueNotifier<Map<String, dynamic>?> popupDialogDataNotifier =
    ValueNotifier<Map<String, dynamic>?>(null);

/// A helper class containing methods for various popup widgets.
///
/// It opens a popup dialog in the center of the screen,
/// while the app behind is faded out and not interactable.
///
/// Static Methods:
/// - [isActive]: Returns whether a [PopupDialog] is currently active, even if hidden, as boolean.
/// - [successMessage]: Shows a success message [PopupDialog].
/// - [failedMessage]: Shows a failed message [PopupDialog].
/// - [infoMessage]: Shows an informational message [PopupDialog].
/// - [warningMessage]: Shows a warning message [PopupDialog].
/// - [errorMessage]: Shows an error message [PopupDialog].
/// - [loadingDialog]: Shows a loading [PopupDialog].
/// - [widgetDialog]: Shows a [PopupDialog] with the given [widget] as content.
/// - [updateMessage]: Updates the message of the currently displayed [PopupDialog].
/// - [dismiss]: Dismisses the currently displayed [PopupDialog].
/// - [hide]: Makes the currently displayed [PopupDialog] invisible.
/// - [show]: Makes the currently hidden [PopupDialog] visible again.
/// - [activateConfirmationButton]: Activates of the confirm, yes and save buttons.
/// - [deactivateConfirmationButton]: Deactivates the confirm, yes and save buttons.
class AppPopup {
  /// Return whether the [PopupDialog] is currently active, even if hidden.
  static bool get isActive => isPopupDialogDisplayedNotifier.value;

  /// Show a success message [PopupDialog] with the given [message].
  ///
  /// It always shows the 'confirm' button, but no close button.
  static void successMessage({
    required BuildContext context,
    required String message,
  }) {
    showSuccessMessage(context: context, message: message);
  }

  /// Show a failed message [PopupDialog] with the given [message].
  ///
  /// It always shows the 'confirm' button, but no close button.
  static void failedMessage({
    required BuildContext context,
    required String message,
  }) {
    showFailedMessage(context: context, message: message);
  }

  /// Show an informational message [PopupDialog] with the given [message].
  ///
  /// It allows for the 'confirm' and 'deny' buttons and/or the 'yes' and 'no' buttons.
  /// If either pair is used, the close button at the top will be removed.
  static void infoMessage({
    required BuildContext context,
    required String message,
    final VoidCallback? onConfirm,
    final VoidCallback? onDeny,
    final VoidCallback? onYes,
    final VoidCallback? onNo,
  }) {
    showInformationMessage(
      context: context,
      message: message,
      onConfirm: onConfirm,
      onDeny: onDeny,
      onYes: onYes,
      onNo: onNo,
    );
  }

  /// Show a warning message [PopupDialog] with the given [message].
  ///
  /// It allows for the 'confirm' and 'deny' buttons and/or the 'yes' and 'no' buttons.
  /// If either pair is used, the close button at the top will be removed.
  static void warningMessage({
    required BuildContext context,
    required String message,
    final VoidCallback? onConfirm,
    final VoidCallback? onDeny,
    final VoidCallback? onYes,
    final VoidCallback? onNo,
  }) {
    showWarningMessage(
      context: context,
      message: message,
      onConfirm: onConfirm,
      onDeny: onDeny,
      onYes: onYes,
      onNo: onNo,
    );
  }

  /// Show a error message [PopupDialog] with the given [message].
  ///
  /// It always shows the 'confirm' button, but no close button.
  static void errorMessage({
    required BuildContext context,
    required String message,
    final VoidCallback? onConfirm,
  }) {
    showErrorMessage(context: context, message: message, onConfirm: onConfirm);
  }

  /// Show a loading [PopupDialog] with the given [message].
  ///
  /// It has no buttons at all, not even the close button.
  /// - Use [AppPopup.hide] to close it.
  /// - Use [AppPopup.updateMessage] to update the [message].
  static void loadingDialog({
    required BuildContext context,
    required String message,
  }) {
    showLoadingDialog(context: context, message: message);
  }

  /// Show the [PopupDialog] with the given [widget] as content.
  static void widgetDialog({
    required BuildContext context,
    required String title,
    required Widget widget,
    final bool hasCloseButton = true,
    final VoidCallback? onClose,
    final VoidCallback? onConfirm,
    final VoidCallback? onDeny,
    final VoidCallback? onYes,
    final VoidCallback? onNo,
    final Function(Map<String, dynamic>)? onSave,
    final VoidCallback? onCancel,
    final Function(String)? onDelete,
  }) {
    showWidgetDialog(
      context: context,
      title: title,
      widget: widget,
      hasCloseButton: hasCloseButton,
      onClose: onClose,
      onConfirm: onConfirm,
      onDeny: onDeny,
      onYes: onYes,
      onNo: onNo,
      onSave: onSave,
      onCancel: onCancel,
      onDelete: onDelete,
    );
  }

  /// Update the [message] displayed on the [PopupDialog].
  static void updateMessage({required String message}) {
    updatePopupDialogMessage(message: message);
  }

  /// Dismiss the [PopupDialog], if it's currently displayed.
  ///
  /// - A [onDismiss] callback can be provided to execute custom logic when the dialog is dismissed.
  static void dismiss({
    required BuildContext context,
    VoidCallback? onDismiss,
  }) {
    dismissPopupDialog(context: context, onDismiss: onDismiss);
  }

  /// Make the [PopupDialog] invisible, if it's currently displayed.
  ///
  /// This can be useful to temporarily hide the [PopupDialog] without dismissing it.
  /// It can be made visible again using [AppPopup.show].
  static void hide() {
    isPopupDialogVisibleNotifier.value = false;
  }

  /// Make the [PopupDialog] visible again, if it's currently hidden.
  ///
  /// Note: This does not display the [PopupDialog] if it was dismissed!
  static void show() {
    isPopupDialogVisibleNotifier.value = true;
  }

  /// Activate the confirm, yes and save buttons on the [PopupDialog].
  static void activateConfirmationButton() {
    setConfirmationButtonsActive();
  }

  /// Deactivate the confirm, yes and save buttons on the [PopupDialog].
  static void deactivateConfirmationButton() {
    setConfirmationButtonsInactive();
  }
}
