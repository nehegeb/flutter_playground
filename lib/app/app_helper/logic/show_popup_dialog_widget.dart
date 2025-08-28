// show_popup_dialog_widget.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/widgets/popup_dialog.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// Shows the [PopupDialog] in the center of the screen.
///
/// It features a top bar with the given [title] to the left and a close button to the right.
/// Below that is the content of the given [child].
void showPopupDialogWidget({
  required BuildContext context,
  required String title,
  required Widget child,
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // Only close when the close button is pressed.
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top bar with close button.
              Container(
                padding: const EdgeInsets.only(
                  top: 12,
                  right: 16,
                  bottom: 12,
                  left: 24,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    // Title of the [PopupDialog].
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),

                    const Spacer(),

                    // Close button.
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      tooltip: Localization.getText(
                        'misc.buttons.closeAndCancel',
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Dialog content as given per [child].
              Padding(padding: const EdgeInsets.all(24), child: child),
            ],
          ),
        ),
      );
    },
    useSafeArea: true,
  );
}
