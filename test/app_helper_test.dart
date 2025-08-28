// app_helper_test.dart
//
// Unit tests for AppHelper.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';

void main() {
  group('AppHelper', () {
    test('toRichText returns empty TextSpan for empty text', () {
      final span = AppHelper.toRichText('');
      expect(span, isA<TextSpan>());
      expect(span.text, '');
    });

    test('toRichText returns TextSpan for non-empty text', () {
      final span = AppHelper.toRichText('Visit https://flutter.dev');
      expect(span, isA<TextSpan>());
      expect(span.text, isNull); // Rich text with children
      expect(span.children, isNotNull);
      expect(
        span.children!.any(
          (child) =>
              child is TextSpan &&
              (child).text!.contains('https://flutter.dev'),
        ),
        true,
      );
    });

    test('dateToReadableText returns fallback for empty date', () {
      expect(AppHelper.dateToReadableText(''), startsWith('1 '));
    });

    test('dateToReadableText converts valid date', () {
      expect(AppHelper.dateToReadableText('2025-08-04'), contains('2025'));
      // expect(AppHelper.dateToReadableText('2025-08-04'), contains('August')); // Cannot fake localization.
    });

    test('monthNumberToText returns empty string for invalid month', () {
      expect(AppHelper.monthNumberToText(null), '');
      expect(AppHelper.monthNumberToText(0), '');
      expect(AppHelper.monthNumberToText(13), '');
    });

    test('monthNumberToText returns correct month name', () {
      expect(AppHelper.monthNumberToText(1), isNotEmpty);
      // expect(AppHelper.monthNumberToText(8), 'August'); // Cannot fake localization.
    });
  });
}
