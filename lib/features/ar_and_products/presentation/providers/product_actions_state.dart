// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_actions_state.freezed.dart';

@freezed
class ProductActionsState with _$ProductActionsState {
  const factory ProductActionsState.initial() = _Initial;
  const factory ProductActionsState.addingToCart() = _AddingToCart;
  const factory ProductActionsState.addedToCart() = _AddedToCart;
  const factory ProductActionsState.productAlreadyInCart() =
      _ProductAlreadyInCart;
  const factory ProductActionsState.addToCartFailed() = _AddToCartFailed;
  const factory ProductActionsState.removingFromCart() = _RemovingFromCart;
  const factory ProductActionsState.removedFromCart() = _RemovedFromCart;
  const factory ProductActionsState.removeFromCartFailed() =
      _RemoveFromCartFailed;
  const factory ProductActionsState.updatingQuantity() = _UpdatingQuantity;
  const factory ProductActionsState.updatedQuantity() = _UpdatedQuantity;
  const factory ProductActionsState.updateQuantityFailed() =
      _UpdateQuantityFailed;
  const factory ProductActionsState.cartCount({required int count}) =
      _CartCount;
  const factory ProductActionsState.error({required String message}) = _Error;
}
