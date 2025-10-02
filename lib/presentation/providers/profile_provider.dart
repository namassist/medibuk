import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/config/environment.dart';
import 'package:medibuk/data/repositories/profile_repository.dart';
import 'package:medibuk/presentation/providers/api_client_provider.dart';

final profileRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProfileRepository(apiClient);
});

final warehouseAccessValidatorProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  final profileRepository = ref.watch(profileRepositoryProvider);
  final String node = EnvManager.instance.config.node;
  return await profileRepository.validateWarehouseAccess(node);
});
