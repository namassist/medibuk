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
      throw Exception(e.response?.data['detail'] ?? 'An error occurred');
    }
  }

  Future<Response> post(
    String path, {
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? 'An error occurred');
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
      throw Exception(e.response?.data['detail'] ?? 'An error occurred');
    }
  }

  Future<List<dynamic>> getNode(
    String path,
    Map<String, dynamic> params,
  ) async {
    return [];
  }
}
