// get_empty_app_user.dart
//

import 'package:flutter_playground/app/user/user.dart';

/// Generates and returns an empty [AppUser] with id '0'.
AppUser getEmptyAppUser() {
  return AppUser(
    id: 0,
    email: '',
    name: '',
    title: '',
    passwordHash: '',
    passwordSalt: '',
  );
}
