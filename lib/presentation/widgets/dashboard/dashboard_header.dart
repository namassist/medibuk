import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/presentation/providers/dashboard_provider.dart';
import 'package:medibuk/presentation/widgets/shared/bpartner_search_dialog.dart';

class SearchBarField extends ConsumerStatefulWidget {
  const SearchBarField({super.key});

  @override
  ConsumerState<SearchBarField> createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends ConsumerState<SearchBarField> {
  // 2. Buat TextEditingController sebagai state
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    ref.listenManual(dashboardProvider, (previous, next) {
      final wasFiltered = previous?.selectedBPartnerId != null;
      final isNowCleared = next.selectedBPartnerId == null;

      if (wasFiltered && isNowCleared) {
        _searchController.clear();
      }
    });
  }

  @override
  void dispose() {
    // 4. Jangan lupa dispose controller
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        color: theme.colorScheme.secondaryContainer,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      height: 44,
      child: TextField(
        controller: _searchController, // Gunakan controller dari state
        style: TextStyle(color: theme.colorScheme.onSecondaryContainer),
        decoration: InputDecoration(
          hintText: 'Search by Name or Phone Number',
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          prefixIcon: const Icon(Icons.search_outlined),
          border: InputBorder.none,
        ),
        onSubmitted: (query) {
          if (query.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) => BPartnerSearchDialog(initialQuery: query),
            );
            // 5. HAPUS baris searchController.clear() dari sini
          }
        },
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: theme.colorScheme.onSurface),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 32,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
