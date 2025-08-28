// get_empty_app_role.dart
//

import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/roles/roles.dart';

/// Generates and returns an empty [AppRole].
AppRole getEmptyAppRole() {
  return AppRole(
    id: AppHelper.uuid,
    idTitle: '',
    mainModuleIdTitle: '',
    subModuleIdTitle: '',
  );
}
