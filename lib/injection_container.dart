import 'package:get_it/get_it.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/meal_schedule/repository/meal_repository.dart';
import 'package:informat/feature/meal_schedule/repository/meal_schedule_repository.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';
import 'package:informat/feature/what_to_eat/managers/food_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //! manager instances
  //food manager
  sl.registerFactory(() => FoodManager());

  //mealSchedule manager
  sl.registerFactory(() => MealScheduleManager(sl()));

  //! Repository instance
  //mealRepository
  sl.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(
      firebaseSource: sl(),
      hiveLocalSource: sl(),
    ),
  );

  //mealshedule repository
  sl.registerLazySingleton<MealScheduleRepository>(
      () => MealScheduleRepositoryImpl(
            schedulerFirebaseSource: sl(),
            schedulerHiveLocalSource: sl(),
            profileRepository: sl(),
            networkInfo: sl(),
          ));

  //profile repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileFirebaseSource: sl(),
      profileHiveSource: sl(),
      networkInfo: sl(),
    ),
  );

  //! Remote instance
  //MealScheduleModel remote source
  sl.registerLazySingleton<FirebaseSource<MealScheduleModel>>(
    () => FirebaseSource(
      collectionName: mealSchedulersPath,
      toJson: (MealScheduleModel obj) => obj.toJson(),
      fromJson: (data) => MealScheduleModel.fromJson(data),
    ),
  );

  //profileModel remote source
  sl.registerLazySingleton<FirebaseSource<ProfileModel>>(
    () => FirebaseSource(
      collectionName: mealSchedulersPath,
      toJson: (ProfileModel obj) => obj.toJson(),
      fromJson: (data) => ProfileModel.fromJson(data),
    ),
  );

  //! local instance
  //MealScheduleModel local source
  sl.registerLazySingleton<HiveLocalSource<MealScheduleModel>>(
      () => HiveLocalSourceImpl(
            toJson: (MealScheduleModel obj) => obj.toJson(),
            fromJson: (data) => MealScheduleModel.fromJson(data),
          ));

  //Profile local instance
  sl.registerLazySingleton<HiveLocalSource<ProfileModel>>(
      () => HiveLocalSourceImpl(
            toJson: (ProfileModel obj) => obj.toJson(),
            fromJson: (data) => ProfileModel.fromJson(data),
          ));

  //! initialize HiveBox
  //init mealScheduleModel
  await sl<HiveLocalSource<MealScheduleModel>>().initBox();
  //init profileModel
  await sl<HiveLocalSource<ProfileModel>>().initBox();

  //! Core
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
