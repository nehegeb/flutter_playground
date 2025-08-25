// get_empty_app_role.dart
//

import 'package:flutter_playground/app/roles/roles.dart';

/// Generates and returns an empty [AppRole] with id '0'.
AppRole getEmptyAppRole() {
  return AppRole(
    id: 0,
    idTitle: '',
    mainModuleIdTitle: '',
    subModuleIdTitle: '',
  );
}
