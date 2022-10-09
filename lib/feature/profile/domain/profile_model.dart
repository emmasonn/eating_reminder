import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:informat/core/firebase_services/data_model.dart';

class ProfileModel extends DataModel implements Equatable {
  final String email;
  final String name;
  final String? country;
  final String? imageUrl;
  final int count;
  final String? telephone;
  final String? username;
  List<String>? schedulers;
  final DateTime lastUpdated;

  ProfileModel({
    required id,
    required this.email,
    required this.name,
    required this.lastUpdated,
    this.count = 0,
    this.country,
    this.imageUrl,
    this.username,
    this.telephone,
    this.schedulers,
  }) : super(id: id);

  factory ProfileModel.fromJson(Map<dynamic, dynamic> json) {
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
      schedulers: (json['schedulers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
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
    String? imageUrl,
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
      imageUrl: imageUrl ?? this.imageUrl,
      telephone: telephone ?? this.telephone,
      username: username ?? this.username,
      schedulers: schedulers ?? this.schedulers,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "count": count,
        "country": country,
        "imageUrl": imageUrl,
        "username": username,
        "telephone": telephone,
        "lastUpdated": lastUpdated.toIso8601String(),
        "schedulers": schedulers,
      };

  @override
  List<Object?> get props => [
        name,
        email,
        count,
        imageUrl,
        country,
        username,
        telephone,
        lastUpdated,
        schedulers,
      ];

  @override
  bool? get stringify => false;
}
