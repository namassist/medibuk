import 'package:flutter/material.dart';
import 'dart:math' as math;

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double maxWidth;
  final int maxWideCount;
  // Optional per-child span (in grid units). Defaults to 2 when not provided.
  final List<int>? spans;
  // Optional explicit line breaks: when true for an index, start a new row before that item.
  final List<bool>? breakBefore;
  // Horizontal/vertical spacing between items
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

  // 🎯 FIX: Simplified and correct layout logic
  Widget _buildFixedLayout(int maxCount, bool isMobile) {
    final widgets = <Widget>[];
    // Compute per-unit width taking spacing into account so that
    // a row with sum(span) == maxCount fits exactly without wrapping.
    final unitWidth = (maxWidth - spacing * (maxCount - 1)) / maxCount;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];

      // Handle explicit line break before this item
      if ((breakBefore != null) && i < (breakBefore!.length)) {
        if (breakBefore![i]) {
          widgets.add(SizedBox(width: maxWidth));
        }
      }

      // Span per item; default 2 units on wide screens, full width on mobile
      int span = 2;
      if (isMobile) {
        span = maxCount; // full width on mobile
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

    // 🎯 FIX: Use simple Wrap instead of complex row logic
    return Wrap(runSpacing: spacing, spacing: spacing, children: widgets);
  }
}
