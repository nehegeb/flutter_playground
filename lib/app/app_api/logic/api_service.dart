// api_service.dart
//

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_playground/app/app_api/logic/api_exception.dart';

/// A service class to handle API requests.
class ApiService {
  /// Make a GET request to the given [url].
  static Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        throw ApiException(
          'API error: ${response.statusCode}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ApiException('Network error: $e');
    }
  }
}
