import 'package:flutter/material.dart';

class OptimizedResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double maxWidth;
  final int maxWideCount;

  const OptimizedResponsiveGrid({
    super.key,
    required this.children,
    required this.maxWidth,
    this.maxWideCount = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final isMobile = maxWidth < 600;
    final effectiveMaxWideCount = isMobile ? 1 : maxWideCount;

    return _buildFixedLayout(effectiveMaxWideCount);
  }

  // 🎯 FIX: Simplified and correct layout logic
  Widget _buildFixedLayout(int maxCount) {
    final widgets = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      final child = children[i];

      // Calculate width based on mobile vs desktop
      final itemWidth = maxCount == 1
          ? maxWidth
          : (maxWidth / maxCount) * 2; // Default 2 wideCount

      widgets.add(
        SizedBox(
          width: itemWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: child,
          ),
        ),
      );
    }

    // 🎯 FIX: Use simple Wrap instead of complex row logic
    return Wrap(children: widgets, runSpacing: 8, spacing: 8);
  }
}
