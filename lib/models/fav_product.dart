import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocerry_shopping_app/models/product.dart';

part 'fav_product.freezed.dart';
part 'fav_product.g.dart';

@freezed
abstract class FavProduct with _$FavProduct {
  factory FavProduct({
    required Product product,
  }) = _FavProduct;
  factory FavProduct.fromJson(Map<String, dynamic> json) =>
      _$FavProductFromJson(json);
}
