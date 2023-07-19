import 'package:decor_ride/data/models/items_model.dart';

class GetCategoryProductsRepo {
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    await Future.delayed(const Duration(seconds: 2));
    return products
        .where((element) => element.productCategoryTag == categoryId)
        .toList();
  }
}

List<ProductModel> products = [
  ProductModel(
    productName: "The Sawyer Dining Chair, Black, Wood and Rope",
    productImage: "assets/furniture_assets/contemporary-area-rugs.jpg",
    rating: 5.0,
    productOwner: "MOD",
    price: 185,
    discountPrice: 251,
    numberOfReviews: 330,
    productTag: "furniture",
    bestSeller: true,
    productCategoryTag: "furniture",
  ),
  ProductModel(
    productName: "Tapestry Counter Stool",
    productImage: "assets/furniture_assets/counter_bar_stool.jpg",
    rating: 4.5,
    productOwner: "Essentials for Living",
    price: 799,
    discountPrice: 1598,
    numberOfReviews: 174,
    productTag: "furniture",
    bestSeller: true,
    productCategoryTag: "furniture",
  ),
  ProductModel(
    productName: "GDF Studio Central Vintage Brown Faux",
    productImage:
        "assets/furniture_assets/french-country-side-tables-and-end-tables.jpg",
    rating: 4.3,
    productOwner: "GDFStudio",
    price: 117,
    discountPrice: 150,
    numberOfReviews: 185,
    productTag: "lighting",
    bestSeller: true,
    productCategoryTag: "lighting",
  ),
  ProductModel(
    productName: "Poly and Bark Paxton 24\" Counter Stool, Set of 2, T",
    productImage: "assets/furniture_assets/midcentury-dining-chairs.jpg",
    rating: 4.6,
    productOwner: "Poly & Bark",
    price: 211,
    discountPrice: 282,
    numberOfReviews: 24,
    productTag: "home_decor",
    productCategoryTag: "home_decor",
  ),
  ProductModel(
    productName: "Mason Swivel Counter Stool, Set of 2, White, Grey",
    productImage:
        "assets/furniture_assets/transitional-armchairs-and-accent-chairs.jpg",
    rating: 4.4,
    productOwner: "LumiSource",
    price: 374,
    discountPrice: 760,
    numberOfReviews: 113,
    productTag: "home_decor",
    productCategoryTag: "home_decor",
  ),
  ProductModel(
    productName: "Tapestry Counter Stool",
    productImage: "assets/furniture_assets/counter_bar_stool.jpg",
    rating: 4.5,
    productOwner: "Essentials for Living",
    price: 799,
    discountPrice: 1598,
    numberOfReviews: 174,
    productTag: "furniture",
    productCategoryTag: "furniture",
  ),
];
