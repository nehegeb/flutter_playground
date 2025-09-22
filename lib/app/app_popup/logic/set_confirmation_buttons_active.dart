// set_confirmation_buttons_active.dart
//

import 'package:flutter_playground/app/app_popup/app_popup.dart';

/// Updates the confirmation button state displayed in the [PopupDialog].
/// It updates the [isConfirmationButtonActiveNotifier].
/// This then updates the [PopupDialog] to activate the confirm, yes and save buttons.
void setConfirmationButtonsActive() {
  isConfirmationButtonActiveNotifier.value = true;
}
