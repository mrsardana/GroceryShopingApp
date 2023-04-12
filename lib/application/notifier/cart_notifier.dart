import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/application/state/cart_state.dart';
import 'package:grocerry_shopping_app/models/cart.dart';
import 'package:grocerry_shopping_app/models/cart_product.dart';
import '../../api/api_service.dart';

class CartNotifier extends StateNotifier<CartState> {
  final APIService _apiService;

  CartNotifier(this._apiService) : super(CartState()) {
    getCartItems();
    getCartItems();
  }

  Future<void> getCartItems() async {
    state = state.copyWith(isLoading: true);

    final cartData = await _apiService.getCart();

    state = state.copyWith(cartModel: cartData);
    state = state.copyWith(isLoading: false);
  }

  Future<void> addCartItem(productId, qty) async {
    await _apiService.addCartItem(productId, qty);
    await getCartItems();
    await getCartItems();
  }

  Future<void> removeCartItem(productId, qty) async {
    await _apiService.removeCartItem(productId, qty);

    // var isCartItemExist = state.cartModel!.products
    //     .firstWhere((element) => element.product.productId == productId);

    // var updatedItems = state.cartModel!;
    // updatedItems.products.toList().remove(isCartItemExist);
    // state = state.copyWith(cartModel: updatedItems);
    await getCartItems();
  }

  Future<void> updateQty(productId, qty, type) async {
    var cartItem = state.cartModel!.products
        .firstWhere((element) => element.product.productId == productId);

    var updatedItems = state.cartModel!;

    if (type == "-") {
      await _apiService.removeCartItem(productId, 1);
      await getCartItems();

      if (cartItem.qty > 1) {
        CartProduct cartProduct =
            CartProduct(qty: cartItem.qty - 1, product: cartItem.product);
        updatedItems.products.toList().remove(cartItem);
        updatedItems.products.toList().add(cartProduct);
      } else {
        updatedItems.products.toList().remove(cartItem);
      }
    } else {
      await _apiService.addCartItem(productId, 1);
      await getCartItems();

      CartProduct cartProduct =
          CartProduct(qty: cartItem.qty + 1, product: cartItem.product);

      updatedItems.products.toList().remove(cartItem);
      updatedItems.products.toList().add(cartProduct);
    }
    state = state.copyWith(cartModel: updatedItems);
    await getCartItems();
  }
}
