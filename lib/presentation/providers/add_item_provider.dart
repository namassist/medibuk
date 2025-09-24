import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/shared_data_repository.dart';
import 'package:medibuk/domain/entities/product_info.dart';
import 'package:medibuk/domain/entities/prescription_record.dart';

final productSearchProvider = FutureProvider.autoDispose
    .family<List<ProductInfo>, String>((ref, query) async {
      if (query.isEmpty) {
        return [];
      }
      await Future.delayed(const Duration(milliseconds: 500));

      final repository = ref.read(sharedDataRepositoryProvider);
      return repository.searchProducts(query);
    });

class SelectedItemsNotifier extends StateNotifier<List<SelectedItem>> {
  SelectedItemsNotifier(List<PrescriptionRecord> initialItems) : super([]) {
    _initState(initialItems);
  }

  void _initState(List<PrescriptionRecord> initialItems) {
    state = initialItems
        .map((p) {
          if (p.mProductId == null) return null;
          return SelectedItem(
            product: ProductInfo(
              productId: p.mProductId!.id,
              name: p.mProductId!.identifier,
              qtyAvailable: (p.qtyOnHand ?? 0).toDouble(),
            ),
            quantity: p.qty?.toInt() ?? 1,
            description: p.description ?? '',
          );
        })
        .whereType<SelectedItem>()
        .toList();
  }

  void addItem(ProductInfo product) {
    final isExisting = state.any(
      (item) => item.product.productId == product.productId,
    );
    if (!isExisting) {
      state = [...state, SelectedItem(product: product)];
    }
  }

  void removeItem(int productId) {
    state = state.where((item) => item.product.productId != productId).toList();
  }

  void updateQuantity(int productId, int newQuantity) {
    state = [
      for (final item in state)
        if (item.product.productId == productId)
          item.copyWith(quantity: newQuantity > 0 ? newQuantity : 1)
        else
          item,
    ];
  }

  void updateDescription(int productId, String newDescription) {
    state = [
      for (final item in state)
        if (item.product.productId == productId)
          item.copyWith(description: newDescription)
        else
          item,
    ];
  }
}

final selectedItemsProvider = StateNotifierProvider.autoDispose
    .family<
      SelectedItemsNotifier,
      List<SelectedItem>,
      List<PrescriptionRecord>
    >((ref, initialItems) {
      return SelectedItemsNotifier(initialItems);
    });
