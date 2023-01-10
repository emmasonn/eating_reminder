import 'package:dartz/dartz.dart';
import 'package:informat/core/api_service/service_runner.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/user_model.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/core/shared_pref_cache/cache_manager.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/utils/profile_extension.dart';
import 'package:nb_utils/nb_utils.dart';

abstract class AuthRepository<T extends UserModel> {
  Future<Either<Failure, ProfileModel?>> loginWithGoogle();
  Future<Either<Failure, ProfileModel?>> loginWithApple();
  Future<Either<Failure, bool>> registerEmail(String email, String password);
  Future<Either<Failure, bool>> loginWithEmail(String email, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  final CoreFirebaseAuth firebaseRemoteAuth;
  final NetworkInfo networkInfo;
  final CustomFirebaseSource<ProfileModel> profileFirebaseSource;
  AuthRepositoryImpl({
    required this.firebaseRemoteAuth,
    required this.networkInfo,
    required this.profileFirebaseSource,
  });

  @override
  Future<Either<Failure, ProfileModel?>> loginWithApple() {
    return ServiceRunner<ProfileModel?>(networkInfo: networkInfo)
        .runNetworkTask(() async {
      final user = await firebaseRemoteAuth.loginWithGoogle();
      CacheManager.instance.storePref(profileKey, user.id!);
      return await profileFirebaseSource.setItem(user.toProfileModel()!);
    });
  }

  @override
  Future<Either<Failure, ProfileModel?>> loginWithGoogle() {
    return ServiceRunner<ProfileModel?>(networkInfo: networkInfo)
        .runNetworkTask(() async {
      final authUser = await firebaseRemoteAuth.loginWithGoogle();
      CacheManager.instance.storePref(profileKey, authUser.id!);
      return await profileFirebaseSource.setItem(authUser.toProfileModel()!);
    });
  }

  @override
  Future<Either<Failure, bool>> loginWithEmail(String email, String password) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() async {
      final authUser = await firebaseRemoteAuth.loginWithEmail(email, password);
      CacheManager.instance.storePref(profileKey, authUser.id!);
      final profile = await profileFirebaseSource.viewItem(authUser.id ?? '');
      log(authUser);
      if (profile != null && profile.country != null) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  Future<Either<Failure, bool>> registerEmail(String email, String password) {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() async {
      final authUser =
          await firebaseRemoteAuth.registerWithEmail(email, password);
      CacheManager.instance.storePref(profileKey, authUser.id!);
      await profileFirebaseSource.setItem(authUser.toProfileModel()!);
      log(authUser);
      return true;
    });
  }
}
