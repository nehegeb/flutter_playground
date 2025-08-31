// popup_dialog.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_popup/app_popup.dart';

/// Shows a popup dialog in the center of the screen while the app behind it is faded out.
/// It features a top bar with the given [title] to the left and
/// a close button to the right, which can be toggled off.
///
/// The close button is always visible,
/// except when [hasCloseButton] is false or
/// when at least one of the following is given:
/// [isSuccess] ; [isFailed] ; [isLoading] ; [onConfirm] AND [onDeny] ; [onYes] AND [onNo]
///
/// If one of the [is...] is true,
/// the dialog will display an appropriate icon and message.
///
/// If any of the [on...] callbacks are given,
/// it displays the corresponding button at the bottom right.
/// Upon clicking the button, the given function is executed.
/// If a button should be shown without executing a function, use 'onCancel: () {}'.
///
/// If a [widget] is given, it is displayed below the top bar / message (if any).
/// Use [popupDialogMessageNotifier] to manage the widget and its data.
///
/// If [onSave] is given, it returns the whole [popupDialogMessageNotifier] for a custom save function.
/// You can pass the data to save to your function like 'onSave: (data) => saveFunction(saveData: data)'.
///
/// If [onDelete] is given, a deletion confirmation is shown before executing the given function.
/// This returns the key 'id' of [popupDialogMessageNotifier] for a custom delete function.
/// You can pass the ID to delete to your function like 'onDelete: (id) => deleteFunction(deleteId: id)'.
class PopupDialog extends StatefulWidget {
  final bool isSuccess;
  final bool isFailed;
  final bool isInformation;
  final bool isWarning;
  final bool isError;
  final bool isLoading;
  final bool hasCloseButton;
  final VoidCallback? onClose;
  final VoidCallback? onConfirm;
  final VoidCallback? onDeny;
  final VoidCallback? onYes;
  final VoidCallback? onNo;
  final Function(Map<String, dynamic>)? onSave;
  final VoidCallback? onCancel;
  final Function(String)? onDelete;
  final String? title;
  final String? message;
  final Widget? widget;

  const PopupDialog({
    super.key,
    this.isSuccess = false,
    this.isFailed = false,
    this.isInformation = false,
    this.isWarning = false,
    this.isError = false,
    this.isLoading = false,
    this.hasCloseButton = true,
    this.onClose,
    this.onConfirm,
    this.onDeny,
    this.onYes,
    this.onNo,
    this.onSave,
    this.onCancel,
    this.onDelete,
    this.title,
    this.message,
    this.widget,
  });

  @override
  State<PopupDialog> createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  bool isDeleteConfirmationShown = false;

  showDeleteConfirmation() {
    popupDialogMessageNotifier.value = Localization.getText(
      'misc.buttons.deleteConfirmationMessage',
    );
    setState(() {
      isDeleteConfirmationShown = true;
    });
  }

  hideDeleteConfirmation() {
    popupDialogMessageNotifier.value = null;
    setState(() {
      isDeleteConfirmationShown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the close button should be shown.
    bool showCloseButton = widget.hasCloseButton;
    if (widget.isSuccess ||
        widget.isFailed ||
        widget.isLoading ||
        (widget.onConfirm != null && widget.onDeny != null) ||
        (widget.onYes != null && widget.onNo != null) ||
        isDeleteConfirmationShown) {
      showCloseButton = false;
    }

    // Determine the close button tooltip and behaviour.
    String closeButtonTooltip = '';
    VoidCallback? closeButtonBehaviour;
    if (showCloseButton) {
      if (widget.widget != null) {
        closeButtonTooltip = Localization.getText(
          'misc.buttons.closeAndCancel',
        );
        closeButtonBehaviour = () {
          if (widget.onCancel != null) {
            widget.onCancel!();
          }
          AppPopup.hide(context: context, onHide: widget.onClose);
        };
      } else {
        closeButtonTooltip = Localization.getText('misc.buttons.close');
        closeButtonBehaviour = () =>
            AppPopup.hide(context: context, onHide: widget.onClose);
      }
    }

    // Determine the title to be shown.
    String? dialogTitle = widget.title ?? '';
    if (widget.isSuccess) {
      dialogTitle = Localization.getText('misc.messageTypes.success');
    } else if (widget.isFailed) {
      dialogTitle = Localization.getText('misc.messageTypes.failed');
    } else if (widget.isInformation) {
      dialogTitle = Localization.getText('misc.messageTypes.info');
    } else if (widget.isWarning) {
      dialogTitle = Localization.getText('misc.messageTypes.warning');
    } else if (widget.isError) {
      dialogTitle = Localization.getText('misc.messageTypes.error');
    } else if (widget.isLoading) {
      dialogTitle = Localization.getText('misc.messageTypes.loading');
    }

    // Determine which icon should be shown for a message.
    IconData? dialogIcon;
    Color dialogIconColor = Theme.of(context).colorScheme.onPrimary;
    if (widget.isSuccess) {
      dialogIcon = Icons.check_circle;
      dialogIconColor = Colors.green;
    } else if (widget.isFailed) {
      dialogIcon = Icons.cancel;
      dialogIconColor = Colors.red;
    } else if (widget.isInformation) {
      dialogIcon = Icons.info;
      dialogIconColor = Colors.blue;
    } else if (widget.isWarning || isDeleteConfirmationShown) {
      dialogIcon = Icons.warning;
      dialogIconColor = Colors.orange;
    } else if (widget.isError) {
      dialogIcon = Icons.error;
      dialogIconColor = Colors.red;
    } else if (widget.isLoading) {
      dialogIcon = Icons.hourglass_top;
    }

    // Determine whether any button should be shown
    bool hasButtons = widget.onConfirm != null;
    hasButtons = hasButtons ? true : widget.onDeny != null;
    hasButtons = hasButtons ? true : widget.onYes != null;
    hasButtons = hasButtons ? true : widget.onNo != null;
    hasButtons = hasButtons ? true : widget.onSave != null;
    hasButtons = hasButtons ? true : widget.onCancel != null;

    // Set the [PopupDialogMessageNotifier] with the [message] to display.
    if (!isDeleteConfirmationShown) {
      popupDialogMessageNotifier.value = widget.message;
    }

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
                      onPressed: closeButtonBehaviour,
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 24,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // The dialog icon to the left, if any.
                        if (dialogIcon != null) ...[
                          Icon(dialogIcon, color: dialogIconColor, size: 28),
                          const SizedBox(width: 18),
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

            // If a [message] and a [widget] are shown together, add a divider inbetween.
            if (popupDialogMessageNotifier.value != null &&
                widget.widget != null &&
                !isDeleteConfirmationShown) ...[
              Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).dividerColor,
              ),
            ],

            // Dialog content as given per [widget].
            if (widget.widget != null && !isDeleteConfirmationShown) ...[
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 24,
                  top: 18,
                ),
                child: widget.widget,
              ),
            ],

            // Button area aligned to the right, if any.
            if (hasButtons && !isDeleteConfirmationShown) ...[
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  right: 14,
                  left: 14,
                  bottom: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Cancel button, if [onDelete] is given.
                    if (widget.onDelete != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextButton(
                          onPressed: () => showDeleteConfirmation(),
                          child: Text(
                            Localization.getText('misc.buttons.delete'),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),

                    // Cancel button, if [onCancel] is given.
                    if (widget.onCancel != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextButton(
                          onPressed: () => AppPopup.hide(
                            context: context,
                            onHide: widget.onCancel,
                          ),
                          child: Text(
                            Localization.getText('misc.buttons.cancel'),
                          ),
                        ),
                      ),

                    // Save button, if [onSave] is given.
                    if (widget.onSave != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            // Perform the [onSave] function before hiding the [PopupDialog].
                            widget.onSave?.call(
                              popupDialogDataNotifier.value ?? {},
                            );
                            AppPopup.hide(context: context);
                          },
                          child: Text(
                            Localization.getText('misc.buttons.save'),
                          ),
                        ),
                      ),

                    // Deny button, if [onDeny] is given.
                    if (widget.onDeny != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextButton(
                          onPressed: () => AppPopup.hide(
                            context: context,
                            onHide: widget.onDeny,
                          ),
                          child: Text(
                            Localization.getText('misc.buttons.deny'),
                          ),
                        ),
                      ),

                    // Confirm button, if [onConfirm] is given.
                    if (widget.onConfirm != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () => AppPopup.hide(
                            context: context,
                            onHide: widget.onConfirm,
                          ),
                          child: Text(
                            Localization.getText('misc.buttons.confirm'),
                          ),
                        ),
                      ),

                    // No button, if [onNo] is given.
                    if (widget.onNo != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextButton(
                          onPressed: () => AppPopup.hide(
                            context: context,
                            onHide: widget.onNo,
                          ),
                          child: Text(Localization.getText('misc.buttons.no')),
                        ),
                      ),

                    // Yes button, if [onYes] is given.
                    if (widget.onYes != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () => AppPopup.hide(
                            context: context,
                            onHide: widget.onYes,
                          ),
                          child: Text(Localization.getText('misc.buttons.yes')),
                        ),
                      ),
                  ],
                ),
              ),
            ],

            // Yes/No buttons before [onDelete] is triggered.
            if (isDeleteConfirmationShown) ...[
              Padding(
                padding: const EdgeInsets.only(
                  top: 0,
                  right: 14,
                  left: 14,
                  bottom: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // No button for deletion confirmation.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: TextButton(
                        onPressed: () => hideDeleteConfirmation(),
                        child: Text(Localization.getText('misc.buttons.no')),
                      ),
                    ),

                    // Yes button for deletion confirmation.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          // Perform the [onDelete] function before hiding the [PopupDialog].
                          widget.onDelete?.call(
                            popupDialogDataNotifier.value?['id'] ?? '',
                          );
                          AppPopup.hide(context: context);
                        },
                        child: Text(Localization.getText('misc.buttons.yes')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
