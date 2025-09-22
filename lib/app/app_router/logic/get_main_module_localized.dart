// get_main_module_localized.dart
//

import 'package:flutter_playground/app/localization/localization.dart';
import 'package:flutter_playground/app/app_router/app_router_utils.dart';

/// Returns the localized title of the current main module.
/// It extracts the first segment of the current route's path.
String getMainModuleLocalized(context) {
  // Get the current main module from the router.
  final module = AppRouterUtils.getMainModule(context);

  // Get the localized title for the module.
  final moduleName = Localization.getText('modules.$module.title');

  // If no localization is found, return an empty string.
  return moduleName != '[NO_LOCALIZATION]' ? moduleName : '';
}
