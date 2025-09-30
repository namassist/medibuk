import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final itemBackgroundColor = Colors.white.withValues(alpha: 0.1);
    final itemBorderColor = Colors.white.withValues(alpha: 0.2);

    final itemDecoration = BoxDecoration(
      color: itemBackgroundColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: itemBorderColor, width: 1),
    );

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(
                context,
              ).colorScheme.primaryContainer.withValues(alpha: 0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(2, 0),
            ),
          ],
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          children: <Widget>[
            _DrawerHeader(decoration: itemDecoration),
            const _SearchField(),
            _buildDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              onTap: () {},
              decoration: itemDecoration,
            ),
            _buildDrawerItem(
              icon: Icons.tv_outlined,
              text: 'MediTV',
              onTap: () {},
              decoration: itemDecoration,
            ),
            _buildExpansionTile(
              context: context,
              icon: Icons.people_outline,
              text: 'Business Partner',
              children: [
                _buildSubDrawerItem(
                  text: 'Patient List',
                  onTap: () {},
                  decoration: itemDecoration,
                ),
                _buildSubDrawerItem(
                  text: 'Doctor List',
                  onTap: () {},
                  decoration: itemDecoration,
                ),
                _buildSubDrawerItem(
                  text: 'Relation Partner',
                  onTap: () {},
                  decoration: itemDecoration,
                ),
                _buildSubDrawerItem(
                  text: 'Vendor List',
                  onTap: () {},
                  decoration: itemDecoration,
                ),
              ],
              decoration: itemDecoration,
            ),
            _buildExpansionTile(
              context: context,
              icon: Icons.storefront_outlined,
              text: 'Clinic',
              decoration: itemDecoration,
            ),
            _buildExpansionTile(
              context: context,
              icon: Icons.shopping_cart_outlined,

              text: 'Purchase',
              decoration: itemDecoration,
            ),
            _buildExpansionTile(
              context: context,
              icon: Icons.inventory_2_outlined,
              text: 'Product',
              decoration: itemDecoration,
            ),
            _buildDrawerItem(
              icon: Icons.bar_chart_outlined,
              text: 'Reports',
              onTap: () {},
              decoration: itemDecoration,
            ),
            _buildDrawerItem(
              icon: Icons.person_outline,
              text: 'User',
              onTap: () {},
              decoration: itemDecoration,
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
    required BoxDecoration decoration,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: decoration,
      child: ListTile(
        leading: Icon(icon, size: 18),
        title: Text(text, style: TextStyle(fontSize: 14)),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildSubDrawerItem({
    required String text,
    required VoidCallback onTap,
    required BoxDecoration decoration,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 8.0, bottom: 8.0),
      child: Container(
        decoration: decoration,
        child: ListTile(
          leading: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade600, width: .5),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 16.0, right: 16.0),
          title: Text(text, style: const TextStyle(fontSize: 14)),
          onTap: onTap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile({
    required BuildContext context,
    required IconData icon,
    required String text,
    required BoxDecoration decoration,
    List<Widget> children = const [],
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            leading: Icon(icon, size: 18),
            title: Text(text, style: TextStyle(fontSize: 14)),
            backgroundColor: Colors.white.withValues(alpha: 0.05),
            collapsedBackgroundColor: Colors.transparent,
            children: children,
          ),
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final BoxDecoration decoration;
  const _DrawerHeader({required this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: decoration,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.add_circle,
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
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
