// show_widget_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/widgets/popup_dialog.dart';

void showWidgetDialog({
  required BuildContext context,
  required String title,
  required Widget widget,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopupDialog(title: title, widget: widget);
    },
    useSafeArea: true,
  );
}
