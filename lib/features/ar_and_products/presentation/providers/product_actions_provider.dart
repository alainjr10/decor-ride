import 'package:dartz/dartz.dart';
import 'package:decor_ride/features/ar_and_products/data/repositories/product_actions_repo.dart';
import 'package:decor_ride/features/ar_and_products/data/repositories/product_actions_repo_impl.dart';
import 'package:decor_ride/features/ar_and_products/domain/entities/cart_item_entity.dart';
import 'package:decor_ride/features/ar_and_products/presentation/providers/product_actions_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productActionsNotifierProvider =
    StateNotifierProvider<ProductActionsNotifier, ProductActionsState>((ref) {
  final productActionsRepo = ref.watch(productActionsRepoProvider);
  return ProductActionsNotifier(productActionsRepo: productActionsRepo);
});

final getCartCountProvider = FutureProvider<int>((ref) async {
  final productActionsRepo = ref.watch(productActionsRepoProvider);
  var cartCount = await productActionsRepo.getCartCount();
  return cartCount.fold(
    (success) => success,
    (failure) => 0,
  );
});

final getCartItemsProvider =
    FutureProvider<Either<List<CartItemEntity>, String>>((ref) async {
  final productActionsRepo = ref.watch(productActionsRepoProvider);
  final result = await productActionsRepo.getCartItems();
  return result;
});

class ProductActionsNotifier extends StateNotifier<ProductActionsState> {
  ProductActionsNotifier({required this.productActionsRepo})
      : super(const ProductActionsState.initial());

  final ProductActionsRepo productActionsRepo;

  Future addProductToCart({required String productId}) async {
    state = const ProductActionsState.addingToCart();
    final response = await productActionsRepo.addProductToCart(productId);
    state = response.fold(
      (success) {
        return success == 'Product already exists in cart'
            ? const ProductActionsState.productAlreadyInCart()
            : const ProductActionsState.addedToCart();
      },
      (failure) => const ProductActionsState.addToCartFailed(),
    );
  }

  Future removeProductFromCart({required String productId}) async {
    state = const ProductActionsState.removingFromCart();
    final response = await productActionsRepo.removeProductFromCart(productId);
    state = response.fold(
      (success) => const ProductActionsState.removedFromCart(),
      (failure) => const ProductActionsState.removeFromCartFailed(),
    );
  }

  Future updateProductQuantity(
      {required String productId, required int quantity}) async {
    state = const ProductActionsState.updatingQuantity();
    final response =
        await productActionsRepo.updateProductQuantity(productId, quantity);
    state = response.fold(
      (success) => const ProductActionsState.updatedQuantity(),
      (failure) => const ProductActionsState.updateQuantityFailed(),
    );
  }
}
