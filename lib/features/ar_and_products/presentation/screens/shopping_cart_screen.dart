import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/common/widgets/custom_elevated_button.dart';
import 'package:decor_ride/features/ar_and_products/presentation/providers/product_actions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShoppingCartScreen extends ConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<int> qtyList = List.generate(30, (index) => index + 1);
    'qty list is ${qtyList.toString()}'.log();
    ref.listen(
      productActionsNotifierProvider,
      (previous, next) {
        next.maybeWhen(
          orElse: () {},
          updatingQuantity: () {
            return showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('Updating Cart'),
                  content: Text('Please wait...'),
                );
              },
            );
          },
          updatedQuantity: () {
            context.pop(context);
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return ref.refresh(getCartItemsProvider.future);
              },
              child: ListView(
                children: [
                  ref.watch(getCartItemsProvider).maybeWhen(
                    orElse: () {
                      return const SizedBox.shrink();
                    },
                    loading: () {
                      return Center(
                        child: SpinKitThreeBounce(
                          color: context.colorScheme.onPrimary,
                          size: 20.0,
                        ),
                      );
                    },
                    data: (data) {
                      return data.fold(
                        (cartItemsl) {
                          double totalPrice = cartItemsl.fold(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  element.product.price * element.quantity);
                          double totalItems = cartItemsl.fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element.quantity);
                          return cartItemsl.isEmpty
                              ? const Center(
                                  child: Text(
                                      "You haven't added any products to your cart yet"),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total (${totalItems.toInt().toString()} items)',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(fontSize: 16.0),
                                          ),
                                          Text(
                                            'XAF ${totalPrice.toInt()}',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: context.colorScheme.onPrimary
                                          .withOpacity(0.3),
                                    ),
                                    ...cartItemsl.map(
                                      (cartItem) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                6.0, 12.0, 16.0, 20.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(
                                                        cartItem.product
                                                            .productImage,
                                                        height: 90.0,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      16.vGap,
                                                      Container(
                                                        height: 30.0,
                                                        width: 60.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: context
                                                                .colorScheme
                                                                .onPrimary
                                                                .withOpacity(
                                                                    0.6),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                        ),
                                                        child: DropdownButton(
                                                          value: int.parse(
                                                              cartItem.quantity
                                                                  .toString()),
                                                          iconSize: 20.0,
                                                          underline: Container(
                                                            height: 0.0,
                                                            color: context
                                                                .colorScheme
                                                                .onPrimary
                                                                .withOpacity(
                                                                    0.3),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          icon: const Icon(Icons
                                                              .keyboard_arrow_down_outlined),
                                                          isExpanded: true,
                                                          items: qtyList
                                                              .map((e) =>
                                                                  DropdownMenuItem(
                                                                    value: e,
                                                                    child: Text(
                                                                      e.toString(),
                                                                    ),
                                                                  ))
                                                              .toList(),
                                                          onChanged:
                                                              (value) async {
                                                            await ref
                                                                .read(productActionsNotifierProvider
                                                                    .notifier)
                                                                .updateProductQuantity(
                                                                    productId: cartItem
                                                                        .product
                                                                        .productId,
                                                                    quantity: value
                                                                        as int);
                                                            ref.invalidate(
                                                                getCartItemsProvider);
                                                            ref.read(
                                                                getCartItemsProvider);
                                                            // ref.refresh(
                                                            //     getCartItemsProvider
                                                            //         .future);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                8.hGap,
                                                Flexible(
                                                  flex: 5,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        cartItem.product
                                                            .productName,
                                                        style: context.textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      4.vGap,
                                                      Text(
                                                        'Sold by ${cartItem.product.productOwner}',
                                                        style: context.textTheme
                                                            .labelMedium,
                                                      ),
                                                      16.vGap,
                                                      Text(
                                                        'XAF ${cartItem.product.price}',
                                                        style: context.textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      4.vGap,
                                                      Text(
                                                        'Ready to ship to Douala, Yaounde and Buea in 1-2 days',
                                                        style: context.textTheme
                                                            .labelMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: context.colorScheme.onPrimary
                                                .withOpacity(0.3),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(
                                        16.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order Summary',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          16.vGap,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Subtotal:',
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(),
                                              ),
                                              Text(
                                                'XAF ${totalPrice.toInt()}',
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          8.vGap,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Delivery:',
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(),
                                              ),
                                              Text(
                                                'FREE',
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(),
                                              ),
                                            ],
                                          ),
                                          8.vGap,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Estimated Tax',
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(),
                                              ),
                                              Text(
                                                '_',
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: context.colorScheme.onPrimary
                                          .withOpacity(0.3),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  context.colorScheme.primary,
                                            ),
                                          ),
                                          Text(
                                            'XAF ${totalPrice.toInt()}',
                                            style: context.textTheme.bodyLarge!
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                              color:
                                                  context.colorScheme.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    8.vGap,
                                  ],
                                );
                        },
                        (error) => const Text('Error getting cart items'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 80.0,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
            ),
            child: CustomElevatedButton(
              height: 40.0,
              leadingIcon: null,
              text: 'PROCEED TO CHECKOUT',
              onPressed: () {
                context.push('/checkout_screen');
              },
            ),
          ),
        ],
      ),
    );
  }
}
