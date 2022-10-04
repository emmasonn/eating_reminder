import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_source.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/local_storage/hive_local_source.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

abstract class FoodRepository {
  Future<bool> get isLoggedIn;
  Future<List<FoodModel>> getCachedFoods();
  Future<Stream<List<FoodModel>>> subscribeTo(List<WhereClause>? where);
}

class FoodRepositoryImpl extends FoodRepository {
  final NetworkInfo networkInfo;
  final FirebaseSource<FoodModel> firebaseSource;
  final HiveLocalSource<FoodModel> hiveLocalSource;
  final CoreFirebaseAuth coreFirebaseAuth;
  FoodRepositoryImpl({
    required this.networkInfo,
    required this.firebaseSource,
    required this.hiveLocalSource,
    required this.coreFirebaseAuth,
  });

  @override
  Future<bool> get isLoggedIn async =>
      await coreFirebaseAuth.currentUser != null;

  @override
  Future<List<FoodModel>> getCachedFoods() {
    // TODO: implement getCachedFoods
    throw UnimplementedError();
  }

  @override
  Future<Stream<List<FoodModel>>> subscribeTo(List<WhereClause>? where) {
    // TODO: implement subscribeTo
    throw UnimplementedError();
  }
}
