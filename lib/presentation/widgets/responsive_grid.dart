import 'package:flutter/material.dart';
import 'package:medibuk/presentation/widgets/dynamic_field_widget.dart';
import '../../domain/entities/format_definition.dart';

// 🎯 OPTIMIZATION 26: Optimized grid with better layout calculations
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

    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildOptimizedLayout(constraints, effectiveMaxWideCount);
      },
    );
  }

  Widget _buildOptimizedLayout(BoxConstraints constraints, int maxCount) {
    final rows = <Widget>[];
    final currentRow = <Widget>[];
    int currentRowWidth = 0;

    for (final child in children) {
      if (child is! OptimizedDynamicFieldWidget) {
        currentRow.add(child);
        continue;
      }

      final config =
          FieldConfiguration.configurations[child.fieldName] ??
          const FormatDefinition();

      final wideCount = maxCount == 1 ? 1 : config.wideCount;

      // Check if we need a new row
      if (config.newLine || currentRowWidth + wideCount > maxCount) {
        if (currentRow.isNotEmpty) {
          rows.add(_buildRow(currentRow, constraints.maxWidth, maxCount));
          currentRow.clear();
          currentRowWidth = 0;
        }
      }

      currentRow.add(
        SizedBox(
          width: (constraints.maxWidth / maxCount) * wideCount,
          child: child,
        ),
      );
      currentRowWidth += wideCount;
    }

    // Add remaining row
    if (currentRow.isNotEmpty) {
      rows.add(_buildRow(currentRow, constraints.maxWidth, maxCount));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }

  Widget _buildRow(List<Widget> rowChildren, double maxWidth, int maxCount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowChildren,
    );
  }
}
