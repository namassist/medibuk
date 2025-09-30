import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/auth_repository.dart';
import 'package:medibuk/domain/entities/auth_models.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';

class LoginRoleScreen extends ConsumerStatefulWidget {
  final InitialLoginData loginData;
  const LoginRoleScreen({super.key, required this.loginData});

  @override
  ConsumerState<LoginRoleScreen> createState() => LoginRoleScreenState();
}

class LoginRoleScreenState extends ConsumerState<LoginRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 700;
          return isDesktop
              ? Row(
                  children: [
                    const Expanded(flex: 1, child: _RoleSelectionImagePanel()),
                    Expanded(
                      flex: 2,
                      child: _RoleSelectionForm(loginData: widget.loginData),
                    ),
                  ],
                )
              : Center(
                  // Ditambahkan untuk menengahkan form di mode mobile/tablet
                  child: _RoleSelectionForm(loginData: widget.loginData),
                );
        },
      ),
    );
  }
}

class _RoleSelectionImagePanel extends StatelessWidget {
  const _RoleSelectionImagePanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        image: const DecorationImage(
          image: AssetImage("assets/ornament_roles.png"),
          fit: BoxFit.contain,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.center,
          child: Image.asset("assets/nav_icon_medibook.png"),
        ),
      ),
    );
  }
}

class _RoleSelectionForm extends ConsumerStatefulWidget {
  final InitialLoginData loginData;
  const _RoleSelectionForm({required this.loginData});

  @override
  ConsumerState<_RoleSelectionForm> createState() => _RoleSelectionFormState();
}

class _RoleSelectionFormState extends ConsumerState<_RoleSelectionForm> {
  final _formKey = GlobalKey<FormState>();

  // State untuk menyimpan item yang terpilih
  RoleSelectionItem? _selectedClient;
  RoleSelectionItem? _selectedRole;
  RoleSelectionItem? _selectedOrg;
  RoleSelectionItem? _selectedWarehouse;

  // State untuk menyimpan daftar item dropdown
  List<RoleSelectionItem> _roles = [];
  List<RoleSelectionItem> _orgs = [];
  List<RoleSelectionItem> _warehouses = [];

  // State untuk status loading
  bool _isRolesLoading = false;
  bool _isOrgsLoading = false;
  bool _isWarehousesLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.loginData.clients.isNotEmpty) {
      _selectedClient = widget.loginData.clients.first;
      _fetchRoles();
    }
  }

  Future<void> _fetchRoles() async {
    if (_selectedClient == null) return;
    setState(() => _isRolesLoading = true);

    final authRepo = ref.read(authRepositoryProvider);
    final token = ref.read(authProvider).initialToken!;

    try {
      final roles = await authRepo.getRoles(_selectedClient!.id, token);
      setState(() {
        _roles = roles;
        if (roles.isNotEmpty) {
          _selectedRole = roles.first;
        }
        _isRolesLoading = false;
      });
      if (_selectedRole != null) {
        _fetchOrganizations();
      }
    } catch (e) {
      setState(() => _isRolesLoading = false);
      // Handle error
    }
  }

  Future<void> _fetchOrganizations() async {
    if (_selectedRole == null) return;
    setState(() => _isOrgsLoading = true);

    final authRepo = ref.read(authRepositoryProvider);
    final token = ref.read(authProvider).initialToken!;

    try {
      final orgs = await authRepo.getOrganizations(
        _selectedClient!.id,
        _selectedRole!.id,
        token,
      );
      setState(() {
        _orgs = orgs;
        if (orgs.length > 1) {
          _selectedOrg = orgs[1];
        } else if (orgs.isNotEmpty) {
          _selectedOrg = orgs.first;
        }
        _isOrgsLoading = false;
      });

      if (_selectedOrg != null) {
        _fetchWarehouses();
      }
    } catch (e) {
      setState(() => _isOrgsLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch organizations: $e')),
      );
    }
  }

  Future<void> _fetchWarehouses() async {
    if (_selectedOrg == null) return;
    setState(() => _isWarehousesLoading = true);

    final authRepo = ref.read(authRepositoryProvider);
    final token = ref.read(authProvider).initialToken!;

    try {
      final warehouses = await authRepo.getWarehouses(
        _selectedClient!.id,
        _selectedRole!.id,
        _selectedOrg!.id,
        token,
      );
      setState(() {
        _warehouses = warehouses;
        if (warehouses.isNotEmpty) {
          _selectedWarehouse = warehouses.first;
        }
        _isWarehousesLoading = false;
      });
    } catch (e) {
      setState(() => _isWarehousesLoading = false);
      // Handle error
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(authProvider.notifier)
          .selectRoleAndLogin(
            client: _selectedClient!,
            role: _selectedRole!,
            organization: _selectedOrg!,
            warehouse: _selectedWarehouse!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;

    ref.listen<AuthState>(authProvider, (previous, next) {});

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            _buildDropdown(
              label: "Client",
              selectedItem: _selectedClient,
              items: widget.loginData.clients,
              onChanged: (value) {
                setState(() {
                  _selectedClient = value;
                  _selectedRole = null;
                  _selectedOrg = null;
                  _selectedWarehouse = null;
                  _roles = [];
                  _orgs = [];
                  _warehouses = [];
                });
                _fetchRoles();
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: "Role",
              selectedItem: _selectedRole,
              items: _roles,
              isLoading: _isRolesLoading,
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                  _selectedOrg = null;
                  _selectedWarehouse = null;
                  _orgs = [];
                  _warehouses = [];
                });
                _fetchOrganizations();
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: "Organization",
              selectedItem: _selectedOrg,
              items: _orgs,
              isLoading: _isOrgsLoading,
              onChanged: (value) {
                setState(() {
                  _selectedOrg = value;
                  _selectedWarehouse = null;
                  _warehouses = [];
                });
                _fetchWarehouses();
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: "Warehouse",
              selectedItem: _selectedWarehouse,
              items: _warehouses,
              isLoading: _isWarehousesLoading,
              onChanged: (value) {
                setState(() => _selectedWarehouse = value);
              },
            ),
            const SizedBox(height: 32),
            isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submit,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    RoleSelectionItem? selectedItem,
    List<RoleSelectionItem> items = const [],
    required ValueChanged<RoleSelectionItem?> onChanged,
    bool isLoading = false,
  }) {
    return DropdownSearch<RoleSelectionItem>(
      items: items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      itemAsString: (item) => item.name,
      validator: (item) => item == null ? "$label is required" : null,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : null,
        ),
      ),
      popupProps: const PopupProps.menu(showSearchBox: true),
    );
  }
}
