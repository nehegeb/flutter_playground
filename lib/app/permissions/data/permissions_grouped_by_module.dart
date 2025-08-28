// permissions_grouped_by_module.dart
//

import 'package:flutter_playground/app/permissions/permissions.dart';

/// All permissions grouped by modules.
/// This is needed to get the permissions for a specific module.
class PermissionsGroupedByModule {
  static final Map<String, List<String>> get = {
    // Main [AppMainModule].
    'main': [
      Permissions.main.access,
      Permissions.main.view,
      Permissions.main.edit,
      Permissions.main.delete,
      Permissions.main.restore,
    ],

    // Template [AppMainModule].
    'template': [
      Permissions.template.access,
      Permissions.template.view,
      Permissions.template.edit,
      Permissions.template.delete,
      Permissions.template.restore,
    ],
    'template.template': [
      Permissions.template.template.access,
      Permissions.template.template.view,
      Permissions.template.template.edit,
      Permissions.template.template.delete,
      Permissions.template.template.restore,
    ],
    'template.permissions': [
      Permissions.template.permissions.access,
      Permissions.template.permissions.view,
      Permissions.template.permissions.edit,
      Permissions.template.permissions.delete,
      Permissions.template.permissions.restore,
    ],

    // Settings [AppMainModule].
    'settings': [
      Permissions.settings.access,
      Permissions.settings.view,
      Permissions.settings.edit,
      Permissions.settings.delete,
      Permissions.settings.restore,
    ],
    'settings.permissions': [
      Permissions.settings.permissions.access,
      Permissions.settings.permissions.view,
      Permissions.settings.permissions.edit,
      Permissions.settings.permissions.delete,
      Permissions.settings.permissions.restore,
    ],
  };
}
