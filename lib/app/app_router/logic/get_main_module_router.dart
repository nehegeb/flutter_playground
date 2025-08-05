// get_main_module_router.dart
//

import 'package:go_router/go_router.dart';

/// Returns the current main module.
/// It extracts the first segment of the current route's path.
String getMainModuleRouter(context) {
  final location = GoRouter.of(
    context,
  ).routeInformationProvider.value.uri.toString();
  final uri = Uri.parse(location);
  final segments = uri.pathSegments;
  final module = segments.isNotEmpty ? segments.first : '';

  return module;
}
