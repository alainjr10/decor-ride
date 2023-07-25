import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/domain/providers/product_categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

class CategoryProductsScreen extends ConsumerWidget {
  const CategoryProductsScreen({super.key, required this.categoryTag});
  final String categoryTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final productsListProvider =
        ref.watch(productsByCategoryTagProvider(categoryTag));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.theme.colorScheme.onPrimary,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: context.theme.colorScheme.onPrimary.withOpacity(0.5),
            ),
            hintText: 'Search Houzz',
            hintStyle: context.theme.textTheme.bodyMedium!.copyWith(
              color: context.theme.colorScheme.onPrimary.withOpacity(0.5),
            ),
            border: InputBorder.none,
            filled: true,
            fillColor:
                context.theme.appBarTheme.backgroundColor!.withOpacity(0.5),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: context.theme.colorScheme.onPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            snap: true,
            pinned: false,
            title: FloatingAppBar(),
          ),
          productsListProvider.when(
            loading: () {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            error: (error, stackTrace) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Text('Error: $error, stackTrace: $stackTrace'),
                ),
              );
            },
            data: (data) {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return data.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                context.pop();
                                context.pop(data[index].productModelUrl);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 160.0,
                                    color: Colors.white,
                                    child: Image.network(
                                      data[index].productImage,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/triangle.png',
                                          fit: BoxFit.fill,
                                          width: size.width,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    data[index].productName,
                                    textAlign: TextAlign.left,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  4.vGap,
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "by ",
                                          style: context
                                              .theme.textTheme.bodySmall!
                                              .copyWith(
                                            color: context
                                                .theme.colorScheme.onPrimary
                                                .withOpacity(0.75),
                                          ),
                                        ),
                                        TextSpan(
                                            text: data[index].productOwner),
                                      ],
                                    ),
                                  ),
                                  8.vGap,
                                  Row(
                                    children: [
                                      IgnorePointer(
                                        child: RatingBar.builder(
                                          initialRating: data[index].rating,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 16.0,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ),
                                      2.hGap,
                                      Text(
                                        "(${(math.Random().nextInt(150) + 1).toString()})",
                                        style: context
                                            .theme.textTheme.bodySmall!
                                            .copyWith(
                                          color: context
                                              .theme.colorScheme.onPrimary
                                              .withOpacity(0.75),
                                        ),
                                      ),
                                    ],
                                  ),
                                  8.vGap,
                                  RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "XAF ${data[index].price.round()} ",
                                          style: context
                                              .theme.textTheme.bodyLarge!
                                              .copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        TextSpan(
                                            text:
                                                "${(data[index].price * 0.45).round()}",
                                            style: context.textTheme.bodySmall!
                                                .copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: context
                                                  .colorScheme.onPrimary
                                                  .withOpacity(0.75),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Center(
                              child: Text("No items found for this category"),
                            );
                    },
                    childCount: data.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 32.0,
                    mainAxisSpacing: 32.0,
                    childAspectRatio: 1 / 1.7,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FloatingAppBar extends StatelessWidget {
  const FloatingAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 16,
        children: [
          ProductsListOptionsChip(
            label: "Filter",
            icon: Icons.filter_list,
            onTap: () {},
          ),
          ProductsListOptionsChip(
            label: "Style",
            onTap: () {},
          ),
          ProductsListOptionsChip(
            label: "Price",
            onTap: () {},
          ),
          ProductsListOptionsChip(
            label: "Shipping",
            onTap: () {},
          ),
          ProductsListOptionsChip(
            label: "Sale",
            onTap: () {},
          ),
          ProductsListOptionsChip(
            label: "Brand",
            onTap: () {},
          ),
          ProductsListOptionsChip(
            label: "Customer Rating",
            onTap: () {},
          ),
          ProductsListOptionsChip(
            label: "Colour",
            onTap: () {},
          ),
          ProductsListOptionsChip(
            label: "Sort",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ProductsListOptionsChip extends StatelessWidget {
  const ProductsListOptionsChip({
    super.key,
    required this.label,
    this.icon = Icons.keyboard_arrow_down,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.theme.primaryColor.withOpacity(0.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      label: Row(
        children: [
          Text(label),
          8.hGap,
          Icon(
            icon,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}
