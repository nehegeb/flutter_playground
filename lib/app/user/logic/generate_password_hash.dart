// generate_password_hash.dart
//

import 'package:flutter_playground/app/user/logic/generate_pbkdf2_hash.dart';

/// Generates a hash using the given password and salt.
String generatePasswordHash({required String password, required String salt}) {
  // Use PBKDF2 for hashing.
  return generatePbkdf2Hash(text: password, salt: salt);
}
