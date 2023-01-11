import 'package:dartz/dartz.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_service_runner.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';
import 'package:nb_utils/nb_utils.dart';

abstract class MealScheduleRepository<T extends MealScheduleModel> {
  Future<bool> get isLoggedIn;
  Future<List<MealScheduleModel>> getCachedMealSchedule();
  Future<Either<Failure, MealScheduleModel?>> createMealSchedule(T obj);
  Future<Either<Failure, bool>> pinMealSchedule(T obj);
  Future<Either<Failure, bool>> deleteMealSchedule(T obj);
  Future<Stream<List<MealScheduleModel>>> subscribeTo(List<WhereClause>? where);
}

class MealScheduleRepositoryImpl<T extends MealScheduleModel>
    extends MealScheduleRepository<T> {
  final CustomFirebaseSource<MealScheduleModel> schedulerFirebaseSource;
  final HiveLocalSource<MealScheduleModel> schedulerHiveLocalSource;
  final ProfileRepository profileRepository;
  final CoreFirebaseAuth coreFirebaseAuth;
  final NetworkInfo networkInfo;

  MealScheduleRepositoryImpl({
    required this.schedulerFirebaseSource,
    required this.schedulerHiveLocalSource,
    required this.coreFirebaseAuth,
    required this.profileRepository,
    required this.networkInfo,
  });

  @override
  Future<bool> get isLoggedIn async =>
      await coreFirebaseAuth.currentUser != null;

  @override
  Future<Either<Failure, MealScheduleModel?>> createMealSchedule(T obj) {
    return HiveFireServiceRunner<MealScheduleModel?>(networkInfo: networkInfo)
        .runServiceTask(() async {
      // final doc = schedulerFirebaseSource.collection.doc();
      final cachedProfile = await profileRepository.getCachedProfile();
      final newObj = obj.withCopy(
          ownerId: cachedProfile?.id,
          country: cachedProfile?.country,
          description: 'created by ${cachedProfile?.name ?? 'Unknown'}');

      log('Schedule to be created: ${newObj}');

      return schedulerFirebaseSource.setItem(newObj);
    });
  }

  @override
  Future<Either<Failure, bool>> deleteMealSchedule(T obj) async {
    return HiveFireServiceRunner<bool>(networkInfo: networkInfo)
        .runServiceTask(() {
      schedulerFirebaseSource.deleteItem(obj);
      return Future.value(true);
    });
  }

  @override
  Future<List<MealScheduleModel>> getCachedMealSchedule() async {
    //get cached data
    return schedulerHiveLocalSource.getItems();
  }

  @override
  Future<Either<Failure, bool>> pinMealSchedule(T obj) async {
    final profile = await profileRepository.getCachedProfile();
    if (profile != null) {
      final schedulers = profile.schedulers ?? [];
      //Here we're checking if the scheduler already exist
      //if it exist we remove else we add it to profile schedulers
      if (schedulers.contains(obj.id)) {
        schedulers.remove(obj.id);
      } else {
        schedulers.add(obj.id!);
      }
      profileRepository.saveProfile(
        profile.copyWith(
          schedulers: schedulers,
          lastUpdated: DateTime.now(),
        ),
      );
      return const Right(true);
    } else {
      return const Right(false);
    }
  }

  //Create a stream hivedatabase and make it your source of truth.
  //such that your ui listens to what is on your database later then
  //directly from remote database

  @override
  Future<Stream<List<MealScheduleModel>>> subscribeTo(
      List<WhereClause>? where) async {
    final profile = await profileRepository.getCachedProfile();
    final cachedSchedulers = await getCachedMealSchedule();

    return schedulerFirebaseSource.subscribeTo([
      if (profile?.schedulers != null) ...[
        WhereClause.whereIn(fieldName: 'id', value: profile!.schedulers!),
      ],
      if (cachedSchedulers.isNotEmpty) ...[
        WhereClause.greaterThan(
          fieldName: 'createdAt',
          value: cachedSchedulers.last.createdAt,
        )
      ]
    ]).asBroadcastStream()
      ..listen((List<MealScheduleModel> mealSchedulers) {
        for (final mealScheduler in mealSchedulers) {
          schedulerHiveLocalSource.setItem(mealScheduler);
        }
      });
  }
}
