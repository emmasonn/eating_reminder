import 'package:get_it/get_it.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_storage.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/feature/Auth/manager/auth_manager.dart';
import 'package:informat/feature/Auth/repository/auth_repository.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/meal_schedule/repository/meal_schedule_repository.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/manager/profile_manager.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:informat/feature/what_to_eat/managers/food_manager.dart';
import 'package:informat/feature/what_to_eat/repository/food_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //! manager instances
  //foodmanager
  sl.registerFactory(() => FoodManager(sl(), sl()));

  //mealSchedulemanager
  sl.registerFactory(() => MealScheduleManager(sl()));

  //AuthManager
  sl.registerFactory(
      () => AuthManager(authRepository: sl(), foodManager: sl()));

  //ProfileManager
  sl.registerFactory(() => ProfileManager(sl()));

  //! Repository instance
  //FoodRepository
  sl.registerLazySingleton<FoodRepository>(
    () => FoodRepositoryImpl(
      networkInfo: sl(),
      foodFirebaseSource: sl(),
      foodHiveLocalSource: sl(),
      coreFirebaseAuth: sl(),
    ),
  );

  //AuthRepository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      firebaseRemoteAuth: sl(),
      networkInfo: sl(),
      profileFirebaseSource: sl(),
    ),
  );

  //mealshedule repository
  sl.registerLazySingleton<MealScheduleRepository>(
      () => MealScheduleRepositoryImpl(
            schedulerFirebaseSource: sl(),
            schedulerHiveLocalSource: sl(),
            profileRepository: sl(),
            coreFirebaseAuth: sl(),
            networkInfo: sl(),
          ));

  //profile repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
        profileFirebaseSource: sl(),
        profileHiveSource: sl(),
        coreFirebaseAuth: sl(),
        networkInfo: sl(),
        firebaseStorage: sl()),
  );

  //! Remote instance
  //MealScheduleModel remote source
  sl.registerLazySingleton<CustomFirebaseSource<MealScheduleModel>>(
    () => CustomFirebaseSource(
      collectionName: mealSchedulersPath,
      toJson: (MealScheduleModel obj) => obj.toJson(),
      fromJson: (data) => MealScheduleModel.fromJson(data),
    ),
  );

  //profileModel remote source
  sl.registerLazySingleton<CustomFirebaseSource<ProfileModel>>(
    () => CustomFirebaseSource(
      collectionName: profilesPath,
      toJson: (ProfileModel obj) => obj.toJson(),
      fromJson: (data) => ProfileModel.fromJson(data),
    ),
  );

  //! local instance
  //FoodModel remote source
  sl.registerLazySingleton<HiveLocalSource<FoodModel>>(
    () => HiveLocalSourceImpl(
      fromJson: (data) => FoodModel.fromJson(data),
      toJson: (FoodModel obj) => obj.toJson(),
    ),
  );

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
  //init foodModel
  await sl<HiveLocalSource<FoodModel>>().initBox();
  //init mealScheduleModel
  await sl<HiveLocalSource<MealScheduleModel>>().initBox();
  //init profileModel
  await sl<HiveLocalSource<ProfileModel>>().initBox();

  //! Core
  //FirebaseRemote Auth
  sl.registerLazySingleton<CoreFirebaseAuth>(() => CoreFirebaseAuth());

  //firebase firestore remote source
  sl.registerLazySingleton<CustomFirebaseSource<FoodModel>>(
    () => CustomFirebaseSource(
      collectionName: foodsPath,
      fromJson: (data) => FoodModel.fromJson(data),
      toJson: (FoodModel obj) => obj.toJson(),
    ),
  );

  //firebase storage source
  sl.registerLazySingleton<CustomFirebaseStorage>(
    () => CustomFirebaseStorage(),
  );

  //shared preference
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
