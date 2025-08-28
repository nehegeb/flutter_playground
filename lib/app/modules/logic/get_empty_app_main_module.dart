// get_empty_app_main_module.dart
//

import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/modules/modules.dart';

/// Generates and returns an empty [AppMainModule].
AppMainModule getEmptyAppMainModule() {
  return AppMainModule(id: AppHelper.uuid, idTitle: '');
}
