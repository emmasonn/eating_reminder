import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:informat/core/firebase_services/data_model.dart';

part 'food_model.g.dart';
part 'food_model.freezed.dart';

@Freezed()
class FoodModel extends DataModel with _$FoodModel {
  @JsonSerializable(explicitToJson: true)
   factory FoodModel({
    required String id,
    required List<String> foods
  }) = _FoodModel;

  factory FoodModel.fromJson(Map<String,dynamic> json) => _$FoodModelFromJson(json);
}
