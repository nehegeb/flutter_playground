// show_warning_message.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/widgets/popup_dialog.dart';

/// Show a warning message [PopupDialog] with the given [message].
void showWarningMessage({
  required BuildContext context,
  required String message,
  final bool hasCloseButton = true,
  VoidCallback? onConfirm,
  VoidCallback? onDeny,
  VoidCallback? onYes,
  VoidCallback? onNo,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopupDialog(
        message: message,
        isWarning: true,
        hasCloseButton: hasCloseButton,
        onConfirm: onConfirm,
        onDeny: onDeny,
        onYes: onYes,
        onNo: onNo,
      );
    },
    useSafeArea: true,
  );
}
