// update_popup_dialog_message.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';

/// Updates the message displayed in the [PopupDialog].
/// It updates the [popupDialogMessageNotifier] with the given [message].
/// This then updates the [PopupDialog] to display the new message.
void updatePopupDialogMessage({required String message}) {
  popupDialogMessageNotifier.value = message;
}
