import 'package:decor_ride/data/repositories/get_categories_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = FutureProvider.autoDispose((ref) async {
  final response = await GetCategoriesRepo().getAllCategories();
  return response;
});

// final productCategoriesProvider = FutureProvider.autoDispose
//     .family<List<ProductCategoryModel>, String>((ref, categoryTag) async {
//   final repoData = ref.read(productsCategoryRepoProvider);
//   return repoData.getAllCategories();
// });

// final productsCategoryRepoProvider = Provider<GetCategoriesRepo>((ref) {
//   return GetCategoriesRepo();
// });
