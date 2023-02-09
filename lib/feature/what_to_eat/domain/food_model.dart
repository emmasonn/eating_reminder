import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:informat/core/firebase_services/data_model.dart';
import 'package:informat/core/utils/date_time_util.dart';

class FoodModel extends DataModel {
  final String title;
  final String period;
  final String scheduleId;
  final String day;
  final String? mealTime;
  final String? ownerId;
  final String? recipe;
  final String? description;
  final DateTime lastUpdated;

  const FoodModel({
    super.id,
    super.imageUrl,
    required this.title,
    required this.period,
    required this.scheduleId,
    required this.day,
    this.mealTime,
    this.ownerId,
    this.recipe,
    this.description,
    required this.lastUpdated,
  });

  factory FoodModel.fromSnapshot(DocumentSnapshot snapshot) {
    return FoodModel.fromJson(snapshot.data() as Map<dynamic, dynamic>);
  }

  factory FoodModel.fromJson(Map<dynamic, dynamic> json) {
    final period = json['period'] as String;
    final List<String> periodSplit = period.split('-');

    return FoodModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      period: periodSplit?.first ?? '',
      ownerId: json['ownerId'],
      scheduleId: json['scheduleId'],
      day: json['day'],
      description: json['description'],
      recipe: json['recipe'],
      mealTime: json['mealTime'] ?? periodSplit.last,
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }

  FoodModel copyWith({
    String? newId,
    String? imageLink,
  }) {
    return FoodModel(
      id: newId ?? id,
      imageUrl: imageLink,
      ownerId: ownerId,
      scheduleId: scheduleId,
      title: title,
      period: period,
      day: day,
      description: description,
      recipe: recipe,
      mealTime: mealTime,
      lastUpdated: lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    final body = {
      "title": title,
      "period": period,
      "ownerId": ownerId,
      "scheduleId": scheduleId,
      "day": day,
      "description": description,
      "mealTime": mealTime,
      "lastUpdated": lastUpdated.toIso8601String(),
    };

    if (id != null && id!.isNotEmpty) {
      body.addAll({
        "id": id,
      });
    }

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      body.addAll({
        "imageUrl": imageUrl,
      });
    }
    return body;
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        ownerId,
        scheduleId,
        title,
        period,
        day,
        mealTime,
        recipe,
        lastUpdated,
      ];
}

extension foodsToDay on List<FoodModel> {
  Map<String, List<FoodModel>> mapFoodsToDay() {
    final Map<String, List<FoodModel>> foodsAndDay = {};

    if (isNotEmpty) {
      for (final element in weekDays) {
        final List<FoodModel> newFoods = [];
        for (final food in this) {
          if (food.day == element) {
            newFoods.add(food);
          }
        }
        foodsAndDay.addAll({element: newFoods});
      }
    }
    return foodsAndDay;
  }
}
