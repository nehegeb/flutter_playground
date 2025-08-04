// convert_date_to_text.dart
//

import 'package:flutter_playground/app/app_helper/app_helper.dart';

/// Converts a date string in the format 'YYYY-MM-DD' to a more readable text format.
/// Returns a string in the format 'DD Month YYYY'.
String convertDateToText({required String date}) {
  try {
    final DateTime parsedDate = DateTime.parse(date);
    return '${parsedDate.day} ${AppHelper.monthNumberToText(parsedDate.month)} ${parsedDate.year}';
  } catch (e) {
    // If parsing fails, return something else to display instead of crashing.
    return '1 ${AppHelper.monthNumberToText(1)} 2000'; // Fallback date.
  }
}
