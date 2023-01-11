// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FoodModel _$$_FoodModelFromJson(Map<String, dynamic> json) => _$_FoodModel(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      scheduleId: json['scheduleId'] as String,
      title: json['title'] as String,
      period: json['period'] as String,
      day: json['day'] as String,
      recipe: json['recipe'] as String?,
      description: json['description'] as String?,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$_FoodModelToJson(_$_FoodModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'scheduleId': instance.scheduleId,
      'title': instance.title,
      'period': instance.period,
      'day': instance.day,
      'recipe': instance.recipe,
      'description': instance.description,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };
