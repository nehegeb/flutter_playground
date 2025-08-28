// generate_uuid.dart
//

import 'package:uuid/uuid.dart';

/// Generates a new UUID.
String generateUuid() {
  var uuid = Uuid();
  return uuid.v4();
}
