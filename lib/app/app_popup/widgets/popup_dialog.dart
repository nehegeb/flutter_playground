// popup_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

/// Shows the a popup dialog in the center of the screen while app behind is faded out.
/// It features a top bar with the given [title] to the left and
/// a close button to the right, which can be toggled off if need be.
///
/// If one of [isSuccess], [isInformation], [isWarning], [isError], or [isLoading] is true,
/// the dialog will display an appropriate icon and message.
///
/// If a [widget] is given, it is displayed below the top bar / message (if any).
class PopupDialog extends StatelessWidget {
  final bool isSuccess;
  final bool isInformation;
  final bool isWarning;
  final bool isError;
  final bool isLoading;
  final bool hasCloseButton;
  final String? title;
  final String? message;
  final Widget? widget;

  const PopupDialog({
    super.key,
    this.isSuccess = false,
    this.isInformation = false,
    this.isWarning = false,
    this.isError = false,
    this.isLoading = false,
    this.hasCloseButton = true,
    this.title,
    this.message,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if the close button should be shown.
    bool showCloseButton = hasCloseButton;
    if (isLoading) {
      showCloseButton = false;
    }

    // Determine the close button tooltip.
    String closeButtonTooltip;
    if (widget != null) {
      closeButtonTooltip = Localization.getText('misc.buttons.closeAndCancel');
    } else {
      closeButtonTooltip = Localization.getText('misc.buttons.close');
    }

    // Determine the title to be shown.
    String? dialogTitle = title ?? '';
    if (isSuccess) {
      dialogTitle = Localization.getText('misc.messageTypes.success');
    } else if (isInformation) {
      dialogTitle = Localization.getText('misc.messageTypes.info');
    } else if (isWarning) {
      dialogTitle = Localization.getText('misc.messageTypes.warning');
    } else if (isError) {
      dialogTitle = Localization.getText('misc.messageTypes.error');
    } else if (isLoading) {
      dialogTitle = Localization.getText('misc.messageTypes.loading');
    }

    // Determine which icon should be shown for a message.
    IconData? dialogIcon;
    if (isSuccess) {
      dialogIcon = Icons.check_circle;
    } else if (isInformation) {
      dialogIcon = Icons.info;
    } else if (isWarning) {
      dialogIcon = Icons.warning;
    } else if (isError) {
      dialogIcon = Icons.error;
    } else if (isLoading) {
      dialogIcon = Icons.hourglass_top;
    }

    // Set the [PopupDialogMessageNotifier] with the [message] to display.
    popupDialogMessageNotifier.value = message;

    // Set the [isPopupDialogDisplayedNotifier] to true.
    isPopupDialogDisplayedNotifier.value = true;

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
                    dialogTitle,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),

                  const Spacer(),

                  // Close button.
                  if (showCloseButton) ...[
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      tooltip: closeButtonTooltip,
                      onPressed: () => AppPopup.hide(context: context),
                    ),
                  ],
                ],
              ),
            ),

            // Dialog content as given per [message].
            // This message can be updated using [AppPopup.updateMessage].
            ValueListenableBuilder<String?>(
              valueListenable: popupDialogMessageNotifier,
              builder: (context, dialogMessage, _) {
                if (dialogMessage != null) {
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // The dialog icon to the left, if any.
                        if (dialogIcon != null) ...[
                          Icon(
                            dialogIcon,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 24),
                        ],
                        // The message.
                        Expanded(
                          child: Text(
                            dialogMessage,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

            // Dialog content as given per [widget].
            if (widget != null) ...[
              Padding(padding: const EdgeInsets.all(24), child: widget),
            ],
          ],
        ),
      ),
    );
  }
}
