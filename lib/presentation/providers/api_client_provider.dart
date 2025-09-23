import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/api/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
