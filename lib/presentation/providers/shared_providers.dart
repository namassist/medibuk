import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:medibuk/data/repositories/shared_data_repository.dart';
import 'package:medibuk/domain/entities/general_info.dart';

part 'shared_providers.g.dart';

class GeneralInfoParameter {
  final String modelName;
  final Map<String, dynamic> dependencies;

  GeneralInfoParameter({required this.modelName, this.dependencies = const {}});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralInfoParameter &&
          runtimeType == other.runtimeType &&
          modelName == other.modelName &&
          mapEquals(dependencies, other.dependencies);

  @override
  int get hashCode => modelName.hashCode ^ dependencies.hashCode;

  @override
  String toString() {
    return 'GeneralInfoParameter(modelName: $modelName, dependencies: $dependencies)';
  }
}

@Riverpod(keepAlive: true)
Future<List<GeneralInfo>> cachedGeneralInfoOptions(
  Ref ref,
  GeneralInfoParameter parameter,
) async {
  if (parameter.modelName == 'Doctor_ID' &&
      parameter.dependencies['M_Specialist_ID'] == null) {
    return [];
  }

  final repository = ref.watch(sharedDataRepositoryProvider);
  return repository.getGeneralInfoOptions(parameter);
}

@riverpod
Stream<List<ConnectivityResult>> connectivity(ConnectivityRef ref) async* {
  final initialStatus = await Connectivity().checkConnectivity();
  yield initialStatus;

  await for (final result in Connectivity().onConnectivityChanged) {
    yield result;
  }
}

// *** TAMBAHKAN PROVIDER BARU DI SINI ***
@riverpod
class AppTheme extends _$AppTheme {
  @override
  ThemeMode build() {
    return ThemeMode.light;
  }

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
