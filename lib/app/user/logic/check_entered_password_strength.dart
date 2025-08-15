// check_entered_password_strength.dart
//

import 'package:flutter_playground/app/localization/localization.dart';

/// Checks the strength of a password and returns an appropriate message.
String checkEnteredPasswordStrength({required String password}) {
  // Check the password and return an error message if it's too weak.
  if (password.length < 8) {
    return Localization.getText('passwordTooShort');
  }
  if (!RegExp(r"[A-Z]").hasMatch(password)) {
    return Localization.getText('passwordNoUppercase');
  }
  if (!RegExp(r"[a-z]").hasMatch(password)) {
    return Localization.getText('passwordNoLowercase');
  }
  if (!RegExp(r"[0-9]").hasMatch(password)) {
    return Localization.getText('passwordNoNumber');
  }
  if (!RegExp(r"[!@#$%^&*(),.?:{}|<>]").hasMatch(password)) {
    return Localization.getText('passwordNoSpecial');
  }

  // If all checks pass, return no error message.
  return '';
}
