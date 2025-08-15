// generate_argon2_salt.dart
//

import 'dart:math';
import 'dart:convert';

/// Generates a random salt for Argon2 hashing.
String generateArgon2Salt([int length = 16]) {
  final rng = Random.secure();
  final saltBytes = List<int>.generate(length, (_) => rng.nextInt(256));
  return base64Url.encode(saltBytes);
}
