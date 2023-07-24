import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/domain/providers/product_categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
            title: FloatingAppBar(),
          ),
          SliverToBoxAdapter(
            child: RefreshIndicator(
              onRefresh: () {
                return ref
                    .refresh(productsByCategoryTagProvider(categoryTag).future);
              },
              child: productsListProvider.when(
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text('Error: $error, stackTrace: $stackTrace'),
                  );
                },
                data: (data) {
                  debugPrint(
                      "The length of the returned list is ${data.length} and the name is $categoryTag");
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: data.isNotEmpty
                        ? GridView.builder(
                            primary: true,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 32.0,
                              mainAxisSpacing: 32.0,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context.pop();
                                  context.pop(data[index].productModelUrl);
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      data[index].productImage,
                                      fit: BoxFit.fill,
                                      height: 170.0,
                                      width: size.width,
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      data[index].productName,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text("No items found for this category"),
                          ),
                  );
                },
              ),
            ),
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
