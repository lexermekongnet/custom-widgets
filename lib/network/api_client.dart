import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:mekongnet/config.dart';

import '../resource/exceptions.dart';

const _apiTimeout = Duration(seconds: 30);
String _domainUrl = Config.domainURL;
bool _isLocal = Config.local;

/// An abstract contract class for all api calls
///
/// This class makes api package switching easy,
/// all changes should be done here
abstract class ApiClient {
  /// A [Future] method for GET api calls
  Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  /// A [Future] method for POST api calls
  Future<Response> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  /// A [Future] method for PUT api calls
  Future<Response> put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  });

  /// A [Future] method for DELETE api calls
  Future<Response> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}

/// An implementation class for [ApiClient]
class ApiClientImpl implements ApiClient {
  /// This is the http client handler
  ///
  /// [Documentation](https://pub.dev/documentation/http/latest/)
  final Client client;

  /// This is the logger instance;
  final Logger logger;

  /// This is the error handler for api calls
  final Future<void> Function({
    String url,
    String method,
    String error,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
  })?
  onError;

  /// This is the success handler for api calls
  final Future<void> Function({
    String url,
    String method,
    int statusCode,
    DateTime endTime,
    DateTime startTime,
  })?
  onSuccess;

  /// Creates the implementation instance of [ApiClient]
  ApiClientImpl({
    required this.client,
    required this.logger,
    this.onError,
    this.onSuccess,
  });

  @override
  Future<Response> get({
    required String path,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    DateTime startTime = DateTime.now();
    final apiPath = path;

    try {
      logger.d('API-GET $apiPath');

      if (query != null) logger.d(query);

      headers ??= {'Content-Type': 'application/json'};
      headers.putIfAbsent('Content-Type', () => 'application/json');

      final bearerToken = await _getBearerToken(apiPath);
      if (bearerToken != null) {
        headers.putIfAbsent('Authorization', () => 'Bearer $bearerToken');
      }
      Uri uri = Uri.https(_domainUrl, apiPath, query);
      if (_isLocal) uri = Uri.http(_domainUrl, apiPath, query);
      final response = await client
          .get(uri, headers: headers)
          .timeout(_apiTimeout);
      _handleResponseLog(response);
      DateTime endTime = DateTime.now();
      await onSuccess?.call(
        url: uri.path,
        method: 'GET',
        statusCode: response.statusCode,
        endTime: endTime,
        startTime: startTime,
      );
      return response;
    } catch (e) {
      _handleAPIError(e);
      await onError?.call(
        url: apiPath,
        method: 'POST',
        error: e.toString(),
        query: query,
      );
      rethrow;
    }
  }

  @override
  Future<Response> post({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    DateTime startTime = DateTime.now();
    final apiPath = path;

    try {
      logger.d('API-POST $apiPath');

      if (body != null) logger.d(body);
      if (query != null) logger.d(query);

      headers ??= {'Content-Type': 'application/json'};
      headers.putIfAbsent('Content-Type', () => 'application/json');

      final bearerToken = await _getBearerToken(apiPath);
      if (bearerToken != null) {
        headers.putIfAbsent('Authorization', () => 'Bearer $bearerToken');
      }
      Uri uri = Uri.https(_domainUrl, apiPath, query);
      if (_isLocal) uri = Uri.http(_domainUrl, apiPath, query);
      String encodedBody = jsonEncode(body);
      if (headers['Content-Type'] == 'application/x-www-form-urlencoded') {
        encodedBody =
            body?.entries
                .map(
                  (e) =>
                      '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent('${e.value}')}',
                )
                .join('&') ??
            '';
      }
      final response = await client
          .post(uri, body: encodedBody, headers: headers)
          .timeout(_apiTimeout);
      DateTime endTime = DateTime.now();
      _handleResponseLog(response);
      await onSuccess?.call(
        url: uri.path,
        method: 'POST',
        statusCode: response.statusCode,
        endTime: endTime,
        startTime: startTime,
      );

      return response;
    } catch (e) {
      await onError?.call(
        url: apiPath,
        method: 'POST',
        error: e.toString(),
        query: query,
        body: body,
      );
      _handleAPIError(e);
      rethrow;
    }
  }

  @override
  Future<Response> put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    DateTime startTime = DateTime.now();
    final apiPath = path;
    try {
      logger.d('API-PUT $apiPath');

      if (body != null) logger.d(body);
      if (query != null) logger.d(query);

      headers ??= {'Content-Type': 'application/json'};
      headers.putIfAbsent('Content-Type', () => 'application/json');

      final bearerToken = await _getBearerToken(apiPath);
      if (bearerToken != null) {
        headers.putIfAbsent('Authorization', () => 'Bearer $bearerToken');
      }

      Uri uri = Uri.https(_domainUrl, apiPath, query);
      if (_isLocal) uri = Uri.http(_domainUrl, apiPath, query);
      final response = await client
          .put(uri, body: jsonEncode(body), headers: headers)
          .timeout(_apiTimeout);
      DateTime endTime = DateTime.now();
      _handleResponseLog(response);
      await onSuccess?.call(
        url: apiPath,
        method: 'PUT',
        statusCode: response.statusCode,
        endTime: endTime,
        startTime: startTime,
      );
      return response;
    } catch (e) {
      await onError?.call(
        url: apiPath,
        method: 'PUT',
        error: e.toString(),
        query: query,
        body: body,
      );
      _handleAPIError(e);
      rethrow;
    }
  }

  @override
  Future<Response> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    DateTime startTime = DateTime.now();
    final apiPath = path;
    try {
      logger.d('API-DELETE $apiPath');

      headers ??= {'Content-Type': 'application/json'};
      headers.putIfAbsent('Content-Type', () => 'application/json');

      final bearerToken = await _getBearerToken(apiPath);
      if (bearerToken != null) {
        headers.putIfAbsent('Authorization', () => 'Bearer $bearerToken');
      }
      Uri uri = Uri.https(_domainUrl, apiPath);
      if (_isLocal) uri = Uri.http(_domainUrl, apiPath);
      final response = await client
          .delete(uri, body: jsonEncode(body), headers: headers)
          .timeout(_apiTimeout);
      DateTime endTime = DateTime.now();
      _handleResponseLog(response);
      await onSuccess?.call(
        url: apiPath,
        method: 'DELETE',
        statusCode: response.statusCode,
        endTime: endTime,
        startTime: startTime,
      );
      return response;
    } catch (e) {
      await onError?.call(
        url: apiPath,
        method: 'DELETE',
        error: e.toString(),
        body: body,
      );
      _handleAPIError(e);
      rethrow;
    }
  }

  void _handleResponseLog(Response response) {
    if (response.statusCode != 200) {
      logger.e(response.body);
    } else {
      logger.i(response.body);
    }
  }

  void _handleAPIError(Object e) {
    if (e is TimeoutException) {
      throw const ServerException('Server did not respond');
    }
    logger.e(e);
  }

  Future<String?> _getBearerToken(String path) async {
    final ignorePaths = ['/auth'];
    final ignoreCheck =
        ignorePaths.map((e) {
          if (path == '/auth/fcm') return false;
          if (path == '/auth/me') return false;
          return path.startsWith(e);
        }).toList();
    if (ignoreCheck.contains(true)) return null;
    final token = Config.token;
    if (token == null) throw const CacheException('Account is not set');
    return token;
  }
}
