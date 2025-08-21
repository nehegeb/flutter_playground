// convert_month_to_text.dart
//

import 'package:flutter_playground/app/localization/localization.dart';

/// Converts the given [month] number to its corresponding text representation.
/// Returns an empty string if the month number is invalid.
String convertMonthToText({required int month}) {
  switch (month) {
    case 1 || 01:
      return Localization.getText('misc.months.january');
    case 2 || 02:
      return Localization.getText('misc.months.february');
    case 3 || 03:
      return Localization.getText('misc.months.march');
    case 4 || 04:
      return Localization.getText('misc.months.april');
    case 5 || 05:
      return Localization.getText('misc.months.may');
    case 6 || 06:
      return Localization.getText('misc.months.june');
    case 7 || 07:
      return Localization.getText('misc.months.july');
    case 8 || 08:
      return Localization.getText('misc.months.august');
    case 9 || 09:
      return Localization.getText('misc.months.september');
    case 10:
      return Localization.getText('misc.months.october');
    case 11:
      return Localization.getText('misc.months.november');
    case 12:
      return Localization.getText('misc.months.december');
    default:
      return '';
  }
}
