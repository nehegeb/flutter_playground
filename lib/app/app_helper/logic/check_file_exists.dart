// check_file_exists.dart
//

import 'dart:io';

/// Checks if a file exists at the given path.
/// Returns true if the file exists, false otherwise.
bool checkFileExists({required String path}) {
  return File(path).existsSync();
}
