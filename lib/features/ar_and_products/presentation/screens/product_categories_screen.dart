import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:decor_ride/common/domain/providers/product_categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductCategoriesScreen extends ConsumerWidget {
  const ProductCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCategoriesProvider = ref.watch(allCategoriesProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: context.theme.colorScheme.onPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
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
      body: RefreshIndicator(
        onRefresh: () {
          // ref.invalidate(apiProvider);
          // ref.read(apiProvider);
          return ref.refresh(allCategoriesProvider.future);
        },
        child: productCategoriesProvider.when(
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
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 32.0,
                  mainAxisSpacing: 32.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.pushNamed('category_products_screen',
                          pathParameters: {
                            'categoryTag':
                                data[index].categoryName.toLowerCase().trim(),
                            // .replaceAll(" ", "_"),
                          });
                      // context.push('/category_products_screen', extra: );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          data[index].categoryImage,
                          fit: BoxFit.fill,
                          height: 170.0,
                          width: size.width,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          data[index].categoryName,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
