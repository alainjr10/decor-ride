import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/data/models/items_model.dart';
import 'package:decor_ride/features/ar_and_products/domain/entities/cart_item_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final productActionsDataSourceProvider =
    Provider<ProductActionsDataSource>((ref) {
  return ProductActionsDataSource();
});

class ProductActionsDataSource {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<Either<String, String>> addProductToCart(String productId) async {
    final user = _auth.currentUser;
    final userId = user!.uid;
    final cartRef = _firestore
        .collection('user_carts')
        .doc(userId)
        .collection('cart_items');
    try {
      final cartItem = await cartRef.doc(productId).get();
      if (cartItem.exists) {
        return left('Product already exists in cart');
      } else {
        await cartRef.doc(productId).set({
          'productId': productId,
          'quantity': 1,
        });
        return left('Product added to cart');
      }
    } on FirebaseException catch (e, stackTrace) {
      "Error adding to cart: ${e.message}, stacktrace ${stackTrace.toString()}"
          .log();
      return right(e.message.toString());
    }
  }

  Future<Either<String, String>> removeProductFromCart(String productId) async {
    final user = _auth.currentUser;
    final userId = user!.uid;
    final cartRef = _firestore
        .collection('user_carts')
        .doc(userId)
        .collection('cart_items');
    try {
      final cartItem = await cartRef.doc(productId).get();
      if (cartItem.exists) {
        await cartRef.doc(productId).delete();
        return left('Product removed from cart');
      } else {
        return right('Product does not exist in cart');
      }
    } on FirebaseException catch (e, stackTrace) {
      "Error removing from cart: ${e.message}, stacktrace ${stackTrace.toString()}"
          .log();
      return right(e.message.toString());
    }
  }

  Future<Either<String, String>> updateProductQuantity(
      String productId, int quantity) async {
    final user = _auth.currentUser;
    final userId = user!.uid;
    final cartRef = _firestore
        .collection('user_carts')
        .doc(userId)
        .collection('cart_items');
    try {
      final cartItem = await cartRef.doc(productId).get();
      if (cartItem.exists) {
        await cartRef.doc(productId).update({
          'quantity': quantity,
        });
        return left('Product quantity updated');
      } else {
        return right('Product does not exist in cart');
      }
    } on FirebaseException catch (e, stackTrace) {
      "Error updating product quantity: ${e.message}, stacktrace ${stackTrace.toString()}"
          .log();
      return right(e.message.toString());
    }
  }

  Future<Either<int, String>> getCartCount() async {
    final user = _auth.currentUser;
    final userId = user!.uid;
    final cartRef = _firestore
        .collection('user_carts')
        .doc(userId)
        .collection('cart_items');
    try {
      ' trying to get cart count\n '.log();
      final cartItems = await cartRef.get();
      'cart count: ${cartItems.docs.length} \n'.log();
      return left(cartItems.docs.length);
    } on FirebaseException catch (e, stackTrace) {
      "Error getting cart count: ${e.message}, stacktrace ${stackTrace.toString()}"
          .log();
      return right(e.message.toString());
    }
  }

  Future<Either<List<CartItemEntity>, String>> getCartItems() async {
    final user = _auth.currentUser;
    final userId = user!.uid;
    final cartRef = _firestore
        .collection('user_carts')
        .doc(userId)
        .collection('cart_items');
    try {
      'getting cart items...'.log();
      final cartProducts = <CartItemEntity>[];
      final cartItems = await cartRef.get();
      final cartItemsList = cartItems.docs;
      for (var item in cartItemsList) {
        'product id is ${item.data()['productId']} '.log();
        final productSnapshot = await _firestore
            .collection('products')
            .doc(item.data()['productId'].toString().trim())
            .get();
        'product exists: ${productSnapshot.exists} \n'.log();
        final cartItemEntity = CartItemEntity(
          product: ProductModel.fromJson(productSnapshot.data()!),
          quantity: int.parse(item.data()['quantity'].toString().trim()),
        );
        cartProducts.add(cartItemEntity);
      }
      // cartItems.docs.map((e) => ProductModel.fromJson(e.data())).toList();
      'successfully got cart items'.log();
      return left(cartProducts);
    } on FirebaseException catch (e, stackTrace) {
      "Error getting cart items: ${e.message}, stacktrace ${stackTrace.toString()}"
          .log();
      return right(e.message.toString());
    }
  }
}
