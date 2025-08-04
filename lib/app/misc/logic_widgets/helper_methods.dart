// helper_methods.dart
//

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';
import 'package:flutter_playground/app/localization/localization.dart';

/// A helper class containing methods for various logic widgets.
///
/// Static Methods:
/// - [toNameCase]: Converts a string to 'Name Case' (capitalize each word).
/// - [toRichText]: Converts a string to a TextSpan with clickable URLs.
/// - [dateToReadableText]: Converts a date string to a more readable format.
/// - [monthNumberToText]: Converts a month number to its corresponding text representation.
class Helpers {
  /// Converts a string to 'Name Case' (capitalize each word).
  static String toNameCase(String input) {
    return input
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : '',
        )
        .join(' ');
  }

  /// Make a TextSpan to use in a RichText widget with clickable URLs out of the given text.
  static TextSpan toRichText(String text, {TextStyle? style}) {
    final urlRegex = RegExp(r'(https?:\/\/[^\s]+)', caseSensitive: false);
    final spans = <TextSpan>[];
    int start = 0;

    // Split the text into spans based on URLs.
    urlRegex.allMatches(text).forEach((match) {
      if (match.start > start) {
        spans.add(
          TextSpan(text: text.substring(start, match.start), style: style),
        );
      }
      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: style?.copyWith(color: AppTheme.appTheme.colorScheme.primary),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
        ),
      );
      start = match.end;
    });

    // Add any remaining text after the last URL.
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start), style: style));
    }

    return TextSpan(children: spans, style: style);
  }

  /// Converts a date string in the format 'YYYY-MM-DD' to a more readable text format.
  /// Returns a string in the format 'DD Month YYYY'.
  static String dateToReadableText(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return '${parsedDate.day} ${Helpers.monthNumberToText(parsedDate.month)} ${parsedDate.year}';
    } catch (e) {
      // If parsing fails, return something else to display instead of crashing.
      return '1 January 2000'; // Fallback date.
    }
  }

  /// Converts a month number to its corresponding text representation.
  /// Returns an empty string if the month number is invalid.
  static String monthNumberToText(int month) {
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
}
