import 'package:decor_ride/common/data/models/items_model.dart';

class GetCategoriesRepo {
  Future<List<ProductCategoryModel>> getAllCategories() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return categories;
  }

  List<ProductCategoryModel> categories = [
    ProductCategoryModel(
        categoryName: "Furniture",
        categoryImage:
            "assets/furniture_assets/transitional-armchairs-and-accent-chairs.jpg"),
    ProductCategoryModel(
        categoryName: "Lighting",
        categoryImage: "assets/furniture_assets/midcentury-dining-chairs.jpg"),
    ProductCategoryModel(
        categoryName: "Home Decor",
        categoryImage:
            "assets/furniture_assets/french-country-side-tables-and-end-tables.jpg"),
    ProductCategoryModel(
        categoryName: "Kitchen & Dining",
        categoryImage: "assets/furniture_assets/counter_bar_stool.jpg"),
    ProductCategoryModel(
        categoryName: "Bath",
        categoryImage:
            "assets/furniture_assets/transitional-armchairs-and-accent-chairs.jpg"),
    ProductCategoryModel(
        categoryName: "Bedroom",
        categoryImage: "assets/furniture_assets/contemporary-area-rugs.jpg"),
  ];
}
