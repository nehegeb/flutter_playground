// show_loading_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/widgets/popup_dialog.dart';

/// Show a loading [PopupDialog] with the given [message].
void showLoadingDialog({
  required BuildContext context,
  required String message,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopupDialog(
        message: message,
        isLoading: true,
        hasCloseButton: false,
      );
    },
    useSafeArea: true,
  );
}
