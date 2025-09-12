// load_roles_data.dart
//
// This loads the roles data from a JSON file.
// NOTE: This must be read and write, because the data might change during runtime.
// NOTE: This won't work for web apps, because web apps cannot access local files!
//
// DEV: For web apps, the JSON file needs to be outsourced into a proper database!

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_playground/app/app_router/app_router.dart';

List<dynamic>? rolesData;

/// Loads roles JSON file and parses it into a list.
Future<void> loadRolesData() async {
  if (kIsWeb) {
    // Web apps cannot access local files! Remove this exception after switching to a proper database.
    appRouter.go('/500-internal-server-error');
    throw Exception('Web platform is not supported for "dart:io".');
  }

  // Load the roles data JSON file.
  try {
    final file = File('lib/app/roles/data/roles.json');

    // Load the roles data.
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      rolesData = json.decode(jsonData) as List<dynamic>?;
    } else {
      rolesData = [];
    }
  } catch (e) {
    throw Exception('Loading roles data failed: $e');
  }

  // Make sure the roles data is loaded.
  if (rolesData == null) {
    throw Exception('Roles data not loaded.');
  }
}
