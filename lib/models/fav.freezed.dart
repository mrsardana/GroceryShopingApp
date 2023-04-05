// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fav.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Fav _$FavFromJson(Map<String, dynamic> json) {
  return _Fav.fromJson(json);
}

/// @nodoc
mixin _$Fav {
  String get userId => throw _privateConstructorUsedError;
  List<FavProduct> get products => throw _privateConstructorUsedError;
  String get favId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavCopyWith<Fav> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavCopyWith<$Res> {
  factory $FavCopyWith(Fav value, $Res Function(Fav) then) =
      _$FavCopyWithImpl<$Res, Fav>;
  @useResult
  $Res call({String userId, List<FavProduct> products, String favId});
}

/// @nodoc
class _$FavCopyWithImpl<$Res, $Val extends Fav> implements $FavCopyWith<$Res> {
  _$FavCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? products = null,
    Object? favId = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<FavProduct>,
      favId: null == favId
          ? _value.favId
          : favId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavCopyWith<$Res> implements $FavCopyWith<$Res> {
  factory _$$_FavCopyWith(_$_Fav value, $Res Function(_$_Fav) then) =
      __$$_FavCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, List<FavProduct> products, String favId});
}

/// @nodoc
class __$$_FavCopyWithImpl<$Res> extends _$FavCopyWithImpl<$Res, _$_Fav>
    implements _$$_FavCopyWith<$Res> {
  __$$_FavCopyWithImpl(_$_Fav _value, $Res Function(_$_Fav) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? products = null,
    Object? favId = null,
  }) {
    return _then(_$_Fav(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<FavProduct>,
      favId: null == favId
          ? _value.favId
          : favId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Fav implements _Fav {
  _$_Fav(
      {required this.userId,
      required final List<FavProduct> products,
      required this.favId})
      : _products = products;

  factory _$_Fav.fromJson(Map<String, dynamic> json) => _$$_FavFromJson(json);

  @override
  final String userId;
  final List<FavProduct> _products;
  @override
  List<FavProduct> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final String favId;

  @override
  String toString() {
    return 'Fav(userId: $userId, products: $products, favId: $favId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Fav &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.favId, favId) || other.favId == favId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId,
      const DeepCollectionEquality().hash(_products), favId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavCopyWith<_$_Fav> get copyWith =>
      __$$_FavCopyWithImpl<_$_Fav>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavToJson(
      this,
    );
  }
}

abstract class _Fav implements Fav {
  factory _Fav(
      {required final String userId,
      required final List<FavProduct> products,
      required final String favId}) = _$_Fav;

  factory _Fav.fromJson(Map<String, dynamic> json) = _$_Fav.fromJson;

  @override
  String get userId;
  @override
  List<FavProduct> get products;
  @override
  String get favId;
  @override
  @JsonKey(ignore: true)
  _$$_FavCopyWith<_$_Fav> get copyWith => throw _privateConstructorUsedError;
}
