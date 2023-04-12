import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocerry_shopping_app/api/api_service.dart';
import 'package:grocerry_shopping_app/application/state/order_state.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final APIService _apiService;

  OrderNotifier(this._apiService) : super(OrderState()) {
    getOrderItems();
  }

  Future<void> getOrderItems() async {
    state = state.copyWith(isLoading: true);
    final orderData = await _apiService.getOrder();

    state = state.copyWith(orderModel: orderData);
    state = state.copyWith(isLoading: false);
  }
}
