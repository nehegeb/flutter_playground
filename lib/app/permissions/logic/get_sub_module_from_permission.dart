// get_sub_module_from_permission.dart
//

/// Get the sub module for the given [permission].
///
/// If no sub module is found, return 'main' for the main page of any [AppSubModule].
String getSubModuleFromPermission({required String permission}) {
  // If no [permission] is given, return ''.
  if (permission.isEmpty) {
    return '';
  }

  String subModule = '';

  // If there are more than two parts in the [permission]
  // take the second part of the [permission] as the sub module.
  final permissionParts = permission.split('.');
  if (permissionParts.length > 2) {
    subModule = permissionParts[1];
  }

  // Return the found sub module, or 'main'.
  return subModule.isNotEmpty ? subModule : 'main';
}
