import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final tabHeight = (screenHeight * 0.400).clamp(300.0, 600.0).toDouble();

    return DefaultTabController(
      length: tabs.length,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        headerIcon,
                        color: colorScheme.onSurface.withValues(alpha: 0.8),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.08),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: TabBar(
                      isScrollable: tabs.length > 3,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                      indicator: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: 0.25),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      labelColor: colorScheme.onPrimary,
                      unselectedLabelColor: colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                      labelStyle: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      unselectedLabelStyle: theme.textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 13),
                      tabs: tabs
                          .map(
                            (tab) => Tab(
                              height: 48,
                              icon: Icon(tab.icon, size: 18),
                              text: tab.title,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: tabHeight,
                child: TabBarView(
                  children: tabs.map((tab) => tab.content).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
