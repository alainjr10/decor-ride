import 'package:decor_ride/common/data/models/items_model.dart';
import 'package:decor_ride/common/data/repositories/get_categories_repo.dart';
import 'package:decor_ride/common/data/repositories/get_products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getCatsProvider =
    Provider<GetCategoriesRepo>((ref) => GetCategoriesRepo());
final getProdsProvider =
    Provider<GetCategoryProductsRepo>((ref) => GetCategoryProductsRepo());

final allCategoriesProvider = FutureProvider.autoDispose((ref) async {
  // final response = await GetCategoriesRepo().getAllCategories();
  return ref.watch(getCatsProvider).getAllCategories();
});

// get products By category id
final productsByCategoryTagProvider = FutureProvider.autoDispose
    .family<List<ProductModel>, String>((ref, categoryId) async {
  return ref.watch(getProdsProvider).getProductsByCategory(categoryId);
});

// final productCategoriesProvider = FutureProvider.autoDispose
//     .family<List<ProductCategoryModel>, String>((ref, categoryTag) async {
//   // final repoData = ref.read(productsCategoryRepoProvider);
//   final response = await GetCategoriesRepo().getAllCategories();
//   return response;
// });

// final productsCategoryRepoProvider = Provider<GetCategoriesRepo>((ref) {
//   return GetCategoriesRepo();
// });

