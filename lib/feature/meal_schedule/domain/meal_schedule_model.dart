import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:informat/core/firebase_services/data_model.dart';

class MealScheduleModel extends DataModel implements Equatable {
  final String? country;
  final String title;
  final int? likes;
  final String? tags;
  final String? ownerId;
  final DateTime createdAt; //rename to lastUpdated
  final String? telephone;
  final String? description;
  DocumentReference? reference;

  MealScheduleModel({
    super.id,
     this.country,
    required this.title,
    this.ownerId,
    this.telephone,
    this.tags,
    this.description,
    required this.createdAt,
    this.likes,
    this.reference,
  });

  factory MealScheduleModel.fromJson(Map<dynamic, dynamic> data) {
    return MealScheduleModel(
        id: data['id'] as String,
        country: data['country'] as String,
        title: data['title'],
        likes: data['likes'],
        tags: data['tags'],
        ownerId: data['ownerId'],
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

  MealScheduleModel withCopy({
    String? id,
    String? ownerId,
    String? country,
    String? title,
    String? telephone,
    String? tags,
    String? description,
    int? likes,
  }) {
    return MealScheduleModel(
      id: id,
      ownerId: ownerId ?? this.ownerId,
      country: country ?? this.country,
      title: title ?? this.title,
      telephone: telephone ?? this.telephone,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      createdAt: createdAt,
      likes: likes,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'title': title,
        'likes': likes,
        'ownerId': ownerId,
        'tags': tags,
        'createdAt': createdAt.toIso8601String(),
        'telephone': telephone,
        'description': description
      };

  @override
  List<Object?> get props => [
        id,
        country,
        title,
        likes,
        tags,
        ownerId,
        createdAt,
        telephone,
        description,
        reference,
      ];

  @override
  bool? get stringify => false;
}
