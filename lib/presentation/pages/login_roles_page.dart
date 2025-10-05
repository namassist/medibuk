import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/auth_repository.dart';
import 'package:medibuk/domain/entities/auth_models.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:medibuk/presentation/providers/auth_provider.dart';
import 'package:medibuk/presentation/widgets/shared/custom_dialogs.dart';

class LoginRolesScreen extends ConsumerWidget {
  const LoginRolesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginData = ref.watch(
      authProvider.select((s) => s.roleSelectionData),
    );

    if (loginData == null) {
      return const Scaffold(
        body: Center(child: Text("Sesi tidak valid, silahkan login kembali.")),
      );
    }

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
                      child: _RoleSelectionForm(loginData: loginData),
                    ),
                  ],
                )
              : Center(child: _RoleSelectionForm(loginData: loginData));
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

  RoleSelectionItem? _selectedClient;
  RoleSelectionItem? _selectedRole;
  RoleSelectionItem? _selectedOrg;
  RoleSelectionItem? _selectedWarehouse;

  List<RoleSelectionItem> _roles = [];
  List<RoleSelectionItem> _orgs = [];
  List<RoleSelectionItem> _warehouses = [];

  bool _isChainLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.loginData.clients.isNotEmpty) {
      _selectedClient = widget.loginData.clients.first;
      _fetchInitialChain();
    }
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;
    showStatusDialog(
      context: context,
      type: DialogType.error,
      title: 'Gagal Memuat Data',
      message: message,
      buttonText: 'Oke',
    );
  }

  Future<void> _fetchInitialChain() async {
    if (_selectedClient == null) return;

    setState(() => _isChainLoading = true);

    try {
      final authRepo = ref.read(authRepositoryProvider);
      final token = ref.read(authProvider).initialToken!;

      final roles = await authRepo.getRoles(_selectedClient!.id, token);
      final firstRole = roles.isNotEmpty ? roles.first : null;

      List<RoleSelectionItem> orgs = [];
      RoleSelectionItem? firstOrg;
      if (firstRole != null) {
        orgs = await authRepo.getOrganizations(
          _selectedClient!.id,
          firstRole.id,
          token,
        );
        firstOrg = orgs.isNotEmpty ? orgs.last : null;
      }

      List<RoleSelectionItem> warehouses = [];
      RoleSelectionItem? firstWarehouse;
      if (firstOrg != null) {
        warehouses = await authRepo.getWarehouses(
          _selectedClient!.id,
          firstRole!.id,
          firstOrg.id,
          token,
        );
        firstWarehouse = warehouses.isNotEmpty ? warehouses.first : null;
      }

      setState(() {
        _roles = roles;
        _selectedRole = firstRole;
        _orgs = orgs;
        _selectedOrg = firstOrg;
        _warehouses = warehouses;
        _selectedWarehouse = firstWarehouse;
        _isChainLoading = false;
      });
    } catch (e) {
      setState(() => _isChainLoading = false);
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _onClientChanged(RoleSelectionItem? client) async {
    if (client == null) return;
    setState(() {
      _selectedClient = client;
      _roles = [];
      _orgs = [];
      _warehouses = [];
      _selectedRole = null;
      _selectedOrg = null;
      _selectedWarehouse = null;
    });
    await _fetchInitialChain();
  }

  Future<void> _onRoleChanged(RoleSelectionItem? role) async {
    if (role == null) return;
    setState(() {
      _selectedRole = role;
      _orgs = [];
      _warehouses = [];
      _selectedOrg = null;
      _selectedWarehouse = null;
      _isChainLoading = true;
    });

    try {
      final authRepo = ref.read(authRepositoryProvider);
      final token = ref.read(authProvider).initialToken!;
      final orgs = await authRepo.getOrganizations(
        _selectedClient!.id,
        role.id,
        token,
      );
      final firstOrg = orgs.isNotEmpty ? orgs.last : null;

      List<RoleSelectionItem> warehouses = [];
      RoleSelectionItem? firstWarehouse;
      if (firstOrg != null) {
        warehouses = await authRepo.getWarehouses(
          _selectedClient!.id,
          role.id,
          firstOrg.id,
          token,
        );
        firstWarehouse = warehouses.isNotEmpty ? warehouses.first : null;
      }

      setState(() {
        _orgs = orgs;
        _selectedOrg = firstOrg;
        _warehouses = warehouses;
        _selectedWarehouse = firstWarehouse;
        _isChainLoading = false;
      });
    } catch (e) {
      setState(() => _isChainLoading = false);
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _onOrgChanged(RoleSelectionItem? org) async {
    if (org == null) return;
    setState(() {
      _selectedOrg = org;
      _warehouses = [];
      _selectedWarehouse = null;
      _isChainLoading = true;
    });

    try {
      final authRepo = ref.read(authRepositoryProvider);
      final token = ref.read(authProvider).initialToken!;
      final warehouses = await authRepo.getWarehouses(
        _selectedClient!.id,
        _selectedRole!.id,
        org.id,
        token,
      );
      final firstWarehouse = warehouses.isNotEmpty ? warehouses.first : null;
      setState(() {
        _warehouses = warehouses;
        _selectedWarehouse = firstWarehouse;
        _isChainLoading = false;
      });
    } catch (e) {
      setState(() => _isChainLoading = false);
      _showErrorDialog(e.toString());
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
    final isLoading = _isChainLoading || authState.status == AuthStatus.loading;

    ref.listen(authProvider, (previous, next) {
      if (previous?.status == AuthStatus.loading && next.errorMessage != null) {
        _showErrorDialog(next.errorMessage!);
      }
    });

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
              onChanged: _onClientChanged,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: "Role",
              selectedItem: _selectedRole,
              items: _roles,
              onChanged: _onRoleChanged,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: "Organization",
              selectedItem: _selectedOrg,
              items: _orgs,
              onChanged: _onOrgChanged,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: "Warehouse",
              selectedItem: _selectedWarehouse,
              items: _warehouses,
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
  }) {
    final showLoading =
        _isChainLoading && items.isEmpty && selectedItem == null;

    return DropdownSearch<RoleSelectionItem>(
      items: items,
      selectedItem: selectedItem,
      onChanged: onChanged,
      itemAsString: (item) => item.name,
      validator: (item) => item == null ? "$label is required" : null,
      enabled: !_isChainLoading,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: showLoading
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
