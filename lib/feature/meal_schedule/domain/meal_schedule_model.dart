import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:informat/core/firebase_services/data_model.dart';

class MealScheduleModel extends DataModel implements Equatable {
  final String? imageUrl;
  final String country;
  final String title;
  final int likes;
  final String tags;
  final DateTime createdAt;
  final String telephone;
  final String description;
  DocumentReference? reference;

  MealScheduleModel({
    required id,
    this.imageUrl,
    required this.country,
    required this.title,
    required this.telephone,
    required this.tags,
    required this.description,
    required this.createdAt,
    required this.likes,
    this.reference,
  }) : super(id: id);

  factory MealScheduleModel.fromJson(Map<dynamic, dynamic> data) {
    return MealScheduleModel(
        id: data['id'] as String,
        imageUrl: data['imageUrl'] as String,
        country: data['country'] as String,
        title: data['title'],
        likes: data['likes'],
        tags: data['tags'],
        createdAt: DateTime.parse(data['createdAt'] as String),
        telephone: data['telephone'],
        description: data['description']);
  }

  factory MealScheduleModel.fromSnapshot(DocumentSnapshot snapshot) {
    final mealSchedule =
        MealScheduleModel.fromJson(snapshot.data() as Map<dynamic, dynamic>);
    mealSchedule.reference = snapshot.reference;
    return mealSchedule;
  }

  // MealScheduleModel withCopy({
  //   String? country,
  //   String? title,
  //   String? telephone,
  //   String? tags,
  //   String? description,
  //   int? likes,

  // }) {
  //   return MealScheduleModel(
  //     id: id,
  //     country: country ?? this.country,
  //     title: title ?? this.title,
  //     telephone: telephone ?? this.telephone,
  //     tags: tags ?? this.tags,
  //     description: description ?? this.description,
  //     createdAt: createdAt,
  //     likes: likes,
  //   );
  // }

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'country': country,
        'title': title,
        'likes': likes,
        'tags': tags,
        'createdAt': createdAt.toIso8601String(),
        'telephone': telephone,
        'description': description
      };

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        country,
        title,
        likes,
        tags,
        createdAt,
        telephone,
        description,
        reference,
      ];

  @override
  bool? get stringify => true;
}
