// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FoodModel _$$_FoodModelFromJson(Map<String, dynamic> json) => _$_FoodModel(
      id: json['id'] as String,
      foods: (json['foods'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_FoodModelToJson(_$_FoodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foods': instance.foods,
    };
