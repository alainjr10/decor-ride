import 'package:decor_ride/app/theme_extension.dart';
import 'package:decor_ride/domain/providers/product_categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCategoriesScreen extends ConsumerWidget {
  const ProductCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productCategoriesProvider = ref.watch(apiProvider);
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
          return ref.refresh(apiProvider.future);
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].categoryName),
                );
              },
            );
            // ListView.builder(
            //   itemCount: data.length,
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(data[index].categoryName),
            //     );
            //   },
            // );
          },
        ),
      ),
      //  Container(),
    );
  }
}
