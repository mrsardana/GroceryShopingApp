import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:grocerry_shopping_app/models/fav.dart';

part 'fav_state.freezed.dart';

@freezed
class FavState with _$FavState {
  factory FavState({Fav? favModel, @Default(false) bool isLoading}) = _FavState;
}
