import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFE0F7FA), // Warna latar belakang sidebar
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const _DrawerHeader(),
            const _SearchField(),
            _buildDrawerItem(
              icon: Icons.dashboard_outlined,
              text: 'Dashboard',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.tv_outlined,
              text: 'MediTV',
              onTap: () {},
            ),
            _buildExpansionTile(
              icon: Icons.people_outline,
              text: 'Business Partner',
              children: [
                _buildSubDrawerItem(text: 'Sub Menu 1', onTap: () {}),
                _buildSubDrawerItem(text: 'Sub Menu 2', onTap: () {}),
              ],
            ),
            _buildExpansionTile(
              icon: Icons.storefront_outlined,
              text: 'Clinic',
            ),
            _buildExpansionTile(
              icon: Icons.shopping_cart_outlined,
              text: 'Purchase',
            ),
            _buildExpansionTile(
              icon: Icons.inventory_2_outlined,
              text: 'Product',
            ),
            _buildExpansionTile(
              icon: Icons.bar_chart_outlined,
              text: 'Reports',
            ),
            _buildDrawerItem(
              icon: Icons.person_outline,
              text: 'User',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(text),
      onTap: onTap,
    );
  }

  Widget _buildSubDrawerItem({
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: ListTile(title: Text(text), onTap: onTap),
    );
  }

  Widget _buildExpansionTile({
    required IconData icon,
    required String text,
    List<Widget> children = const [],
  }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(text),
      children: children,
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.add_circle, // Placeholder icon
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Medibook',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Menu...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
