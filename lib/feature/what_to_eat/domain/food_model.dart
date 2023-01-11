import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:informat/core/firebase_services/data_model.dart';

part 'food_model.g.dart';
part 'food_model.freezed.dart';

@Freezed()
class FoodModel extends DataModel with _$FoodModel {
  @JsonSerializable(explicitToJson: true)
  factory FoodModel({
    required String id,
    required String ownerId,
    required String scheduleId,
    required String title,
    required String period,
    required String day,
    String? recipe,
    String? description,
    DateTime? lastUpdated,
  }) = _FoodModel;

  const FoodModel._() : super(id: '');

  factory FoodModel.fromJson(Map<String, dynamic> json) =>
      _$FoodModelFromJson(json);

  @override
  DataModel copyWith2(String? newId) {
    return FoodModel(
      id: newId ?? id,
      ownerId: ownerId,
      scheduleId: scheduleId,
      title: title,
      period: period,
      day: day,
    );
  }

  @override
  List<Object?> get props => [];
}
