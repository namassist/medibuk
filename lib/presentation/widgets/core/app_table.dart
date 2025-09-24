import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:medibuk/domain/entities/medical_record.dart';
import '../../providers/table_data_provider.dart';

class TableColumn {
  final String label;
  final String key;
  final bool isNumeric;
  final ColumnSize size;

  const TableColumn({
    required this.label,
    required this.key,
    this.isNumeric = false,
    this.size = ColumnSize.M,
  });
}

class AppTable extends ConsumerWidget {
  final String title;
  final List<dynamic> initialData;
  final List<TableColumn> columns;
  final VoidCallback onAdd;
  final Function(dynamic) onEdit;

  const AppTable({
    super.key,
    required this.title,
    required this.initialData,
    required this.columns,
    required this.onAdd,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(tableDataProvider(initialData));
    final notifier = ref.read(tableDataProvider(initialData).notifier);
    final bool hasSelection = tableState.selectedUids.isNotEmpty;

    return Card(
      elevation: 0,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.grey.shade50,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hasSelection
                        ? '${tableState.selectedUids.length} item(s) selected'
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
                            'Are you sure you want to delete ${tableState.selectedUids.length} selected item(s)?',
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
                        notifier.deleteSelected();
                      }
                    },
                  )
                else
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
              showCheckboxColumn: true,
              dataRowColor: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(context).primaryColor.withValues(alpha: 0.08);
                }
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
                  ),
                ),
                const DataColumn2(label: Text(''), size: ColumnSize.S),
              ],
              rows: List<DataRow>.generate(tableState.data.length, (index) {
                final item = tableState.data[index];
                final itemMap = (item.toJson() as Map<String, dynamic>);
                final isSelected = tableState.selectedUids.contains(item.uid);

                return DataRow2(
                  selected: isSelected,
                  onSelectChanged: (bool? selected) {
                    notifier.selectRow(item.uid, selected ?? false);
                  },
                  cells: [
                    ...columns.map((col) {
                      dynamic cellValue = itemMap[col.key];
                      String displayText = '';
                      if (cellValue is GeneralInfo) {
                        displayText = cellValue.identifier.toString();
                      } else {
                        displayText = cellValue?.toString() ?? '';
                      }

                      return DataCell(Text(displayText));
                    }),
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
                            onPressed: () => onEdit(item),
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
