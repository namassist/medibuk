// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cachedGeneralInfoOptionsHash() =>
    r'ea553346e2d648bb39e0aa8334f4c72b8fd7190d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [cachedGeneralInfoOptions].
@ProviderFor(cachedGeneralInfoOptions)
const cachedGeneralInfoOptionsProvider = CachedGeneralInfoOptionsFamily();

/// See also [cachedGeneralInfoOptions].
class CachedGeneralInfoOptionsFamily
    extends Family<AsyncValue<List<GeneralInfo>>> {
  /// See also [cachedGeneralInfoOptions].
  const CachedGeneralInfoOptionsFamily();

  /// See also [cachedGeneralInfoOptions].
  CachedGeneralInfoOptionsProvider call(GeneralInfoParameter parameter) {
    return CachedGeneralInfoOptionsProvider(parameter);
  }

  @override
  CachedGeneralInfoOptionsProvider getProviderOverride(
    covariant CachedGeneralInfoOptionsProvider provider,
  ) {
    return call(provider.parameter);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cachedGeneralInfoOptionsProvider';
}

/// See also [cachedGeneralInfoOptions].
class CachedGeneralInfoOptionsProvider
    extends FutureProvider<List<GeneralInfo>> {
  /// See also [cachedGeneralInfoOptions].
  CachedGeneralInfoOptionsProvider(GeneralInfoParameter parameter)
    : this._internal(
        (ref) => cachedGeneralInfoOptions(
          ref as CachedGeneralInfoOptionsRef,
          parameter,
        ),
        from: cachedGeneralInfoOptionsProvider,
        name: r'cachedGeneralInfoOptionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$cachedGeneralInfoOptionsHash,
        dependencies: CachedGeneralInfoOptionsFamily._dependencies,
        allTransitiveDependencies:
            CachedGeneralInfoOptionsFamily._allTransitiveDependencies,
        parameter: parameter,
      );

  CachedGeneralInfoOptionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parameter,
  }) : super.internal();

  final GeneralInfoParameter parameter;

  @override
  Override overrideWith(
    FutureOr<List<GeneralInfo>> Function(CachedGeneralInfoOptionsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CachedGeneralInfoOptionsProvider._internal(
        (ref) => create(ref as CachedGeneralInfoOptionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parameter: parameter,
      ),
    );
  }

  @override
  FutureProviderElement<List<GeneralInfo>> createElement() {
    return _CachedGeneralInfoOptionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CachedGeneralInfoOptionsProvider &&
        other.parameter == parameter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parameter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CachedGeneralInfoOptionsRef on FutureProviderRef<List<GeneralInfo>> {
  /// The parameter `parameter` of this provider.
  GeneralInfoParameter get parameter;
}

class _CachedGeneralInfoOptionsProviderElement
    extends FutureProviderElement<List<GeneralInfo>>
    with CachedGeneralInfoOptionsRef {
  _CachedGeneralInfoOptionsProviderElement(super.provider);

  @override
  GeneralInfoParameter get parameter =>
      (origin as CachedGeneralInfoOptionsProvider).parameter;
}

String _$connectivityHash() => r'df2abc0d3c073e5d8b4aacf3097aade88d45f784';

/// See also [connectivity].
@ProviderFor(connectivity)
final connectivityProvider =
    AutoDisposeStreamProvider<List<ConnectivityResult>>.internal(
      connectivity,
      name: r'connectivityProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$connectivityHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConnectivityRef =
    AutoDisposeStreamProviderRef<List<ConnectivityResult>>;
String _$appThemeHash() => r'ef9d6d1aff63e4f28687350b789c8d7a2c4c19a0';

/// See also [AppTheme].
@ProviderFor(AppTheme)
final appThemeProvider =
    AutoDisposeNotifierProvider<AppTheme, ThemeMode>.internal(
      AppTheme.new,
      name: r'appThemeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appThemeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppTheme = AutoDisposeNotifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
