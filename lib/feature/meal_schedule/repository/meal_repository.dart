import 'package:dartz/dartz.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/data_model.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';

abstract class MealRepository<T extends DataModel> {
  Future<Either<Failure, List<T>>> getMeals();
  Future<Either<Failure, T>> createMeal(T obj);
  Future<Either<Failure, bool>> deleteMeal(String id);
}

class MealRepositoryImpl<T extends DataModel> extends MealRepository<T> {
  final FirebaseSource<T> firebaseSource;
  final HiveLocalSource<T> hiveLocalSource;

  MealRepositoryImpl({
    required this.firebaseSource,
    required this.hiveLocalSource,
  });

  @override
  Future<Either<Failure, T>> createMeal(T obj) {
    // TODO: implement createMeal
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteMeal(String id) {
    // TODO: implement deleteMeal
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<T>>> getMeals() {
    // TODO: implement getMeals
    throw UnimplementedError();
  }
}
