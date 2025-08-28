// show_information_message.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/widgets/popup_dialog.dart';

void showInformationMessage({
  required BuildContext context,
  required String message,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopupDialog(message: message, isInformation: true);
    },
    useSafeArea: true,
  );
}
