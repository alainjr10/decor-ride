import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/ar_and_products/data/data_sources/product_actions_data_source.dart';
import 'package:decor_ride/features/ar_and_products/data/repositories/product_actions_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productActionsRepoProvider = Provider<ProductActionsRepo>((ref) {
  final productActionsDataSource = ref.watch(productActionsDataSourceProvider);
  return ProductActionsRepoImpl(productActionsDataSource);
});

class ProductActionsRepoImpl implements ProductActionsRepo {
  final ProductActionsDataSource _productActionsDataSource;

  ProductActionsRepoImpl(this._productActionsDataSource);

  @override
  Future<Either<String, String>> addProductToCart(String productId) {
    return _productActionsDataSource.addProductToCart(productId);
  }

  @override
  Future<Either<String, String>> removeProductFromCart(String productId) {
    return _productActionsDataSource.removeProductFromCart(productId);
  }

  @override
  Future<Either<String, String>> updateProductQuantity(
      String productId, int quantity) {
    return _productActionsDataSource.updateProductQuantity(productId, quantity);
  }

  @override
  Future<Either<int, String>> getCartCount() {
    return _productActionsDataSource.getCartCount();
  }
}
