// check_entered_password_strength.dart
//

/// Checks the strength of a given [password] and returns an appropriate message.
String checkEnteredPasswordStrength({required String password}) {
  // Check the given [password] and return an error message if it's too weak.
  if (password.length < 8) {
    return 'errors.passwordTooShort';
  }
  if (!RegExp(r"[A-Z]").hasMatch(password)) {
    return 'errors.passwordNoUppercase';
  }
  if (!RegExp(r"[a-z]").hasMatch(password)) {
    return 'errors.passwordNoLowercase';
  }
  if (!RegExp(r"[0-9]").hasMatch(password)) {
    return 'errors.passwordNoNumber';
  }
  if (!RegExp(r"[!@#$%^&*(),.?:{}|<>]").hasMatch(password)) {
    return 'errors.passwordNoSpecial';
  }

  // If all checks pass, return no error message.
  return '';
}
