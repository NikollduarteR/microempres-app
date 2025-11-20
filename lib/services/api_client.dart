import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_config.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  ApiClient({http.Client? httpClient}) : _client = httpClient ?? http.Client();

  final http.Client _client;

  static const Map<String, String> _defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final response = await _client.get(uri, headers: _mergeHeaders(headers));
    return _decodeResponse(response);
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final response = await _client.post(
      uri,
      headers: _mergeHeaders(headers),
      body: jsonEncode(body ?? <String, dynamic>{}),
    );
    return _decodeResponse(response);
  }

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final response = await _client.put(
      uri,
      headers: _mergeHeaders(headers),
      body: jsonEncode(body ?? <String, dynamic>{}),
    );
    return _decodeResponse(response);
  }

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(path, queryParameters);
    final response = await _client.delete(
      uri,
      headers: _mergeHeaders(headers),
      body: body == null ? null : jsonEncode(body),
    );
    return _decodeResponse(response);
  }

  Uri _buildUri(String path, Map<String, dynamic>? queryParameters) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final uri = Uri.parse('$apiBaseUrl$normalizedPath');
    if (queryParameters == null || queryParameters.isEmpty) {
      return uri;
    }
    final stringParams = <String, String>{};
    for (final entry in queryParameters.entries) {
      if (entry.value == null) continue;
      stringParams[entry.key] = entry.value.toString();
    }
    return uri.replace(queryParameters: stringParams);
  }

  Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    if (headers == null) return _defaultHeaders;
    return {..._defaultHeaders, ...headers};
  }

  dynamic _decodeResponse(http.Response response) {
    final statusCode = response.statusCode;
    final bodyString = utf8.decode(response.bodyBytes);
    if (statusCode >= 200 && statusCode < 300) {
      if (bodyString.isEmpty) return null;
      return jsonDecode(bodyString);
    }
    throw ApiException(statusCode, bodyString.isEmpty ? 'Error' : bodyString);
  }
}

final ApiClient apiClient = ApiClient();
