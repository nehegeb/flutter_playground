// get_empty_app_user.dart
//

import 'package:flutter_playground/app/user/user.dart';

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
