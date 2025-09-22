// get_empty_app_user.dart
//

import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/user/user.dart';

/// Generates and returns an empty [AppUser].
AppUser getEmptyAppUser() {
  return AppUser(
    id: AppHelper.uuid,
    email: '',
    name: '',
    title: '',
    passwordHash: '',
    passwordSalt: '',
  );
}
