import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/ar_and_products/domain/entities/cart_item_entity.dart';

abstract class ProductActionsRepo {
  Future<Either<String, String>> addProductToCart(String productId);
  Future<Either<String, String>> removeProductFromCart(String productId);
  Future<Either<String, String>> updateProductQuantity(
      String productId, int quantity);
  Future<Either<int, String>> getCartCount();
  Future<Either<List<CartItemEntity>, String>> getCartItems();
}
