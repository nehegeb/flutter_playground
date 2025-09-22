// set_confirmation_buttons_inactive.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';

/// Updates the confirmation button state displayed in the [PopupDialog].
/// It updates the [isConfirmationButtonActiveNotifier].
/// This then updates the [PopupDialog] to deactivate the confirm, yes and save buttons.
void setConfirmationButtonsInactive() {
  isConfirmationButtonActiveNotifier.value = false;
}
