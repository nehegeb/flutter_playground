// app_popup.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/logic/show_success_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_information_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_warning_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_error_message.dart';
import 'package:flutter_playground/app/app_popup/logic/show_loading_dialog.dart';
import 'package:flutter_playground/app/app_popup/logic/show_widget_dialog.dart';
import 'package:flutter_playground/app/app_popup/logic/update_popup_dialog_message.dart';
import 'package:flutter_playground/app/app_popup/logic/hide_popup_dialog.dart';

/// Notifier whether the [PopupDialog] is currently displayed.
final ValueNotifier<bool> isPopupDialogDisplayedNotifier = ValueNotifier<bool>(
  false,
);

/// Notifier for the message displayed on the [PopupDialog].
final ValueNotifier<String?> popupDialogMessageNotifier =
    ValueNotifier<String?>(null);

/// A helper class containing methods for various popup widgets.
///
/// It opens a popup dialog in the center of the screen,
/// while the app behind is faded out and not interactable.
///
/// Static Methods:
/// - [successMessage]: Shows a success message [PopupDialog].
/// - [infoMessage]: Shows an informational message [PopupDialog].
/// - [warningMessage]: Shows a warning message [PopupDialog].
/// - [errorMessage]: Shows an error message [PopupDialog].
/// - [loadingDialog]: Shows a loading [PopupDialog].
/// - [widgetDialog]: Shows a [PopupDialog] with the given [widget] as content.
/// - [updateMessage]: Updates the message of the currently displayed [PopupDialog].
/// - [hide]: Hides the currently displayed [PopupDialog]. Mainly for [loadingDialog].
class AppPopup {
  /// Show an success message popup dialog.
  static void successMessage({
    required BuildContext context,
    required String message,
  }) {
    showSuccessMessage(context: context, message: message);
  }

  /// Show an informational message popup dialog.
  static void infoMessage({
    required BuildContext context,
    required String message,
  }) {
    showInformationMessage(context: context, message: message);
  }

  /// Show a warning message popup dialog.
  static void warningMessage({
    required BuildContext context,
    required String message,
  }) {
    showWarningMessage(context: context, message: message);
  }

  /// Show a error message popup dialog.
  static void errorMessage({
    required BuildContext context,
    required String message,
  }) {
    showErrorMessage(context: context, message: message);
  }

  /// Show an loading popup dialog.
  static void loadingDialog({
    required BuildContext context,
    required String message,
  }) {
    showLoadingDialog(context: context, message: message);
  }

  /// Show a popup dialog with the given [widget] as content.
  static void widgetDialog({
    required BuildContext context,
    required String title,
    required Widget widget,
  }) {
    showWidgetDialog(context: context, title: title, widget: widget);
  }

  /// Update the [message] displayed on the [PopupDialog].
  static void updateMessage({required String message}) {
    updatePopupDialogMessage(message: message);
  }

  /// Hide the [PopupDialog], if it's currently displayed.
  static void hide({required BuildContext context}) {
    hidePopupDialog(context: context);
  }
}
