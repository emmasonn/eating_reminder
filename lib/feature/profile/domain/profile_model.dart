import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:informat/core/firebase_services/data_model.dart';

class ProfileModel extends DataModel {
  final String email;
  final String name;
  final String? country;
  final int count;
  final String? telephone;
  final String? username;
  List<String>? schedulers;
  final DateTime? lastUpdated;

  ProfileModel({
    super.id,
    super.imageUrl,
    required this.email,
    required this.name,
    required this.lastUpdated,
    this.count = 0,
    this.country,
    this.username,
    this.telephone,
    this.schedulers,
  });

  factory ProfileModel.fromJson(Map<dynamic, dynamic> json) {
    List<String>? schedulers;

    if (json['schedulers'] != null) {
      schedulers = (json['schedulers'] as List<dynamic>)
          .map((e) => e as String)
          .toList();
    }

    return ProfileModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      count: json['count'],
      country: json['country'],
      imageUrl: json['imageUrl'],
      username: json['username'],
      telephone: json['telephone'],
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      schedulers: schedulers,
    );
  }

  factory ProfileModel.fromSnapshot(DocumentSnapshot snapshot) {
    return ProfileModel.fromJson(snapshot.data() as Map<dynamic, dynamic>);
  }

  ProfileModel copyWith({
    String? id,
    String? email,
    String? name,
    String? country,
    String? newImageUrl,
    DateTime? lastUpdated,
    int? count,
    String? telephone,
    String? username,
    List<String>? schedulers,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      imageUrl: newImageUrl,
      telephone: telephone ?? this.telephone,
      username: username ?? this.username,
      schedulers: schedulers ?? this.schedulers,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toJson() {
    final body = {
      "id": id,
      "email": email,
      "name": name,
      "count": count,
      "country": country,
      "username": username,
      "telephone": telephone,
      "lastUpdated": lastUpdated?.toIso8601String(),
      "schedulers": schedulers,
    };

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
        name,
        email,
        imageUrl,
        country,
        telephone,
        count,
        username,
        lastUpdated,
        schedulers,
      ];
}
