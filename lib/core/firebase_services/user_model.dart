import 'package:equatable/equatable.dart';
import 'package:informat/core/firebase_services/data_model.dart';

class UserModel extends DataModel implements Equatable {
  final String? email;
  final String? imageUrl;
  
  const UserModel({
    required super.id,
    required this.email,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        imageUrl,
      ];

  @override
  bool? get stringify => false;
  
}
