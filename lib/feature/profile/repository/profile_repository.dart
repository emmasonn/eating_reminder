import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:informat/core/api_service/service_runner.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_service_runner.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_storage.dart';
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
  Future<Either<Failure, bool>> signOut();
  Future<ProfileModel?> getProfile(String id);
  Future<Stream<List<ProfileModel>>> subscribeTo(List<WhereClause>? where);
}

class ProfileRepositoryImpl extends ProfileRepository {
  final CustomFirebaseSource<ProfileModel> profileFirebaseSource;
  final HiveLocalSource<ProfileModel> profileHiveSource;
  final NetworkInfo networkInfo;
  final CoreFirebaseAuth coreFirebaseAuth;
  final CustomFirebaseStorage firebaseStorage;

  ProfileRepositoryImpl({
    required this.profileFirebaseSource,
    required this.profileHiveSource,
    required this.networkInfo,
    required this.coreFirebaseAuth,
    required this.firebaseStorage,
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
      // onCacheTask: (profile) async {
      //   if (profile != null) {
      //     profileHiveSource.setItem(profile);
      //   }
      // },
    ).runServiceTask(
      () async {
        if (obj.imageUrl != null && obj.imageUrl!.isNotEmpty) {
          //upload the image on storage to get link
          final imageLink = await firebaseStorage.uploadFile(
            storagePath: profileStoragePath,
            fileId: firebaseUser?.id ?? '',
            filePath: obj.imageUrl ?? '',
          );
          return profileFirebaseSource.setItem(
              obj.copyWith(id: firebaseUser?.id, newImageUrl: imageLink));
        } else {
          return profileFirebaseSource
              .setItem(obj.copyWith(id: firebaseUser?.id));
        }
      },
    );
  }

  //This function listen to changes in profiles collection and
  //returns the profile that matches user id and currenttly updated,
  @override
  Future<Stream<List<ProfileModel>>> subscribeTo(
      List<WhereClause>? where) async {
    final cachedProfile = await getCachedProfile();
    final firebaseUser = await coreFirebaseAuth.currentUser;

    return profileFirebaseSource.subscribeTo([
      WhereClause.equals(fieldName: 'id', value: firebaseUser!.id ?? ''),
      if (cachedProfile != null) ...[
        WhereClause.greaterThan(
          fieldName: 'lastUpdated',
          value: cachedProfile.lastUpdated ?? DateTime.now(),
        )
      ]
    ]).asBroadcastStream()
      ..listen((profiles) {
        if (profiles.isNotEmpty) {
          for (final profile in profiles) {
            profileHiveSource.setItem(profile);
          }
        }
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
      return ProfileModel(
        name: '',
        lastUpdated: DateTime.now(),
        id: firebaseUser?.id,
        email: firebaseUser?.email ?? '',
        imageUrl: firebaseUser?.imageUrl,
      );
    }
    return profile;
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    return ServiceRunner<bool>(networkInfo: networkInfo).runNetworkTask(() {
      coreFirebaseAuth.signOut();
      profileHiveSource.clear();
      return Future.value(true);
    });
  }
}
