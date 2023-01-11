import 'package:dartz/dartz.dart';
import 'package:informat/core/api_service/service_runner.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

abstract class FoodRepository {
  Future<bool> get isLoggedIn;
  Future<List<FoodModel>> getCachedFoods();
  Future<Either<Failure, FoodModel?>> createMeal(FoodModel obj);
  Future<Either<Failure, List<FoodModel>>> getMeals();
  Future<Either<Failure, bool>> deleteMeal(String id);
  Future<Stream<List<FoodModel>>> subscribeTo(List<WhereClause>? where);
  Future<Stream<List<FoodModel>>> subscribeToSchedule(List<WhereClause>? where);
}

class FoodRepositoryImpl extends FoodRepository {
  final NetworkInfo networkInfo;
  final CustomFirebaseSource<FoodModel> foodFirebaseSource;
  final HiveLocalSource<FoodModel> foodHiveLocalSource;
  final CoreFirebaseAuth coreFirebaseAuth;
  FoodRepositoryImpl({
    required this.networkInfo,
    required this.foodFirebaseSource,
    required this.foodHiveLocalSource,
    required this.coreFirebaseAuth,
  });

  @override
  Future<Either<Failure, FoodModel?>> createMeal(FoodModel obj) {
    return ServiceRunner<FoodModel?>(
      networkInfo: networkInfo,
      onCacheTask: (food) async {
        if (food != null) {
          foodHiveLocalSource.setItem(obj);
        }
        return true;
      },
    ).runNetworkTask(
      () async {
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
      if (cachedFoods.isNotEmpty) ...[
        WhereClause.greaterThan(
          fieldName: 'lastUpated',
          value: cachedFoods.last.lastUpdated!,
        )
      ]
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
}
