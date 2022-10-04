import 'package:informat/core/firebase_services/user_model.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';

extension ProfileExtensions on UserModel? {
  ProfileModel? toProfileModel() {
    if (this != null) {
      return ProfileModel(
        name: '',
        lastUpdated: DateTime(2022),
        id: this?.id ?? '',
        email: this!.email ?? '',
        imageUrl: this?.imageUrl,
      );
    } else {
      return null;
    }
  }
}
