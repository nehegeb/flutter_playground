// api_exception.dart
//

/// A class to handle API exceptions.
class ApiException implements Exception {
  final int? statusCode;
  final String message;

  ApiException(this.message, {this.statusCode});
}
