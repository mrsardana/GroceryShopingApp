// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fav_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FavState {
  Fav? get favModel => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavStateCopyWith<FavState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavStateCopyWith<$Res> {
  factory $FavStateCopyWith(FavState value, $Res Function(FavState) then) =
      _$FavStateCopyWithImpl<$Res, FavState>;
  @useResult
  $Res call({Fav? favModel, bool isLoading});

  $FavCopyWith<$Res>? get favModel;
}

/// @nodoc
class _$FavStateCopyWithImpl<$Res, $Val extends FavState>
    implements $FavStateCopyWith<$Res> {
  _$FavStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favModel = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      favModel: freezed == favModel
          ? _value.favModel
          : favModel // ignore: cast_nullable_to_non_nullable
              as Fav?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FavCopyWith<$Res>? get favModel {
    if (_value.favModel == null) {
      return null;
    }

    return $FavCopyWith<$Res>(_value.favModel!, (value) {
      return _then(_value.copyWith(favModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FavStateCopyWith<$Res> implements $FavStateCopyWith<$Res> {
  factory _$$_FavStateCopyWith(
          _$_FavState value, $Res Function(_$_FavState) then) =
      __$$_FavStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Fav? favModel, bool isLoading});

  @override
  $FavCopyWith<$Res>? get favModel;
}

/// @nodoc
class __$$_FavStateCopyWithImpl<$Res>
    extends _$FavStateCopyWithImpl<$Res, _$_FavState>
    implements _$$_FavStateCopyWith<$Res> {
  __$$_FavStateCopyWithImpl(
      _$_FavState _value, $Res Function(_$_FavState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favModel = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$_FavState(
      favModel: freezed == favModel
          ? _value.favModel
          : favModel // ignore: cast_nullable_to_non_nullable
              as Fav?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_FavState implements _FavState {
  _$_FavState({this.favModel, this.isLoading = false});

  @override
  final Fav? favModel;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'FavState(favModel: $favModel, isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavState &&
            (identical(other.favModel, favModel) ||
                other.favModel == favModel) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, favModel, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavStateCopyWith<_$_FavState> get copyWith =>
      __$$_FavStateCopyWithImpl<_$_FavState>(this, _$identity);
}

abstract class _FavState implements FavState {
  factory _FavState({final Fav? favModel, final bool isLoading}) = _$_FavState;

  @override
  Fav? get favModel;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$_FavStateCopyWith<_$_FavState> get copyWith =>
      throw _privateConstructorUsedError;
}
