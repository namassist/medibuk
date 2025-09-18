import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double maxWidth;
  final int maxWideCount;

  const ResponsiveGrid({
    super.key,
    required this.children,
    required this.maxWidth,
    this.maxWideCount = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = maxWidth < 600;
    final effectiveMaxWideCount = isMobile ? 1 : maxWideCount;

    return Wrap(children: _buildResponsiveChildren(effectiveMaxWideCount));
  }

  List<Widget> _buildResponsiveChildren(int effectiveMaxWideCount) {
    final responsiveChildren = <Widget>[];

    for (final child in children) {
      if (child is ResponsiveGridItem) {
        final effectiveWideCount = effectiveMaxWideCount == 1
            ? 1
            : child.wideCount;
        final width = (maxWidth / effectiveMaxWideCount) * effectiveWideCount;

        responsiveChildren.add(SizedBox(width: width, child: child.child));

        if (child.newLine && effectiveMaxWideCount > 1) {
          responsiveChildren.add(const SizedBox(width: double.infinity));
        }
      } else {
        responsiveChildren.add(child);
      }
    }

    return responsiveChildren;
  }
}

class ResponsiveGridItem extends StatelessWidget {
  final Widget child;
  final int wideCount;
  final bool newLine;

  const ResponsiveGridItem({
    super.key,
    required this.child,
    required this.wideCount,
    this.newLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
