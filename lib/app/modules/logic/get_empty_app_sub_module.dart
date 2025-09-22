// get_empty_app_sub_module.dart
//

import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/modules/modules.dart';

/// Generates and returns an empty [AppSubModule].
AppSubModule getEmptyAppSubModule() {
  return AppSubModule(id: AppHelper.uuid, idTitle: '', mainModuleIdTitle: '');
}
