// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fav_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavProduct _$FavProductFromJson(Map<String, dynamic> json) {
  return _FavProduct.fromJson(json);
}

/// @nodoc
mixin _$FavProduct {
  Product get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavProductCopyWith<FavProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavProductCopyWith<$Res> {
  factory $FavProductCopyWith(
          FavProduct value, $Res Function(FavProduct) then) =
      _$FavProductCopyWithImpl<$Res, FavProduct>;
  @useResult
  $Res call({Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$FavProductCopyWithImpl<$Res, $Val extends FavProduct>
    implements $FavProductCopyWith<$Res> {
  _$FavProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
  }) {
    return _then(_value.copyWith(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FavProductCopyWith<$Res>
    implements $FavProductCopyWith<$Res> {
  factory _$$_FavProductCopyWith(
          _$_FavProduct value, $Res Function(_$_FavProduct) then) =
      __$$_FavProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Product product});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$_FavProductCopyWithImpl<$Res>
    extends _$FavProductCopyWithImpl<$Res, _$_FavProduct>
    implements _$$_FavProductCopyWith<$Res> {
  __$$_FavProductCopyWithImpl(
      _$_FavProduct _value, $Res Function(_$_FavProduct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
  }) {
    return _then(_$_FavProduct(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavProduct implements _FavProduct {
  _$_FavProduct({required this.product});

  factory _$_FavProduct.fromJson(Map<String, dynamic> json) =>
      _$$_FavProductFromJson(json);

  @override
  final Product product;

  @override
  String toString() {
    return 'FavProduct(product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavProduct &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, product);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavProductCopyWith<_$_FavProduct> get copyWith =>
      __$$_FavProductCopyWithImpl<_$_FavProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavProductToJson(
      this,
    );
  }
}

abstract class _FavProduct implements FavProduct {
  factory _FavProduct({required final Product product}) = _$_FavProduct;

  factory _FavProduct.fromJson(Map<String, dynamic> json) =
      _$_FavProduct.fromJson;

  @override
  Product get product;
  @override
  @JsonKey(ignore: true)
  _$$_FavProductCopyWith<_$_FavProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
