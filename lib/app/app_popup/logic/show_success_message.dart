// show_success_message.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/widgets/popup_dialog.dart';

/// Show a success message [PopupDialog] with the given [message].
void showSuccessMessage({
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
        isSuccess: true,
        hasCloseButton: false,
        onConfirm: () {},
      );
    },
    useSafeArea: true,
  );
}
