import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;
  final Dio _nodeDio; // Tetap ada jika masih dibutuhkan untuk API lain

  // Token dari dokumentasi Anda
  static const String _authToken =
      'eyJraWQiOiJpZGVtcGllcmUiLCJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJTdXBlckFuYWFtIiwiTV9XYXJlaG91c2VfSUQiOjEwMDAwMTMsIkFEX0xhbmd1YWdlIjoiZW5fVVMiLCJBRF9TZXNzaW9uX0lEIjoyMjI4Mjc3LCJBRF9Vc2VyX0lEIjoxMDk5MDcxLCJBRF9Sb2xlX0lEIjoxMDAwMDE1LCJBRF9PcmdfSUQiOjEwMDAwMDEsImlzcyI6ImlkZW1waWVyZS5vcmciLCJBRF9DbGllbnRfSUQiOjEwMDAwMDAsImV4cCI6MTc1ODYyMDI4M30.JrX8egqArEdwpFXmINqNPKcYbPX31qNjhpK2NABnll0i1v71KNr5inow3UkwkmlVa9AV2KColGj6GXNvYx5wqg';

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://devkss.idempiereonline.com/api/v1',
          headers: {
            'Authorization': 'Bearer $_authToken',
            'Accept': 'application/json',
          },
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 20),
        ),
      ),
      // Inisialisasi _nodeDio tetap ada jika diperlukan untuk fitur lain
      _nodeDio = Dio(
        BaseOptions(
          baseUrl: 'https://medibook.medital.id/api',
          headers: {
            'Authorization': 'Bearer $_authToken', // Asumsi token yang sama
            'Accept': 'application/json',
          },
        ),
      );

  // Metode GET yang sekarang melakukan panggilan jaringan nyata
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      // Penanganan error yang lebih baik
      throw Exception(
        'Failed to load data from $path: ${e.response?.data ?? e.message}',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Metode PUT untuk memperbarui data
  Future<Response> put(
    String path, {
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(
        'Failed to update data at $path: ${e.response?.data ?? e.message}',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Metode untuk Node API tetap tidak berubah
  Future<List<dynamic>> getNode(
    String path,
    Map<String, dynamic> params,
  ) async {
    // ... implementasi getNode
    return [];
  }
}
