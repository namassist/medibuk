// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_selection_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rolesHash() => r'7f710f00a7a483bec35eb6880125a13d74193626';

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

/// See also [roles].
@ProviderFor(roles)
const rolesProvider = RolesFamily();

/// See also [roles].
class RolesFamily extends Family<AsyncValue<List<RoleSelectionItem>>> {
  /// See also [roles].
  const RolesFamily();

  /// See also [roles].
  RolesProvider call(int clientId) {
    return RolesProvider(clientId);
  }

  @override
  RolesProvider getProviderOverride(covariant RolesProvider provider) {
    return call(provider.clientId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'rolesProvider';
}

/// See also [roles].
class RolesProvider extends AutoDisposeFutureProvider<List<RoleSelectionItem>> {
  /// See also [roles].
  RolesProvider(int clientId)
    : this._internal(
        (ref) => roles(ref as RolesRef, clientId),
        from: rolesProvider,
        name: r'rolesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$rolesHash,
        dependencies: RolesFamily._dependencies,
        allTransitiveDependencies: RolesFamily._allTransitiveDependencies,
        clientId: clientId,
      );

  RolesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.clientId,
  }) : super.internal();

  final int clientId;

  @override
  Override overrideWith(
    FutureOr<List<RoleSelectionItem>> Function(RolesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RolesProvider._internal(
        (ref) => create(ref as RolesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        clientId: clientId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RoleSelectionItem>> createElement() {
    return _RolesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RolesProvider && other.clientId == clientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, clientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RolesRef on AutoDisposeFutureProviderRef<List<RoleSelectionItem>> {
  /// The parameter `clientId` of this provider.
  int get clientId;
}

class _RolesProviderElement
    extends AutoDisposeFutureProviderElement<List<RoleSelectionItem>>
    with RolesRef {
  _RolesProviderElement(super.provider);

  @override
  int get clientId => (origin as RolesProvider).clientId;
}

String _$organizationsHash() => r'9a9c01eeaf103d573a689780527da182239e6347';

/// See also [organizations].
@ProviderFor(organizations)
const organizationsProvider = OrganizationsFamily();

/// See also [organizations].
class OrganizationsFamily extends Family<AsyncValue<List<RoleSelectionItem>>> {
  /// See also [organizations].
  const OrganizationsFamily();

  /// See also [organizations].
  OrganizationsProvider call(int roleId) {
    return OrganizationsProvider(roleId);
  }

  @override
  OrganizationsProvider getProviderOverride(
    covariant OrganizationsProvider provider,
  ) {
    return call(provider.roleId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'organizationsProvider';
}

/// See also [organizations].
class OrganizationsProvider
    extends AutoDisposeFutureProvider<List<RoleSelectionItem>> {
  /// See also [organizations].
  OrganizationsProvider(int roleId)
    : this._internal(
        (ref) => organizations(ref as OrganizationsRef, roleId),
        from: organizationsProvider,
        name: r'organizationsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$organizationsHash,
        dependencies: OrganizationsFamily._dependencies,
        allTransitiveDependencies:
            OrganizationsFamily._allTransitiveDependencies,
        roleId: roleId,
      );

  OrganizationsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roleId,
  }) : super.internal();

  final int roleId;

  @override
  Override overrideWith(
    FutureOr<List<RoleSelectionItem>> Function(OrganizationsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrganizationsProvider._internal(
        (ref) => create(ref as OrganizationsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roleId: roleId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RoleSelectionItem>> createElement() {
    return _OrganizationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrganizationsProvider && other.roleId == roleId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roleId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrganizationsRef
    on AutoDisposeFutureProviderRef<List<RoleSelectionItem>> {
  /// The parameter `roleId` of this provider.
  int get roleId;
}

class _OrganizationsProviderElement
    extends AutoDisposeFutureProviderElement<List<RoleSelectionItem>>
    with OrganizationsRef {
  _OrganizationsProviderElement(super.provider);

  @override
  int get roleId => (origin as OrganizationsProvider).roleId;
}

String _$warehousesHash() => r'53d610c3ec43c43c0007494ad42e40ca00902b2b';

/// See also [warehouses].
@ProviderFor(warehouses)
const warehousesProvider = WarehousesFamily();

/// See also [warehouses].
class WarehousesFamily extends Family<AsyncValue<List<RoleSelectionItem>>> {
  /// See also [warehouses].
  const WarehousesFamily();

  /// See also [warehouses].
  WarehousesProvider call(int orgId) {
    return WarehousesProvider(orgId);
  }

  @override
  WarehousesProvider getProviderOverride(
    covariant WarehousesProvider provider,
  ) {
    return call(provider.orgId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'warehousesProvider';
}

/// See also [warehouses].
class WarehousesProvider
    extends AutoDisposeFutureProvider<List<RoleSelectionItem>> {
  /// See also [warehouses].
  WarehousesProvider(int orgId)
    : this._internal(
        (ref) => warehouses(ref as WarehousesRef, orgId),
        from: warehousesProvider,
        name: r'warehousesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$warehousesHash,
        dependencies: WarehousesFamily._dependencies,
        allTransitiveDependencies: WarehousesFamily._allTransitiveDependencies,
        orgId: orgId,
      );

  WarehousesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orgId,
  }) : super.internal();

  final int orgId;

  @override
  Override overrideWith(
    FutureOr<List<RoleSelectionItem>> Function(WarehousesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WarehousesProvider._internal(
        (ref) => create(ref as WarehousesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orgId: orgId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<RoleSelectionItem>> createElement() {
    return _WarehousesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WarehousesProvider && other.orgId == orgId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orgId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WarehousesRef on AutoDisposeFutureProviderRef<List<RoleSelectionItem>> {
  /// The parameter `orgId` of this provider.
  int get orgId;
}

class _WarehousesProviderElement
    extends AutoDisposeFutureProviderElement<List<RoleSelectionItem>>
    with WarehousesRef {
  _WarehousesProviderElement(super.provider);

  @override
  int get orgId => (origin as WarehousesProvider).orgId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
