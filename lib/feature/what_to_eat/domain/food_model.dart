import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:informat/core/firebase_services/data_model.dart';

part 'food_model.g.dart';
part 'food_model.freezed.dart';

@Freezed()
class FoodModel extends DataModel with _$FoodModel {
  @JsonSerializable(explicitToJson: true)
  factory FoodModel({
    required String id,
    required  String ownerId,
    required String scheduleId,
    required String title,
    required String period,
    required String day,
    String? recipe,
    String? description,
    DateTime? time,
  }) = _FoodModel;

  const FoodModel._() : super(id: '');

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);
}
