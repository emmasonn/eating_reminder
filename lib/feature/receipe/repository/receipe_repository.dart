import 'package:dartz/dartz.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

abstract class ReceipeRepository {
  Future<Either<Failure, FoodModel>> getAllReceipe();
  Future<Either<Failure, FoodModel>> getFirebaseReceipe();
}

class ReceipeRepositoryImpl extends ReceipeRepository {
  @override
  Future<Either<Failure, FoodModel>> getAllReceipe() {
    // TODO: implement getAllReceipe
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FoodModel>> getFirebaseReceipe() {
    // TODO: implement getFirebaseReceipe
    throw UnimplementedError();
  }

}