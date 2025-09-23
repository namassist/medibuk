import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medibuk/data/repositories/shared_data_repository.dart'; // Ganti import ini
import 'package:medibuk/domain/entities/product_info.dart';
import 'package:medibuk/domain/entities/prescription_record.dart';

// Provider untuk mengambil hasil pencarian produk dari API
final productSearchProvider = FutureProvider.autoDispose
    .family<List<ProductInfo>, String>((ref, query) async {
      if (query.isEmpty) {
        return [];
      }
      // Menunggu sebentar (debounce) sebelum benar-benar memanggil API
      await Future.delayed(const Duration(milliseconds: 500));

      // PERBAIKAN: Ganti medicalRecordRepositoryProvider dengan sharedDataRepositoryProvider
      final repository = ref.read(sharedDataRepositoryProvider);
      return repository.searchProducts(query);
    });

// Notifier untuk mengelola state item yang dipilih di dalam dialog
class SelectedItemsNotifier extends StateNotifier<List<SelectedItem>> {
  SelectedItemsNotifier(List<PrescriptionRecord> initialItems) : super([]) {
    // Inisialisasi state dari data preskripsi yang sudah ada
    _initState(initialItems);
  }

  // Helper untuk konversi data awal
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
