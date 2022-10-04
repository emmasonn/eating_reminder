import 'package:dartz/dartz.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_service_runner.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/core/shared_pref_cache/cache_manager.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/utils/profile_extension.dart';

abstract class ProfileRepository {
  Future<ProfileModel?> getCachedProfile();
  Future<Either<Failure, ProfileModel?>> saveProfile(ProfileModel obj);
  Future<Either<Failure, ProfileModel>> deleteProfile(ProfileModel obj);
  Future<ProfileModel?> getProfile(String id);
  Future<Stream<List<ProfileModel>>> subscribeTo(List<WhereClause>? where);
}

class ProfileRepositoryImpl extends ProfileRepository {
  final FirebaseSource<ProfileModel> profileFirebaseSource;
  final HiveLocalSource<ProfileModel> profileHiveSource;
  final NetworkInfo networkInfo;
  final CoreFirebaseAuth coreFirebaseAuth;

  ProfileRepositoryImpl({
    required this.profileFirebaseSource,
    required this.profileHiveSource,
    required this.networkInfo,
    required this.coreFirebaseAuth,
  });

  @override
  Future<Either<Failure, ProfileModel>> deleteProfile(ProfileModel obj) {
    // TODO: implement deleteProfile
    throw UnimplementedError();
  }

  //get function retrieves latest profile stored in the cache
  @override
  Future<ProfileModel?> getCachedProfile() async {
    final String? profileId = await CacheManager.instance.getPref(profileKey);
    final cachedProfile = await profileHiveSource.getItem(profileId ?? '');
    final firebaseUser = await coreFirebaseAuth.currentUser;
    if (cachedProfile != null) {
      return cachedProfile;
    } else {
      return firebaseUser.toProfileModel();
    }
  }

  @override
  Future<Either<Failure, ProfileModel?>> saveProfile(ProfileModel obj) async {
    final firebaseUser = await coreFirebaseAuth.currentUser;
    return HiveFireServiceRunner<ProfileModel?>(
      networkInfo: networkInfo,
      onCacheTask: (profile) async {
        if (profile != null) {
          profileHiveSource.setItem(profile);
        }
      },
    ).runServiceTask(
      () => profileFirebaseSource.setItem(obj.copyWith(id: firebaseUser?.id)),
    );
  }

  //This function listen to changes in profiles collection and
  //returns the profile that matches user id and currenttly updated,
  @override
  Future<Stream<List<ProfileModel>>> subscribeTo(
      List<WhereClause>? where) async {
    final cachedProfile = await getCachedProfile();
    return profileFirebaseSource.subscribeTo([
      if (cachedProfile != null)
        WhereClause.equals(fieldName: 'id', value: cachedProfile.id!),
      WhereClause.greaterThan(
          fieldName: 'lastUpdated', value: cachedProfile!.lastUpdated)
    ]).asBroadcastStream()
      ..listen((profiles) {
        saveProfile(profiles.first);
      });
  }

  //I don't think this function is still relevant
  //because i think subscribeTo can do th same job and
  //as well save us unnecessary charges
  @override
  Future<ProfileModel?> getProfile(String id) async {
    final profile = await profileFirebaseSource.viewItem(id);
    final firebaseUser = await coreFirebaseAuth.currentUser;
    if (profile != null) {
      profileHiveSource.setItem(profile);
    } else {
      return profile?.copyWith(
        lastUpdated: DateTime.now(),
        id: firebaseUser?.id,
        email: firebaseUser?.email,
        imageUrl: firebaseUser?.imageUrl,
      );
    }
    return profile;
  }
}
