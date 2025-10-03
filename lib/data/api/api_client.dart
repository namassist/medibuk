import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medibuk/config/environment.dart';

class ApiClient {
  late final Dio _dio;
  late final Dio _nodeDio;
  final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  ApiClient() {
    final baseUrl = EnvManager.instance.config.baseUrl;
    final nodeUrl = EnvManager.instance.config.nodeUrl;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    _nodeDio = Dio(BaseOptions(baseUrl: nodeUrl));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!options.headers.containsKey('Authorization')) {
            final token = await _storage.read(key: _tokenKey);
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
    String? token,
  }) async {
    try {
      Options? options;
      if (token != null) {
        options = Options(headers: {'Authorization': 'Bearer $token'});
      }
      return await _dio.get(
        path,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response> post(
    String path, {
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response> put(
    String path, {
    required Map<String, dynamic> data,
    String? token,
  }) async {
    try {
      Options? options;
      if (token != null) {
        options = Options(headers: {'Authorization': 'Bearer $token'});
      }
      return await _dio.put(path, data: data, options: options);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response != null) {
      // Server responded with an error code (4xx, 5xx)
      final statusCode = e.response!.statusCode;
      final responseData = e.response!.data;
      String errorMessage = "An error occurred";

      if (responseData is Map && responseData.containsKey('error')) {
        errorMessage =
            responseData['error']['message'] ?? 'Unknown server error';
      } else {
        errorMessage = 'Server error: $statusCode';
      }
      return Exception(errorMessage);
    } else {
      // Error without a response (e.g., connection timeout, network error)
      return Exception('Connection error: ${e.message}');
    }
  }

  Future<List<dynamic>> getNode(
    String path,
    Map<String, dynamic> params,
  ) async {
    return [];
  }

  Future<Response> postNode(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final token = await _storage.read(key: _tokenKey);
      Options? options;
      if (token != null) {
        options = Options(headers: {'Authorization': 'Bearer $token'});
      }

      return await _nodeDio.post(
        path,
        queryParameters: queryParams,
        options: options,
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['detail'] ?? 'An error occurred on Node API',
      );
    }
  }
}
