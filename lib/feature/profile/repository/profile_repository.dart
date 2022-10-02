import 'package:dartz/dartz.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_service_runner.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/core/shared_pref_cache/cache_manager.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';

abstract class ProfileRepository<T extends ProfileModel> {
  Future<T?> getCachedProfile();
  Future<Either<Failure, T?>> saveProfile(T obj);
  Future<Either<Failure, T>> deleteProfile(T obj);
  Future<Stream<T>> subscribeTo(List<WhereClause>? where);
}

class ProfileRepositoryImpl<T extends ProfileModel>
    extends ProfileRepository<T> {
  final FirebaseSource<T> profileFirebaseSource;
  final HiveLocalSource<T> profileHiveSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.profileFirebaseSource,
    required this.profileHiveSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, T>> deleteProfile(T obj) {
    // TODO: implement deleteProfile
    throw UnimplementedError();
  }

  @override
  Future<T?> getCachedProfile() async {
    final profileId = await CacheManager.instance.getPref(profileKey);
    return profileHiveSource.getItem(profileId);
  }

  @override
  Future<Either<Failure, T?>> saveProfile(T obj) async {
    return HiveFireServiceRunner<T?>(
      networkInfo: networkInfo,
      onCacheTask: (profile) async {
        if (profile != null) {
          profileHiveSource.setItem(profile);
        }
      },
    ).runServiceTask(
      () => profileFirebaseSource.setItem(obj),
    );
  }
  
  @override
  Future<Stream<T>> subscribeTo(List<WhereClause>? where) {
    // TODO: implement subscribeTo
    throw UnimplementedError();
  }
}
