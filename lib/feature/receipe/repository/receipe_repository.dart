import 'package:dartz/dartz.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/feature/receipe/model/recipe_model.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

abstract class ReceipeRepository {
  Future<Either<Failure, APIRecipeQuery>> getAllReceipe();
  Future<Either<Failure, APIRecipeQuery>> getFirebaseReceipe();
}

class ReceipeRepositoryImpl extends ReceipeRepository {
  @override
  Future<Either<Failure, APIRecipeQuery>> getAllReceipe() {
    // TODO: implement getAllReceipe
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, APIRecipeQuery>> getFirebaseReceipe() {
    // TODO: implement getFirebaseReceipe
    throw UnimplementedError();
  }

}