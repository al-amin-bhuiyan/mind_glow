import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/api_response_model.dart';
import '../utils/app_constants.dart';

class ApiService {
  ApiService._();
  static final ApiService _instance = ApiService._();

  static ApiService get instance => _instance;

  final http.Client _client = http.Client();

  Uri _buildUri(String endpoint) {
    return Uri.parse('${AppConstants.baseUrl}$endpoint');
  }

  Map<String, String> _defaultHeaders({String? token}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<ApiResponse<Map<String, dynamic>>> post({
    required String endpoint,
    required Map<String, dynamic> body,
    String? token,
    int? timeoutSeconds,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      debugPrint('🌐 [ApiService] POST Request to: $uri');
      final headers = _defaultHeaders(token: token);
      debugPrint('🌐 [ApiService] Headers: $headers');
      debugPrint('🌐 [ApiService] Body: ${jsonEncode(body)}');

      final response = await _client
          .post(uri, headers: headers, body: jsonEncode(body))
          .timeout(
            Duration(seconds: timeoutSeconds ?? AppConstants.connectTimeoutSeconds),
          );

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.error(
        message: 'No internet connection. Please check your network.',
        statusCode: 0,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Something went wrong: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> get({
    required String endpoint,
    String? token,
    int? timeoutSeconds,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      debugPrint('🌐 [ApiService] GET Request to: $uri');
      final headers = _defaultHeaders(token: token);
      debugPrint('🌐 [ApiService] Headers: $headers');

      final response = await _client
          .get(uri, headers: headers)
          .timeout(
            Duration(seconds: timeoutSeconds ?? AppConstants.connectTimeoutSeconds),
          );

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.error(
        message: 'No internet connection. Please check your network.',
        statusCode: 0,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Something went wrong: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> delete({
    required String endpoint,
    String? token,
    int? timeoutSeconds,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      debugPrint('🌐 [ApiService] DELETE Request to: $uri');
      final headers = _defaultHeaders(token: token);
      debugPrint('🌐 [ApiService] Headers: $headers');

      final response = await _client
          .delete(uri, headers: headers)
          .timeout(
            Duration(seconds: timeoutSeconds ?? AppConstants.connectTimeoutSeconds),
          );

      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.error(
        message: 'No internet connection. Please check your network.',
        statusCode: 0,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Something went wrong: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> patchMultipart({
    required String endpoint,
    required Map<String, String> fields,
    File? file,
    String? fileField,
    String? token,
    int? timeoutSeconds,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      debugPrint('🌐 [ApiService] PATCH Multipart Request to: $uri');
      
      final request = http.MultipartRequest('PATCH', uri);
      
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.headers['Accept'] = 'application/json';

      request.fields.addAll(fields);
      debugPrint('🌐 [ApiService] Fields: $fields');

      if (file != null && fileField != null) {
        debugPrint('🌐 [ApiService] Attaching file: ${file.path} to field: $fileField');
        request.files.add(
          await http.MultipartFile.fromPath(
            fileField,
            file.path,
          ),
        );
      }

      final streamedResponse = await _client.send(request).timeout(
        Duration(seconds: timeoutSeconds ?? AppConstants.connectTimeoutSeconds),
      );

      final response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } on SocketException {
      return ApiResponse.error(
        message: 'No internet connection. Please check your network.',
        statusCode: 0,
      );
    } catch (e) {
      return ApiResponse.error(
        message: 'Something went wrong: ${e.toString()}',
        statusCode: 0,
      );
    }
  }

  ApiResponse<Map<String, dynamic>> _handleResponse(http.Response response) {
    try {
      debugPrint('🟢 API Status Code: ${response.statusCode}');
      
      // Ensure Proper UTF-8 decoding to preserve special characters in strings like "bɘniɒlqxƎ noiɟɔɘlʇɘЯ ɒvɒᒐ"
      final String decodedBody = utf8.decode(response.bodyBytes);
      debugPrint('🟢 API Raw Response: $decodedBody');
      
      final trimmedBody = decodedBody.trim();
      final Map<String, dynamic> data;
      if (trimmedBody.isEmpty) {
        data = <String, dynamic>{};
      } else {
        final decoded = jsonDecode(trimmedBody);
        data = decoded is Map<String, dynamic>
            ? decoded
            : <String, dynamic>{'data': decoded};
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.success(data: data, statusCode: response.statusCode);
      } else {
        final errorMsg = _extractErrorMessage(data, response.statusCode);
        return ApiResponse.error(message: errorMsg, statusCode: response.statusCode);
      }
    } catch (e) {
      debugPrint('🔴 API Parse Exception: $e');
      debugPrint('🔴 Faulty Body: ${response.body}');
      return ApiResponse.error(
        message: 'Failed to parse response.',
        statusCode: response.statusCode,
      );
    }
  }

  String _extractErrorMessage(Map<String, dynamic> data, int statusCode) {
    if (data.containsKey('non_field_errors')) {
      final errors = data['non_field_errors'];
      if (errors is List && errors.isNotEmpty) return errors.first.toString();
    }
    if (data.containsKey('detail')) return data['detail'].toString();
    if (data.containsKey('message')) return data['message'].toString();
    if (data.containsKey('error')) return data['error'].toString();

    // Fallback for Django field-level validation errors (e.g. {"email": ["Email already exists."]})
    for (var key in data.keys) {
      if (data[key] is List && (data[key] as List).isNotEmpty) {
        return (data[key] as List).first.toString();
      } else if (data[key] is String) {
        return data[key].toString();
      }
    }

    return 'Request failed with status $statusCode';
  }
}