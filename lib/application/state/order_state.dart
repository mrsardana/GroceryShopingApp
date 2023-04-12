import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  factory OrderState(
      {Map<String, dynamic>? orderModel,
      @Default(false) bool isLoading}) = _OrderState;
}
