// generate_argon2_hash.dart
//

import 'dart:typed_data';
import 'package:argon2/argon2.dart';

/// Generates a hash for the given text using Argon2.
String generateArgon2Hash({required String text, required String salt}) {
  // Convert the salt to bytes.
  var saltBytes = salt.toBytesLatin1();

  // Define the parameters for Argon2.
  var parameters = Argon2Parameters(
    Argon2Parameters.ARGON2_i,
    saltBytes,
    version: Argon2Parameters.ARGON2_VERSION_10,
    iterations: 2,
    memoryPowerOf2: 16,
  );

  // Generate Argon2 hash.
  var argon2 = Argon2BytesGenerator();
  argon2.init(parameters);
  var passwordBytes = parameters.converter.convert(text);
  var result = Uint8List(32);
  argon2.generateBytes(passwordBytes, result, 0, result.length);
  var resultHex = result.toHexString();

  return resultHex;
}
