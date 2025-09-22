// app_helper_test.dart
//
// Unit tests for the [AppHelper] utils class.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/app/app_helper/app_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppHelper', () {
    test('uuid returns a valid UUID string', () {
      final uuid = AppHelper.uuid;
      // Basic check: UUID should be a non-empty string and contain dashes
      expect(uuid, isA<String>());
      expect(uuid.isNotEmpty, isTrue);
      expect(uuid.contains('-'), isTrue);
    });

    test('toRichText returns a TextSpan', () {
      const text = 'Visit https://example.com for more info.';
      final span = AppHelper.toRichText(text);
      expect(span, isA<TextSpan>());
      expect(span.toPlainText(), contains('https://example.com'));
    });

    test('toRichText returns empty TextSpan for empty input', () {
      final span = AppHelper.toRichText('');
      expect(span, isA<TextSpan>());
      expect(span.toPlainText(), isEmpty);
    });

    test('dateToReadableText returns fallback for empty input', () {
      final result = AppHelper.dateToReadableText('');
      expect(result, isA<String>());
      expect(result, contains('2000'));
    });

    test('dateToReadableText returns readable date for valid input', () {
      final result = AppHelper.dateToReadableText('2024-07-15');
      expect(result, isA<String>());
      expect(result, contains('2024'));
      expect(result, contains('15'));
    });

    test('monthNumberToText returns empty string for invalid input', () {
      expect(AppHelper.monthNumberToText(null), '');
      expect(AppHelper.monthNumberToText(0), '');
      expect(AppHelper.monthNumberToText(13), '');
    });

    test('monthNumberToText returns month name for valid input', () {
      final month = AppHelper.monthNumberToText(1);
      expect(month, isA<String>());
      expect(month.isNotEmpty, isTrue);
    });

    // NOTE: Do not test [initAppSettings] as it initializes the whole app!
    //       All functions used there should have their own tests.
  });
}
