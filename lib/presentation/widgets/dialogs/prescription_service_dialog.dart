import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:medibuk/domain/entities/general_info.dart';
import 'package:medibuk/domain/entities/prescription_record.dart';
import 'package:medibuk/domain/entities/product_info.dart';
import 'package:medibuk/presentation/providers/add_item_provider.dart';

class PrescriptionServiceDialog extends ConsumerStatefulWidget {
  final List<PrescriptionRecord> initialItems;
  const PrescriptionServiceDialog({super.key, required this.initialItems});

  @override
  ConsumerState<PrescriptionServiceDialog> createState() =>
      _PrescriptionServiceDialogState();
}

class _PrescriptionServiceDialogState
    extends ConsumerState<PrescriptionServiceDialog> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _debouncer.debounce(
        duration: const Duration(milliseconds: 500),
        onDebounce: () {
          if (mounted) {
            setState(() {
              _searchQuery = _searchController.text;
            });
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSave() {
    final selectedItems = ref.read(selectedItemsProvider(widget.initialItems));
    final List<PrescriptionRecord> result = selectedItems.map((item) {
      // Mencari item original untuk mempertahankan ID dan UID jika sedang mengedit
      final originalItem = widget.initialItems.firstWhere(
        (p) => p.mProductId?.id == item.product.productId,
        orElse: () =>
            PrescriptionRecord(id: 0, uid: 'new-${item.product.productId}'),
      );

      return PrescriptionRecord(
        id: originalItem.id,
        uid: originalItem.uid,
        mProductId: GeneralInfo(
          propertyLabel: 'Product',
          id: item.product.productId,
          identifier: item.product.name,
          modelName: 'm_product',
        ),
        qty: item.quantity,
        description: item.description,
        qtyOnHand: item.product.qtyAvailable,
      );
    }).toList();

    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(productSearchProvider(_searchQuery));
    final selectedItems = ref.watch(selectedItemsProvider(widget.initialItems));
    final selectedItemsNotifier = ref.read(
      selectedItemsProvider(widget.initialItems).notifier,
    );

    bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Dialog(
      insetPadding: isDesktop
          ? const EdgeInsets.all(40)
          : const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFF4F7FA),
          child: Column(
            children: [
              _buildHeader(selectedItems.length),
              _buildSearchBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // FIX #2: Ubah rasio flex
                            Expanded(
                              flex: 3,
                              child: _buildSearchResults(
                                searchResults,
                                selectedItemsNotifier,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 2,
                              child: _buildSelectedItems(
                                selectedItems,
                                selectedItemsNotifier,
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          // FIX #1: Tambahkan SingleChildScrollView untuk mobile
                          child: Column(
                            children: [
                              _buildSearchResults(
                                searchResults,
                                selectedItemsNotifier,
                              ),
                              const SizedBox(height: 16),
                              _buildSelectedItems(
                                selectedItems,
                                selectedItemsNotifier,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int selectedCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.add_box_outlined, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Item", style: Theme.of(context).textTheme.titleLarge),
              const Text(
                "Select and set the quantity of items needed",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: selectedCount > 0 ? _onSave : null,
            icon: const Icon(Icons.save),
            label: Text("Save ($selectedCount)"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      color: Colors.white,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search Item by Name',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFFF4F7FA),
        ),
      ),
    );
  }

  Widget _buildSearchResults(
    AsyncValue<List<ProductInfo>> searchResults,
    SelectedItemsNotifier notifier,
  ) {
    final selectedIds = ref
        .watch(selectedItemsProvider(widget.initialItems))
        .map((e) => e.product.productId)
        .toSet();

    return _buildSectionContainer(
      title: 'Search Results (${searchResults.asData?.value.length ?? 0})',
      child: searchResults.when(
        data: (products) {
          if (products.isEmpty && _searchQuery.isNotEmpty) {
            return const Center(child: Text("No products found."));
          }
          // FIX #1: Bungkus dengan SingleChildScrollView
          return SingleChildScrollView(
            child: Column(
              children: products.map((product) {
                final isAdded = selectedIds.contains(product.productId);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: const Icon(
                      Icons.medication_outlined,
                      color: Colors.grey,
                    ),
                    title: Text(product.name),
                    subtitle: Text('Qty: ${product.qtyAvailable.toInt()}'),
                    trailing: ElevatedButton.icon(
                      onPressed: isAdded
                          ? null
                          : () => notifier.addItem(product),
                      icon: isAdded
                          ? const Icon(Icons.check, size: 16)
                          : const Icon(Icons.add, size: 16),
                      label: Text(isAdded ? 'Selected' : 'Add'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAdded
                            ? Colors.grey.shade200
                            : Colors.teal,
                        foregroundColor: isAdded
                            ? Colors.grey.shade600
                            : Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => const Center(child: Text("Error searching")),
      ),
    );
  }

  Widget _buildSelectedItems(
    List<SelectedItem> items,
    SelectedItemsNotifier notifier,
  ) {
    return _buildSectionContainer(
      title: 'Selected Items (${items.length})',
      child: items.isEmpty
          ? const Center(
              child: Text(
                "No items selected.",
                style: TextStyle(color: Colors.grey),
              ),
            )
          // FIX #1: Bungkus dengan SingleChildScrollView
          : SingleChildScrollView(
              child: Column(
                children: items.map((item) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.medication, color: Colors.teal),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () =>
                                    notifier.removeItem(item.product.productId),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text('Qty:'),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => notifier.updateQuantity(
                                        item.product.productId,
                                        item.quantity - 1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        item.quantity.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.green,
                                      ),
                                      onPressed: () => notifier.updateQuantity(
                                        item.product.productId,
                                        item.quantity + 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            initialValue: item.description,
                            decoration: InputDecoration(
                              labelText: 'Description (optional)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              isDense: true,
                            ),
                            onChanged: (value) => notifier.updateDescription(
                              item.product.productId,
                              value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Agar tidak memakan semua ruang
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const Divider(height: 1),
          // FIX #1: Bungkus child dengan Flexible agar bisa scroll
          Flexible(
            child: Padding(padding: const EdgeInsets.all(8.0), child: child),
          ),
        ],
      ),
    );
  }
}
