// lib/domain/entities/product_info.dart
class ProductInfo {
  final int productId;
  final String name;
  final double qtyAvailable;

  ProductInfo({
    required this.productId,
    required this.name,
    required this.qtyAvailable,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      productId: json['M_Product_ID'] as int,
      name: json['Name'] as String,
      qtyAvailable: (json['QtyAvailable'] as num).toDouble(),
    );
  }
}

class SelectedItem {
  final ProductInfo product;
  int quantity;
  String description;

  SelectedItem({
    required this.product,
    this.quantity = 1,
    this.description = '',
  });

  SelectedItem copyWith({int? quantity, String? description}) {
    return SelectedItem(
      product: product,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
    );
  }
}
