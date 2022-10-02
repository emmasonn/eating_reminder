import 'package:dartz/dartz.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_service_runner.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';

abstract class MealScheduleRepository<T extends MealScheduleModel> {
  Future<List<T>> getCachedMealSchedule();
  Future<Either<Failure, T?>> createMealSchedule(T obj);
  Future<Either<Failure, bool>> pinMealSchedule(T obj);
  Future<Either<Failure, bool>> deleteMealSchedule(T obj);
  Future<Stream<List<T>>> subscribeTo(List<WhereClause>? where);
}

class MealScheduleRepositoryImpl<T extends MealScheduleModel>
    extends MealScheduleRepository<T> {
  final FirebaseSource<T> schedulerFirebaseSource;
  final HiveLocalSource<T> schedulerHiveLocalSource;
  final ProfileRepository<ProfileModel> profileRepository;
  final NetworkInfo networkInfo;

  MealScheduleRepositoryImpl({
    required this.schedulerFirebaseSource,
    required this.schedulerHiveLocalSource,
    required this.profileRepository,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, T?>> createMealSchedule(T obj) {
    return HiveFireServiceRunner<T?>(networkInfo: networkInfo)
        .runServiceTask(() => schedulerFirebaseSource.setItem(obj));
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
  Future<List<T>> getCachedMealSchedule() async {
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

  @override
  Future<Stream<List<T>>> subscribeTo(List<WhereClause>? where) async {
    final profile = await profileRepository.getCachedProfile();
    return schedulerFirebaseSource.subscribeTo([
      if (profile!.schedulers != null) ...[
        WhereClause.whereIn(fieldName: 'id', value: profile.schedulers!),
      ],
      if (where != null) ...where
    ]).asBroadcastStream()
      ..listen((List<T> mealSchedulers) {
        for (final mealScheduler in mealSchedulers) {
          schedulerHiveLocalSource.setItem(mealScheduler);
        }
      });
  }
}
