// convert_to_rich_text.dart
//

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_playground/app/app_theme/app_theme.dart';

/// Make a TextSpan to use in a RichText widget with clickable URLs out of the given text.
TextSpan convertToRichText({required String text, TextStyle? style}) {
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
