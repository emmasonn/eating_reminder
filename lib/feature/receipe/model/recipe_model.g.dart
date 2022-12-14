// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIRecipeQuery _$APIRecipeQueryFromJson(Map<String, dynamic> json) =>
    APIRecipeQuery(
      query: json['q'] as String,
      from: json['from'] as int,
      to: json['to'] as int,
      more: json['more'] as bool,
      count: json['count'] as int,
      hits: (json['hits'] as List<dynamic>)
          .map((e) => APIHits.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$APIRecipeQueryToJson(APIRecipeQuery instance) =>
    <String, dynamic>{
      'q': instance.query,
      'from': instance.from,
      'to': instance.to,
      'more': instance.more,
      'count': instance.count,
      'hits': instance.hits,
    };

APIHits _$APIHitsFromJson(Map<String, dynamic> json) => APIHits(
      recipe: APIRecipe.fromJson(json['recipe'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$APIHitsToJson(APIHits instance) => <String, dynamic>{
      'recipe': instance.recipe,
    };

APIRecipe _$APIRecipeFromJson(Map<String, dynamic> json) => APIRecipe(
      label: json['label'] as String,
      image: json['image'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$APIRecipeToJson(APIRecipe instance) => <String, dynamic>{
      'label': instance.label,
      'image': instance.image,
      'url': instance.url,
    };
