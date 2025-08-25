// get_main_module_of_permission.dart
//

/// Get the main module for the given [permission].
///
/// If no [permission] is given, return ''.
/// If no main module is found, return 'main' for the 'main' main module.
String getMainModuleOfPermission({required String permission}) {
  // If no [permission] is given, return ''.
  if (permission.isEmpty) {
    return '';
  }

  String mainModule = '';

  // If there are more than one parts in the [permission]
  // take the first part of the [permission] as the main module.
  final permissionParts = permission.split('.');
  if (permissionParts.length > 1) {
    mainModule = permissionParts[0];
  }

  // Return the found main module, or 'main'.
  return mainModule.isNotEmpty ? mainModule : 'main';
}
