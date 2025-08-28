// permissions_settings.dart
//

/// Settings [AppMainModule] permissions.
class Settings {
  const Settings();

  final permissions = const SettingsPermissions();

  final String access = 'settings.access';
  final String view = 'settings.view';
  final String edit = 'settings.edit';
  final String delete = 'settings.delete';
  final String restore = 'settings.restore';
}

/// Permissions [AppSubModule] permissions.
class SettingsPermissions {
  const SettingsPermissions();

  final String access = 'settings.permissions.access';
  final String view = 'settings.permissions.view';
  final String edit = 'settings.permissions.edit';
  final String delete = 'settings.permissions.delete';
  final String restore = 'settings.permissions.restore';
}
