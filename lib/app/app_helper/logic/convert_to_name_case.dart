// convert_to_name_case.dart
//

/// Converts a string to 'Name Case' (capitalize each word).
String convertToNameCase({required String input}) {
  return input
      .split(' ')
      .map(
        (word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1)}'
            : '',
      )
      .join(' ');
}
