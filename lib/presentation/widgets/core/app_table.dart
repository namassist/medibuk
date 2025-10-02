import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import '../../providers/table_data_provider.dart';

class TableColumn {
  final String label;
  final String? key;
  final bool isNumeric;
  final ColumnSize size;
  final Widget Function(dynamic data)? cellBuilder;

  const TableColumn({
    required this.label,
    this.key,
    this.isNumeric = false,
    this.size = ColumnSize.M,
    this.cellBuilder,
  }) : assert(
         key != null || cellBuilder != null,
         'Either key or cellBuilder must be provided.',
       );
}

class AppTable extends ConsumerWidget {
  final String title;
  final List<dynamic> initialData;
  final List<TableColumn> columns;
  final VoidCallback? onAdd;
  final Function(dynamic)? onEdit;
  final bool showAddButton;
  final bool showEditColumn;
  final bool enableMultiSelect;
  final Function(dynamic)? onRowTap;
  final bool showVerticalBorder;
  final int? sortColumnIndex;
  final bool sortAscending;
  final Function(int, bool)? onSort;

  const AppTable({
    super.key,
    required this.title,
    required this.initialData,
    required this.columns,
    this.onAdd,
    this.onEdit,
    this.showAddButton = true,
    this.showEditColumn = true,
    this.enableMultiSelect = true,
    this.onRowTap,
    this.showVerticalBorder = true,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSort,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = enableMultiSelect
        ? ref.watch(tableDataProvider(initialData))
        : null;
    final notifier = enableMultiSelect
        ? ref.read(tableDataProvider(initialData).notifier)
        : null;
    final hasSelection = tableState?.selectedUids.isNotEmpty ?? false;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    hasSelection
                        ? '${tableState!.selectedUids.length} item(s) selected'
                        : title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: hasSelection
                          ? Theme.of(context).primaryColor
                          : Colors.black87,
                    ),
                  ),
                ),
                if (hasSelection)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    tooltip: 'Delete Selected',
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Confirm Deletion'),
                          content: Text(
                            'Are you sure you want to delete ${tableState?.selectedUids.length} selected item(s)?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true) {
                        notifier?.deleteSelected();
                      }
                    },
                  )
                else if (showAddButton && onAdd != null)
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    tooltip: 'Add New',
                    onPressed: onAdd,
                  ),
              ],
            ),
          ),
          Expanded(
            child: DataTable2(
              columnSpacing: 16,
              horizontalMargin: 16,
              minWidth: 600,
              showCheckboxColumn: enableMultiSelect,
              sortColumnIndex: sortColumnIndex,
              sortAscending: sortAscending,
              dataRowColor: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                return null;
              }),
              columns: [
                ...columns.map(
                  (col) => DataColumn2(
                    label: Text(
                      col.label,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    numeric: col.isNumeric,
                    size: col.size,
                    onSort: col.key != null && onSort != null
                        ? (columnIndex, ascending) =>
                              onSort!(columnIndex, ascending)
                        : null,
                  ),
                ),
                if (showEditColumn)
                  const DataColumn2(label: Text(''), size: ColumnSize.S),
              ],
              border: showVerticalBorder
                  ? TableBorder.symmetric(
                      outside: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      inside: BorderSide(color: Colors.grey.shade200, width: 1),
                    )
                  : null,
              dividerThickness: 1,
              rows: List<DataRow>.generate(initialData.length, (index) {
                final item = initialData[index];
                final itemMap = (item.toJson() as Map<String, dynamic>);
                final isSelected =
                    tableState?.selectedUids.contains(item.uid) ?? false;

                return DataRow2(
                  selected: isSelected,
                  onSelectChanged: (bool? selected) {
                    if (enableMultiSelect && notifier != null) {
                      notifier.selectRow(item.uid, selected ?? false);
                    }
                  },
                  onTap: onRowTap != null ? () => onRowTap!(item) : null,
                  cells: [
                    ...columns.map((col) {
                      if (col.cellBuilder != null) {
                        return DataCell(col.cellBuilder!(item));
                      }

                      dynamic cellValue = itemMap[col.key!];
                      String displayText = '';
                      if (cellValue is GeneralInfo) {
                        displayText = cellValue.identifier.toString();
                      } else {
                        displayText = cellValue?.toString() ?? '-';
                      }

                      return DataCell(Text(displayText));
                    }),
                    if (showEditColumn && onEdit != null)
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit_outlined,
                                size: 20,
                                color: Colors.grey.shade700,
                              ),
                              onPressed: () => onEdit!(item),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
