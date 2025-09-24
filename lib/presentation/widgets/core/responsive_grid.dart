import 'package:flutter/material.dart';
import 'dart:math' as math;

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double maxWidth;
  final int maxWideCount;
  final List<int>? spans;
  final List<bool>? breakBefore;
  final double spacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    required this.maxWidth,
    this.maxWideCount = 8,
    this.spans,
    this.breakBefore,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final isMobile = maxWidth < 600;
    final effectiveMaxWideCount = isMobile ? 1 : maxWideCount;

    return _buildFixedLayout(effectiveMaxWideCount, isMobile);
  }

  Widget _buildFixedLayout(int maxCount, bool isMobile) {
    final widgets = <Widget>[];
    final unitWidth = (maxWidth - spacing * (maxCount - 1)) / maxCount;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];

      if ((breakBefore != null) && i < (breakBefore!.length)) {
        if (breakBefore![i]) {
          widgets.add(SizedBox(width: maxWidth));
        }
      }

      int span = 2;
      if (isMobile) {
        span = maxCount;
      } else if (spans != null && i < spans!.length) {
        span = spans![i];
      }
      span = span.clamp(1, maxCount);

      final clampedSpan = math.min(span, maxCount);
      final itemWidth = unitWidth * clampedSpan + spacing * (clampedSpan - 1);

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

    return Wrap(runSpacing: spacing, spacing: spacing, children: widgets);
  }
}
