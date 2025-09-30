// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encounter_record_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$encounterNotifierHash() => r'221212597b7d7593e5b53bd064e11313340a8c1c';

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

abstract class _$EncounterNotifier
    extends BuildlessAutoDisposeAsyncNotifier<EncounterRecord?> {
  late final String encounterId;

  FutureOr<EncounterRecord?> build(String encounterId);
}

/// See also [EncounterNotifier].
@ProviderFor(EncounterNotifier)
const encounterNotifierProvider = EncounterNotifierFamily();

/// See also [EncounterNotifier].
class EncounterNotifierFamily extends Family<AsyncValue<EncounterRecord?>> {
  /// See also [EncounterNotifier].
  const EncounterNotifierFamily();

  /// See also [EncounterNotifier].
  EncounterNotifierProvider call(String encounterId) {
    return EncounterNotifierProvider(encounterId);
  }

  @override
  EncounterNotifierProvider getProviderOverride(
    covariant EncounterNotifierProvider provider,
  ) {
    return call(provider.encounterId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'encounterNotifierProvider';
}

/// See also [EncounterNotifier].
class EncounterNotifierProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          EncounterNotifier,
          EncounterRecord?
        > {
  /// See also [EncounterNotifier].
  EncounterNotifierProvider(String encounterId)
    : this._internal(
        () => EncounterNotifier()..encounterId = encounterId,
        from: encounterNotifierProvider,
        name: r'encounterNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$encounterNotifierHash,
        dependencies: EncounterNotifierFamily._dependencies,
        allTransitiveDependencies:
            EncounterNotifierFamily._allTransitiveDependencies,
        encounterId: encounterId,
      );

  EncounterNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.encounterId,
  }) : super.internal();

  final String encounterId;

  @override
  FutureOr<EncounterRecord?> runNotifierBuild(
    covariant EncounterNotifier notifier,
  ) {
    return notifier.build(encounterId);
  }

  @override
  Override overrideWith(EncounterNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: EncounterNotifierProvider._internal(
        () => create()..encounterId = encounterId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        encounterId: encounterId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EncounterNotifier, EncounterRecord?>
  createElement() {
    return _EncounterNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EncounterNotifierProvider &&
        other.encounterId == encounterId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, encounterId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EncounterNotifierRef
    on AutoDisposeAsyncNotifierProviderRef<EncounterRecord?> {
  /// The parameter `encounterId` of this provider.
  String get encounterId;
}

class _EncounterNotifierProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          EncounterNotifier,
          EncounterRecord?
        >
    with EncounterNotifierRef {
  _EncounterNotifierProviderElement(super.provider);

  @override
  String get encounterId => (origin as EncounterNotifierProvider).encounterId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
