// generate_pbkdf2_hash.dart
//

import 'dart:convert';
import 'package:pointycastle/export.dart';

/// Generates a hash for the given [text] and [salt] using PBKDF2.
///
/// NOTE: Changing the [iterations] will result in existing passwords becoming invalid!
String generatePbkdf2Hash({
  required String text,
  required String salt,
  int iterations = 20000, // Never below 10000, because too unsecure!
  int keyLength = 32,
}) {
  final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
  final params = Pbkdf2Parameters(utf8.encode(salt), iterations, keyLength);
  pbkdf2.init(params);

  final key = pbkdf2.process(utf8.encode(text));
  return key.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
