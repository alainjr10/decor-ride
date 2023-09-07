import 'package:decor_ride/data/models/items_model.dart';

class CartItemEntity {
  final ProductModel product;
  final int quantity;

  CartItemEntity({
    required this.product,
    required this.quantity,
  });

  CartItemEntity copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return CartItemEntity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() => 'CartItemEntity(product: $product, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItemEntity &&
        other.product == product &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;

  factory CartItemEntity.fromProductModel(ProductModel product) {
    return CartItemEntity(
      product: product,
      quantity: 1,
    );
  }

  CartItemEntity.fromJson(Map<String, dynamic> json)
      : product = ProductModel.fromJson(json['product']),
        quantity = json['quantity'];

  ProductModel get getProduct => product;
}
