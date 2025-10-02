import 'package:medibuk/data/api/api_client.dart';

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository(this._apiClient);

  Future<bool> validateWarehouseAccess(String node) async {
    try {
      final response = await _apiClient.postNode(
        '/profile/validate',
        queryParams: {'node': node},
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } on Exception catch (e) {
      final errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('401') || errorMessage.contains('403')) {
        return false;
      }
      rethrow;
    }
  }
}
