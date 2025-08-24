// get_empty_app_language.dart
//

import 'package:flutter_playground/app/localization/localization.dart';

/// Generates and returns an empty [AppLanguage] with id '0'.
AppLanguage getEmptyAppLanguage() {
  return AppLanguage(id: 0, idTitle: '', name: '');
}
