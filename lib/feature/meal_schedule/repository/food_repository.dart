import 'package:dartz/dartz.dart';
import 'package:informat/core/api_service/service_runner.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

abstract class FoodRepository {
  Future<Either<Failure, List<FoodModel>>> getMeals();
  Future<Either<Failure, FoodModel?>> createMeal(FoodModel obj);
  Future<Either<Failure, bool>> deleteMeal(String id);
  Stream<List<FoodModel>> subscribeTo(List<WhereClause>? where);
}

class FoodRepositoryImpl extends FoodRepository {
  final NetworkInfo networkInfo;
  final FirebaseSource<FoodModel> foodFirebaseSource;
  final HiveLocalSource<FoodModel> foodHiveLocalSource;

  FoodRepositoryImpl({
    required this.networkInfo,
    required this.foodFirebaseSource,
    required this.foodHiveLocalSource,
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
  Future<Either<Failure, bool>> deleteMeal(String id) {
    // TODO: implement deleteMeal
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<FoodModel>>> getMeals() {
    // TODO: implement getMeals
    throw UnimplementedError();
  }
  
  @override
  Stream<List<FoodModel>> subscribeTo(List<WhereClause>? where) {
    // TODO: implement subscribeTo
    throw UnimplementedError();
  }
}
