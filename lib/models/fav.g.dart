// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fav.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Fav _$$_FavFromJson(Map<String, dynamic> json) => _$_Fav(
      userId: json['userId'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => FavProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      favId: json['favId'] as String,
    );

Map<String, dynamic> _$$_FavToJson(_$_Fav instance) => <String, dynamic>{
      'userId': instance.userId,
      'products': instance.products,
      'favId': instance.favId,
    };
