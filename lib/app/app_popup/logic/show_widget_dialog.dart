// show_widget_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_popup/widgets/popup_dialog.dart';

/// Show [PopupDialog] with the given [widget] as content.
void showWidgetDialog({
  required BuildContext context,
  required String title,
  required Widget widget,
  final bool hasCloseButton = true,
  VoidCallback? onClose,
  VoidCallback? onConfirm,
  VoidCallback? onDeny,
  VoidCallback? onYes,
  VoidCallback? onNo,
  Function(Map<String, dynamic>)? onSave,
  VoidCallback? onCancel,
  Function(String)? onDelete,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PopupDialog(
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
    },
    useSafeArea: true,
  );
}
