// import 'package:freezed_annotation/freezed_annotation.dart';

// @freezed
class ProductCategoryModel {
  final String categoryName;
  final String categoryImage;
  String? categoryTag;

  ProductCategoryModel({
    required this.categoryName,
    required this.categoryImage,
    this.categoryTag,
  });
  // copywith
  ProductCategoryModel copyWith({
    String? categoryName,
    String? categoryImage,
    String? categoryTag,
  }) {
    return ProductCategoryModel(
      categoryName: categoryName ?? this.categoryName,
      categoryImage: categoryImage ?? this.categoryImage,
      categoryTag: categoryTag ?? this.categoryTag,
    );
  }
}

class ProductModel {
  final String productName;
  final String productImage;
  final String? productModelUrl;
  final double rating;
  final String productOwner;
  final double price;
  final double discountPrice;
  final int numberOfReviews;
  final String productTag;
  bool bestSeller;
  final String productCategoryTag;

  ProductModel({
    required this.productName,
    required this.productImage,
    required this.productModelUrl,
    required this.rating,
    required this.productOwner,
    required this.price,
    required this.discountPrice,
    required this.numberOfReviews,
    required this.productTag,
    this.bestSeller = true,
    required this.productCategoryTag,
  });

  // copywith
  ProductModel copyWith({
    String? productName,
    String? productImage,
    String? productModelUrl,
    double? rating,
    String? productOwner,
    double? price,
    double? discountPrice,
    int? numberOfReviews,
    String? productTag,
    String? productCategoryTag,
    bool? bestSeller,
  }) {
    return ProductModel(
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      productModelUrl: productModelUrl ?? this.productModelUrl,
      rating: rating ?? this.rating,
      productOwner: productOwner ?? this.productOwner,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      numberOfReviews: numberOfReviews ?? this.numberOfReviews,
      productTag: productTag ?? this.productTag,
      bestSeller: bestSeller ?? this.bestSeller,
      productCategoryTag: productCategoryTag ?? this.productCategoryTag,
    );
  }

  // from json method
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productName: json['product_name'],
      productImage: json['product_image_url'],
      productModelUrl: json['product_model_url'],
      rating: double.parse(json['rating'].toString()),
      productOwner: json['product_owner'],
      price: double.parse(json['price'].toString()),
      discountPrice:
          json.containsKey('discount_price') ? json['discountPrice'] : 0,
      numberOfReviews:
          json.containsKey('number_of_reviews') ? json['number_of_reviews'] : 0,
      productTag: json.containsKey('product_tag') ? json['product_tag'] : "",
      bestSeller: json.containsKey('best_seller') ? json['best_seller'] : false,
      productCategoryTag: json['category'],
    );
  }
}
