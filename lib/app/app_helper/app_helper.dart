// app_helper.dart
//

import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/logic/generate_uuid.dart';
import 'package:flutter_playground/app/app_helper/logic/convert_to_name_case.dart';
import 'package:flutter_playground/app/app_helper/logic/convert_to_rich_text.dart';
import 'package:flutter_playground/app/app_helper/logic/convert_date_to_text.dart';
import 'package:flutter_playground/app/app_helper/logic/convert_month_to_text.dart';

/// A helper class containing methods for various logic widgets.
///
/// Static Methods:
/// - [uuid]: Generates a new UUID.
/// - [toNameCase]: Converts a string to 'Name Case' (capitalize each word).
/// - [toRichText]: Converts a string to a TextSpan with clickable URLs.
/// - [dateToReadableText]: Converts a date string to a more readable format.
/// - [monthNumberToText]: Converts a month number to its corresponding text representation.
class AppHelper {
  /// Generates a new UUID.
  /// Returns a UUID like '00000000-aaaa-0000-aaaa-000000000000'.
  static String get uuid {
    return generateUuid();
  }

  /// Converts a string to 'Name Case' (capitalize each word).
  static String toNameCase(String text) {
    // If the given [text] is empty, return an empty string.
    if (text.isEmpty) return '';

    return convertToNameCase(text: text);
  }

  /// Make a TextSpan to use in a RichText widget with clickable URLs out of the given text.
  static TextSpan toRichText(String text, {TextStyle? style}) {
    // If no text is provided, return an empty TextSpan.
    if (text.isEmpty) return TextSpan(text: '', style: style);

    return convertToRichText(text: text, style: style);
  }

  /// Converts a date string in the format 'YYYY-MM-DD' to a more readable text format.
  /// Returns a string in the format 'DD Month YYYY'.
  static String dateToReadableText(String date) {
    // If the date is empty or null, return a fallback date.
    if (date.isEmpty) return '1 ${monthNumberToText(1)} 2000';

    return convertDateToText(date: date);
  }

  /// Converts a month number to its corresponding text representation.
  /// Returns an empty string if the month number is invalid.
  static String monthNumberToText(int? month) {
    // If the month is empty or out of range, return an empty string.
    if (month == null || month < 1 || month > 12) return '';

    return convertMonthToText(month: month);
  }
}
