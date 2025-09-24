import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/domain/entities/medical_record.dart';

class TabData {
  final String title;
  final IconData icon;
  final Widget content;

  TabData({required this.title, required this.icon, required this.content});
}

class AppTab extends ConsumerWidget {
  final String title;
  final String subtitle;
  final IconData headerIcon;
  final List<TabData> tabs;

  const AppTab({
    super.key,
    required this.title,
    required this.subtitle,
    required this.headerIcon,
    required this.tabs,
    required MedicalRecord record,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: tabs.length,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  headerIcon,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            TabBar(
              isScrollable: tabs.length > 3,
              tabs: tabs
                  .map((tab) => Tab(icon: Icon(tab.icon), text: tab.title))
                  .toList(),
            ),
            SizedBox(
              height: 400,
              child: TabBarView(
                children: tabs.map((tab) => tab.content).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
