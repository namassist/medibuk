// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$processedMainDataHash() => r'79cf61403c6bed8f2352fe8e9aeb3619d179e56e';

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

/// See also [processedMainData].
@ProviderFor(processedMainData)
const processedMainDataProvider = ProcessedMainDataFamily();

/// See also [processedMainData].
class ProcessedMainDataFamily extends Family<Map<String, dynamic>> {
  /// See also [processedMainData].
  const ProcessedMainDataFamily();

  /// See also [processedMainData].
  ProcessedMainDataProvider call(MedicalRecord record) {
    return ProcessedMainDataProvider(record);
  }

  @override
  ProcessedMainDataProvider getProviderOverride(
    covariant ProcessedMainDataProvider provider,
  ) {
    return call(provider.record);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'processedMainDataProvider';
}

/// See also [processedMainData].
class ProcessedMainDataProvider
    extends AutoDisposeProvider<Map<String, dynamic>> {
  /// See also [processedMainData].
  ProcessedMainDataProvider(MedicalRecord record)
    : this._internal(
        (ref) => processedMainData(ref as ProcessedMainDataRef, record),
        from: processedMainDataProvider,
        name: r'processedMainDataProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$processedMainDataHash,
        dependencies: ProcessedMainDataFamily._dependencies,
        allTransitiveDependencies:
            ProcessedMainDataFamily._allTransitiveDependencies,
        record: record,
      );

  ProcessedMainDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.record,
  }) : super.internal();

  final MedicalRecord record;

  @override
  Override overrideWith(
    Map<String, dynamic> Function(ProcessedMainDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProcessedMainDataProvider._internal(
        (ref) => create(ref as ProcessedMainDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        record: record,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Map<String, dynamic>> createElement() {
    return _ProcessedMainDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProcessedMainDataProvider && other.record == record;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, record.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProcessedMainDataRef on AutoDisposeProviderRef<Map<String, dynamic>> {
  /// The parameter `record` of this provider.
  MedicalRecord get record;
}

class _ProcessedMainDataProviderElement
    extends AutoDisposeProviderElement<Map<String, dynamic>>
    with ProcessedMainDataRef {
  _ProcessedMainDataProviderElement(super.provider);

  @override
  MedicalRecord get record => (origin as ProcessedMainDataProvider).record;
}

String _$medicalRecordNotifierHash() =>
    r'940be8ea1afa743de186c643fd4f37558c3a1839';

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

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
