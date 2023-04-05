import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocerry_shopping_app/models/fav_product.dart';

part 'fav.freezed.dart';
part 'fav.g.dart';

@freezed
abstract class Fav with _$Fav {
  factory Fav({
    required String userId,
    required List<FavProduct> products,
    required String favId,
  }) = _Fav;

  factory Fav.fromJson(Map<String, dynamic> json) => _$FavFromJson(json);
}

extension FavExt on Fav {
  Iterable<String> get favItem {
    return products.map((e) => e.product.productId);
  }
  // double get grandTodal {
  //   return products
  //       .map((e) => e.product.productSalePrice )
  //       .fold(0, (p, c) => p + c);
  // }
}
