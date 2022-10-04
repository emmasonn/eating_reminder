import 'package:dartz/dartz.dart';
import 'package:informat/core/api_service/service_runner.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/user_model.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/core/shared_pref_cache/cache_manager.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';

abstract class AuthRepository<T extends UserModel> {
  Future<Either<Failure, ProfileModel?>> loginWithGoogle();
  Future<Either<Failure, ProfileModel?>> loginWithApple();
}

class AuthRepositoryImpl extends AuthRepository {
  final CoreFirebaseAuth firebaseRemoteAuth;
  final NetworkInfo networkInfo;
  final ProfileRepository profileRepository;
  AuthRepositoryImpl({
    required this.firebaseRemoteAuth,
    required this.networkInfo,
    required this.profileRepository,
  });

  @override
  Future<Either<Failure, ProfileModel?>> loginWithApple() {
    return ServiceRunner<ProfileModel?>(networkInfo: networkInfo)
        .runNetworkTask(() async {
      final user = await firebaseRemoteAuth.loginWithGoogle();
      CacheManager.instance.storePref(profileKey, user.id!);
      return await profileRepository.getProfile(user.id!);
    });
  }

  @override
  Future<Either<Failure, ProfileModel?>> loginWithGoogle() {
    return ServiceRunner<ProfileModel?>(networkInfo: networkInfo)
        .runNetworkTask(() async {
      final user = await firebaseRemoteAuth.loginWithGoogle();
      CacheManager.instance.storePref(profileKey, user.id!);
      return await profileRepository.getProfile(user.id!);
    });
  }
}
