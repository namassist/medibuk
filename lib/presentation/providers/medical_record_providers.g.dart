// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$medicalRecordRepositoryHash() =>
    r'e6977a65f3d2fdc151f80cd4374c3b3afeb5d13b';

/// See also [medicalRecordRepository].
@ProviderFor(medicalRecordRepository)
final medicalRecordRepositoryProvider =
    AutoDisposeProvider<MedicalRecordRepository>.internal(
      medicalRecordRepository,
      name: r'medicalRecordRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$medicalRecordRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MedicalRecordRepositoryRef =
    AutoDisposeProviderRef<MedicalRecordRepository>;
String _$medicalRecordNotifierHash() =>
    r'3ee49459d5410659b8df84c8faa247f4a8c39964';

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

abstract class _$MedicalRecordNotifier
    extends BuildlessAutoDisposeAsyncNotifier<MedicalRecord?> {
  late final String medicalRecordId;

  FutureOr<MedicalRecord?> build(String medicalRecordId);
}

/// See also [MedicalRecordNotifier].
@ProviderFor(MedicalRecordNotifier)
const medicalRecordNotifierProvider = MedicalRecordNotifierFamily();

/// See also [MedicalRecordNotifier].
class MedicalRecordNotifierFamily extends Family<AsyncValue<MedicalRecord?>> {
  /// See also [MedicalRecordNotifier].
  const MedicalRecordNotifierFamily();

  /// See also [MedicalRecordNotifier].
  MedicalRecordNotifierProvider call(String medicalRecordId) {
    return MedicalRecordNotifierProvider(medicalRecordId);
  }

  @override
  MedicalRecordNotifierProvider getProviderOverride(
    covariant MedicalRecordNotifierProvider provider,
  ) {
    return call(provider.medicalRecordId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'medicalRecordNotifierProvider';
}

/// See also [MedicalRecordNotifier].
class MedicalRecordNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          MedicalRecordNotifier,
          MedicalRecord?
        > {
  /// See also [MedicalRecordNotifier].
  MedicalRecordNotifierProvider(String medicalRecordId)
    : this._internal(
        () => MedicalRecordNotifier()..medicalRecordId = medicalRecordId,
        from: medicalRecordNotifierProvider,
        name: r'medicalRecordNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$medicalRecordNotifierHash,
        dependencies: MedicalRecordNotifierFamily._dependencies,
        allTransitiveDependencies:
            MedicalRecordNotifierFamily._allTransitiveDependencies,
        medicalRecordId: medicalRecordId,
      );

  MedicalRecordNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.medicalRecordId,
  }) : super.internal();

  final String medicalRecordId;

  @override
  FutureOr<MedicalRecord?> runNotifierBuild(
    covariant MedicalRecordNotifier notifier,
  ) {
    return notifier.build(medicalRecordId);
  }

  @override
  Override overrideWith(MedicalRecordNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MedicalRecordNotifierProvider._internal(
        () => create()..medicalRecordId = medicalRecordId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        medicalRecordId: medicalRecordId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MedicalRecordNotifier, MedicalRecord?>
  createElement() {
    return _MedicalRecordNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MedicalRecordNotifierProvider &&
        other.medicalRecordId == medicalRecordId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, medicalRecordId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MedicalRecordNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<MedicalRecord?> {
  /// The parameter `medicalRecordId` of this provider.
  String get medicalRecordId;
}

class _MedicalRecordNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          MedicalRecordNotifier,
          MedicalRecord?
        >
    with MedicalRecordNotifierRef {
  _MedicalRecordNotifierProviderElement(super.provider);

  @override
  String get medicalRecordId =>
      (origin as MedicalRecordNotifierProvider).medicalRecordId;
}

String _$generalInfoOptionsNotifierHash() =>
    r'18033d0dc5c3af2a76f65c47ffd2ee0d86893178';

abstract class _$GeneralInfoOptionsNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<GeneralInfo>> {
  late final String modelName;

  FutureOr<List<GeneralInfo>> build(String modelName);
}

/// See also [GeneralInfoOptionsNotifier].
@ProviderFor(GeneralInfoOptionsNotifier)
const generalInfoOptionsNotifierProvider = GeneralInfoOptionsNotifierFamily();

/// See also [GeneralInfoOptionsNotifier].
class GeneralInfoOptionsNotifierFamily
    extends Family<AsyncValue<List<GeneralInfo>>> {
  /// See also [GeneralInfoOptionsNotifier].
  const GeneralInfoOptionsNotifierFamily();

  /// See also [GeneralInfoOptionsNotifier].
  GeneralInfoOptionsNotifierProvider call(String modelName) {
    return GeneralInfoOptionsNotifierProvider(modelName);
  }

  @override
  GeneralInfoOptionsNotifierProvider getProviderOverride(
    covariant GeneralInfoOptionsNotifierProvider provider,
  ) {
    return call(provider.modelName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'generalInfoOptionsNotifierProvider';
}

/// See also [GeneralInfoOptionsNotifier].
class GeneralInfoOptionsNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          GeneralInfoOptionsNotifier,
          List<GeneralInfo>
        > {
  /// See also [GeneralInfoOptionsNotifier].
  GeneralInfoOptionsNotifierProvider(String modelName)
    : this._internal(
        () => GeneralInfoOptionsNotifier()..modelName = modelName,
        from: generalInfoOptionsNotifierProvider,
        name: r'generalInfoOptionsNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$generalInfoOptionsNotifierHash,
        dependencies: GeneralInfoOptionsNotifierFamily._dependencies,
        allTransitiveDependencies:
            GeneralInfoOptionsNotifierFamily._allTransitiveDependencies,
        modelName: modelName,
      );

  GeneralInfoOptionsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.modelName,
  }) : super.internal();

  final String modelName;

  @override
  FutureOr<List<GeneralInfo>> runNotifierBuild(
    covariant GeneralInfoOptionsNotifier notifier,
  ) {
    return notifier.build(modelName);
  }

  @override
  Override overrideWith(GeneralInfoOptionsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: GeneralInfoOptionsNotifierProvider._internal(
        () => create()..modelName = modelName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        modelName: modelName,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    GeneralInfoOptionsNotifier,
    List<GeneralInfo>
  >
  createElement() {
    return _GeneralInfoOptionsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GeneralInfoOptionsNotifierProvider &&
        other.modelName == modelName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, modelName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GeneralInfoOptionsNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<List<GeneralInfo>> {
  /// The parameter `modelName` of this provider.
  String get modelName;
}

class _GeneralInfoOptionsNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          GeneralInfoOptionsNotifier,
          List<GeneralInfo>
        >
    with GeneralInfoOptionsNotifierRef {
  _GeneralInfoOptionsNotifierProviderElement(super.provider);

  @override
  String get modelName =>
      (origin as GeneralInfoOptionsNotifierProvider).modelName;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
