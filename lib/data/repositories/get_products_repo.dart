import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor_ride/data/models/items_model.dart';

class GetCategoryProductsRepo {
  final _firestore = FirebaseFirestore.instance;
  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    List<ProductModel> productsList = [];
    // await Future.delayed(const Duration(seconds: 2));
    await _firestore
        .collection("products")
        .where("category", isEqualTo: categoryId.toLowerCase())
        .get()
        .then((value) {
      for (var element in value.docs) {
        productsList.add(ProductModel.fromJson(element.data()));
        // element.data().forEach((key, value) {
        //   products.add(ProductModel.fromJson(value));
        // });
      }
    });
    return productsList;
    // .where((element) => element.productCategoryTag == categoryId)
    // .toList();
  }
}

List<ProductModel> products = [
  ProductModel(
    productName: "The Sawyer Dining Chair, Black, Wood and Rope",
    productImage: "assets/furniture_assets/contemporary-area-rugs.jpg",
    productModelUrl:
        "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/vintage_wooden_chair_lowpoly_mod2.glb?alt=media&token=6c397e54-192f-4da7-9603-d71c17a551ad",
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
    productModelUrl:
        "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/orson_3_seater_sofa_bed_graphite_grey_mod.glb?alt=media&token=14123645-bf35-4876-afcd-d641f908ec06",
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
    productModelUrl:
        "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/vintage_wooden_chair_lowpoly_mod2.glb?alt=media&token=6c397e54-192f-4da7-9603-d71c17a551ad",
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
    productModelUrl:
        "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/orson_3_seater_sofa_bed_graphite_grey_mod.glb?alt=media&token=14123645-bf35-4876-afcd-d641f908ec06",
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
    productModelUrl:
        "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/vintage_wooden_chair_lowpoly.glb?alt=media&token=e69acf11-cf08-47b6-8973-df49e0722a10",
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
    productModelUrl:
        "https://firebasestorage.googleapis.com/v0/b/decor-ride.appspot.com/o/vintage_wooden_chair_lowpoly.glb?alt=media&token=e69acf11-cf08-47b6-8973-df49e0722a10",
    rating: 4.5,
    productOwner: "Essentials for Living",
    price: 799,
    discountPrice: 1598,
    numberOfReviews: 174,
    productTag: "furniture",
    productCategoryTag: "furniture",
  ),
];
