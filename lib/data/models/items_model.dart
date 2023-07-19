import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
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
}
