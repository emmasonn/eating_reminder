import 'package:dartz/dartz.dart';
import 'package:informat/core/api_service/service_runner.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_storage.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:uuid/uuid.dart';

abstract class FoodRepository {
  Future<bool> get isLoggedIn;
  Future<List<FoodModel>> getCachedFoods();
  Future<Either<Failure, FoodModel?>> createMeal(FoodModel obj);
  Future<Either<Failure, List<FoodModel>>> getMeals();
  // Stream<List<FoodModel>> streamGetFoods();
  Future<Either<Failure, bool>> deleteMeal(String id);
  Future<Stream<List<FoodModel>>> subscribeTo(List<WhereClause>? where);
  Future<Stream<List<FoodModel>>> subscribeToSchedule(List<WhereClause>? where);
}

class FoodRepositoryImpl extends FoodRepository {
  final NetworkInfo networkInfo;
  final CustomFirebaseSource<FoodModel> foodFirebaseSource;
  final HiveLocalSource<FoodModel> foodHiveLocalSource;
  final CoreFirebaseAuth coreFirebaseAuth;
  final CustomFirebaseStorage firebaseStorage;
  FoodRepositoryImpl({
    required this.networkInfo,
    required this.foodFirebaseSource,
    required this.foodHiveLocalSource,
    required this.coreFirebaseAuth,
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, FoodModel?>> createMeal(FoodModel obj) async {
    final firebaseUser = await coreFirebaseAuth.currentUser;

    return ServiceRunner<FoodModel?>(
      networkInfo: networkInfo,
    ).runNetworkTask(
      () async {
        final fileId = const Uuid().v4();
        if (obj.imageUrl != null && obj.imageUrl!.isNotEmpty) {
          //upload the image on storage to get link
          final imageLink = await firebaseStorage.uploadFile(
            storagePath: '$foodStoragePath/${firebaseUser?.id ?? ''}',
            fileId: fileId,
            filePath: obj.imageUrl ?? '',
          );
          return foodFirebaseSource.setItem(obj.copyWith(imageLink: imageLink));
        }
        return await foodFirebaseSource.setItem(obj);
      },
    );
  }

  @override
  Future<bool> get isLoggedIn async =>
      await coreFirebaseAuth.currentUser != null;

  @override
  Future<List<FoodModel>> getCachedFoods() async {
    return foodHiveLocalSource.getItems();
  }

  @override
  Future<Stream<List<FoodModel>>> subscribeToSchedule(
      List<WhereClause>? where) async {
    final cachedFoods = await getCachedFoods();

    return foodFirebaseSource.subscribeTo([
      ...where ?? [], //delist the  incoming where
      // if (cachedFoods.isNotEmpty) ...[
      //   WhereClause.greaterThan(
      //     fieldName: 'lastUpated',
      //     value: cachedFoods.last.lastUpdated,
      //   )
      // ]
    ]).asBroadcastStream()
      ..listen((foods) {
        for (final food in foods) {
          foodHiveLocalSource.setItem(food);
        }
      });
  }

  @override
  Future<Stream<List<FoodModel>>> subscribeTo(List<WhereClause>? where) async {
    // TODO: implement subscribeToSchedule
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteMeal(String id) {
    // TODO: implement deleteMeal
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FoodModel>>> getMeals() {
    // TODO: implement getMeals
    throw UnimplementedError();
  }

  // @override
  // Stream<List<FoodModel>> streamGetFoods() {
  //   return foodHiveLocalSource.itemsStream;
  // }
}
