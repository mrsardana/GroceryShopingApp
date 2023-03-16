import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocerry_shopping_app/config.dart';
import 'package:grocerry_shopping_app/models/category.dart';

part 'product.freezed.dart';
part 'product.g.dart';

List<Product> productsFromJson(dynamic str) => List<Product>.from(
      (str).map(
        (y) => Product.fromJson(y),
      ),
    );

@freezed
abstract class Product with _$Product {
  factory Product({
    required String productName,
    required Category category,
    required String productShortDescription,
    required String productDescription,
    required double productPrice,
    required double productSalePrice,
    required String productImage,
    required String productSKU,
    required String productType,
    required String stockStatus,
    required String productId,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

extension ProductExt on Product {
  String get fullImagePath => Config.imageURL + productImage;

  int get calculateDiscount {
    double disPercent = 0;

    if (!productPrice.isNaN) {
      double regularPrice = productPrice;
      double salePrice = productSalePrice > 0 ? productSalePrice : regularPrice;
      double discount = regularPrice - salePrice;
      disPercent = (discount / regularPrice) * 100;
    }

    return disPercent.round();
  }
}
