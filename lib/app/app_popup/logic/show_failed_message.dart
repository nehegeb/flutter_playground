// show_failed_message.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/widgets/popup_dialog.dart';

/// Show a failed message [PopupDialog] with the given [message].
void showFailedMessage({
  required BuildContext context,
  required String message,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      /// Use an empty function for [onConfirm].
      /// This makes sure the corresponding button is always displayed.
      return PopupDialog(
        message: message,
        isFailed: true,
        hasCloseButton: false,
        onConfirm: () {},
      );
    },
    useSafeArea: true,
  );
}
