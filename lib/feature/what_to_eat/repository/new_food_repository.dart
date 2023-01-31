import 'package:dartz/dartz.dart';
import 'package:informat/core/api_service/service_runner.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:informat/feature/what_to_eat/source/food_local_source.dart';
import 'package:informat/feature/what_to_eat/source/food_remote_source.dart';

class FoodRepository {
  final NetworkInfo networkInfo;
  final FoodRemoteSource foodRemoteSource;
  final FoodLocalSource foodLocalSource;
  final CoreFirebaseAuth coreFirebaseAuth;

  FoodRepository({
    required this.networkInfo,
    required this.foodRemoteSource,
    required this.foodLocalSource,
    required this.coreFirebaseAuth,
  });

  Future<bool> get isLoggedIn async =>
      await coreFirebaseAuth.currentUser != null;

  Future<Either<Failure, bool>> createFood(FoodModel food) async {
    return ServiceRunner<bool>(networkInfo: networkInfo)
        .runNetworkTask(() => foodRemoteSource.createItem(food));
  }

  Future<List<FoodModel>> findFoodsByScheduleId(String scheduleId) =>
      foodLocalSource.findFoodByScheduleId(scheduleId);

  Future<Either<Failure, bool>> deleteFood(FoodModel foodModel) {
    return ServiceRunner<bool>(
      networkInfo: networkInfo,
    ).runNetworkTask(
      () async {
        //delete from firebase firestore
        final result = await foodLocalSource.deleteFood(foodModel);
        if (result) {
          //delete sqflite local database
          await foodLocalSource.deleteFood(foodModel);
        }
        return true;
      },
    );
  }

  Stream<List<FoodModel>> watchSpecificFoods(String scheduleId) {
    return foodLocalSource.watchFoodByScheduleId(scheduleId);
  }

  void subscribeToSchedule(String scheduleId) async {
    final cachedFoods = await findFoodsByScheduleId(scheduleId);

    foodRemoteSource.subscribeTo([
      //fetch the foods with this scheduleId
      WhereClause.equals(
        fieldName: 'scheduleId',
        value: scheduleId,
      ),
      if (cachedFoods.isNotEmpty) ...[
        WhereClause.greaterThan(
          fieldName: 'lastUpdated',
          value: cachedFoods.last.lastUpdated.toIso8601String(),
        )
      ]
    ]).listen((foods) {
      final List<FoodModel> foodList = [];
      for (final food in foods) {
        foodList.add(food);
      }
      foodLocalSource.insertAll(foods);
    });
  }
}
