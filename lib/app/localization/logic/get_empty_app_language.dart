// get_empty_app_language.dart
//

import 'package:flutter_playground/app/app_helper/app_helper.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// Generates and returns an empty [AppLanguage].
AppLanguage getEmptyAppLanguage() {
  return AppLanguage(id: AppHelper.uuid, idTitle: '', name: '');
}
