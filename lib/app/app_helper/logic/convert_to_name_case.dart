// convert_to_name_case.dart
//

/// Converts the given [text] string to 'Name Case' (capitalize each word).
String convertToNameCase({required String text}) {
  return text
      .split(' ')
      .map(
        (word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '',
      )
      .join(' ');
}
