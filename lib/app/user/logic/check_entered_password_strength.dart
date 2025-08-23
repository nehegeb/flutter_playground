// check_entered_password_strength.dart
//

import 'package:flutter_playground/app/localization/localization.dart';

/// Checks the strength of a given [password] and returns an appropriate message.
String checkEnteredPasswordStrength({required String password}) {
  // Check the given [password] and return an error message if it's too weak.
  if (password.length < 8) {
    return Localization.getText('errors.passwordTooShort');
  }
  if (!RegExp(r"[A-Z]").hasMatch(password)) {
    return Localization.getText('errors.passwordNoUppercase');
  }
  if (!RegExp(r"[a-z]").hasMatch(password)) {
    return Localization.getText('errors.passwordNoLowercase');
  }
  if (!RegExp(r"[0-9]").hasMatch(password)) {
    return Localization.getText('errors.passwordNoNumber');
  }
  if (!RegExp(r"[!@#$%^&*(),.?:{}|<>]").hasMatch(password)) {
    return Localization.getText('errors.passwordNoSpecial');
  }

  // If all checks pass, return no error message.
  return '';
}
