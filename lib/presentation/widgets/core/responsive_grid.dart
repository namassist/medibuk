import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double maxWidth;
  final List<int>? spans;
  final List<bool>? breakBefore;
  final double spacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    required this.maxWidth,
    this.spans,
    this.breakBefore,
    this.spacing = 8,
  });

  static const double mobileBreakpoint = 600;
  static const double desktopBreakpoint = 900;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    int maxGridColumns;
    if (maxWidth < mobileBreakpoint) {
      maxGridColumns = 1;
    } else if (maxWidth < desktopBreakpoint) {
      maxGridColumns = 4;
    } else {
      maxGridColumns = 8;
    }

    return _buildLayout(maxGridColumns);
  }

  Widget _buildLayout(int maxGridColumns) {
    final widgets = <Widget>[];
    final unitWidth =
        (maxWidth - spacing * (maxGridColumns - 1)) / maxGridColumns;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];

      if (maxGridColumns == 8 &&
          (breakBefore != null) &&
          i < (breakBefore!.length)) {
        if (breakBefore![i]) {
          widgets.add(SizedBox(width: maxWidth));
        }
      }

      int configSpan = (spans != null && i < spans!.length) ? spans![i] : 2;

      int effectiveSpan;
      switch (maxGridColumns) {
        case 1: // Mobile
          effectiveSpan = 1;
          break;
        case 4: // Tablet
          effectiveSpan = configSpan.clamp(1, 4);
          break;
        case 8: // Desktop
        default:
          effectiveSpan = configSpan.clamp(1, 8);
          break;
      }

      final itemWidth =
          unitWidth * effectiveSpan + spacing * (effectiveSpan - 1);

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
