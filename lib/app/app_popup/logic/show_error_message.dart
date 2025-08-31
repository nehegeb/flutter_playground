// show_error_message.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/widgets/popup_dialog.dart';

/// Show a error message [PopupDialog] with the given [message].
void showErrorMessage({
  required BuildContext context,
  required String message,
  VoidCallback? onConfirm,
}) {
  /// Use an empty function that is used if no callback is given.
  /// This makes sure the corresponding button is always displayed,
  /// even if no callback is given.
  onConfirm ??= () {};

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopupDialog(
        message: message,
        isError: true,
        hasCloseButton: false,
        onConfirm: onConfirm,
      );
    },
    useSafeArea: true,
  );
}
