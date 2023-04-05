import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/api/api_service.dart';
import 'package:grocerry_shopping_app/application/state/fav_state.dart';

class FavNotifier extends StateNotifier<FavState> {
  final APIService _apiService;

  FavNotifier(this._apiService) : super(FavState()) {
    getFavItems();
    getFavItems();
  }

  Future<void> getFavItems() async {
    state = state.copyWith(isLoading: true);
    final favData = await _apiService.getFav();

    state = state.copyWith(favModel: favData);
    state = state.copyWith(isLoading: false);
  }

  Future<void> addFavItem(productId) async {
    await _apiService.addFavItem(productId);
    await getFavItems();
    await getFavItems();
  }

  Future<void> removeFavItem(productId) async {
    await _apiService.removeFavItem(productId);
    // await getCartItems();
    var isFavItemExist = state.favModel!.products
        .firstWhere((element) => element.product.productId == productId);

    var updatedItems = state.favModel!;
    updatedItems.products.toList().remove(isFavItemExist);
    state = state.copyWith(favModel: updatedItems);
    await getFavItems();
  }
}
