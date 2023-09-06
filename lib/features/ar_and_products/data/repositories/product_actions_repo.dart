import 'package:dartz/dartz.dart';

abstract class ProductActionsRepo {
  Future<Either<String, String>> addProductToCart(String productId);
  Future<Either<String, String>> removeProductFromCart(String productId);
  Future<Either<String, String>> updateProductQuantity(
      String productId, int quantity);
  Future<Either<int, String>> getCartCount();
}
