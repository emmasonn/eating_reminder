import 'package:informat/core/local_storage/sqlite_database_helper.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sqlbrite/sqlbrite.dart';

class FoodLocalSource {
  final SqliteDatabaseHelper sqlfliteDb;
  FoodLocalSource(this.sqlfliteDb);

  List<FoodModel> dynamicToFoods(List<Map<String, dynamic>> foodsList) {
    final foods = <FoodModel>[];
    for (final foodMap in foodsList) {
      foods.add(FoodModel.fromJson(foodMap));
    }
    return foods;
  }

  //Future of all the foods in the db.
  Future<List<FoodModel>> getAllFoods() async {
    final db = await sqlfliteDb.streamDatabase;
    final foodsList = await db.query(SqliteDatabaseHelper.foodTable);
    return dynamicToFoods(foodsList);
  }

  //find food by scheduleId
  Future<List<FoodModel>> findFoodByScheduleId(String scheduleId) async {
    final db = await sqlfliteDb.streamDatabase;
    final foodsList = await db.query(SqliteDatabaseHelper.foodTable,
        where: 'scheduleId = ?', whereArgs: [scheduleId]);
    return dynamicToFoods(foodsList);
  }

  //Stream of all the foods in the db.
  Stream<List<FoodModel>> watchAllFoods() async* {
    final db = await sqlfliteDb.streamDatabase;
    yield* db
        .createQuery(SqliteDatabaseHelper.foodTable)
        .mapToList((row) => FoodModel.fromJson(row));
  }

  //find food using a scheduleId
  Stream<List<FoodModel>> watchFoodByScheduleId(String scheduleId) async* {
    final db = await sqlfliteDb.streamDatabase;
    yield* db.createQuery(SqliteDatabaseHelper.foodTable,
        where: 'scheduleId = ?',
        whereArgs: [scheduleId]).mapToList((row) => FoodModel.fromJson(row));
  }

  //find food by id
  Future<FoodModel> findFoodById(String foodId) async {
    final db = await sqlfliteDb.streamDatabase;
    final foodsList = await db.query(SqliteDatabaseHelper.foodTable,
        where: '${SqliteDatabaseHelper.foodId} = $foodId');
    return dynamicToFoods(foodsList).first;
  }

  //insert a single food into table
  Future<bool> insert(FoodModel food) async {
    final db = await sqlfliteDb.streamDatabase;
    try {
      db.insert(
        SqliteDatabaseHelper.foodTable,
        food.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      log(e);
      return false;
    }
  }

  //insert all items
  Future<bool> insertAll(List<FoodModel> foods) async {
    final db = await sqlfliteDb.streamDatabase;
    try {
      Batch batch = db.batch();
      for (var food in foods) {
        batch.insert(
          SqliteDatabaseHelper.foodTable,
          food.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      batch.commit(noResult: true);
      return false;
    } catch (e) {
      return false;
    }
  }

  //delete a food
  Future<bool> deleteFood(FoodModel food) async {
    final db = await sqlfliteDb.streamDatabase;
    try {
      db.delete(
        SqliteDatabaseHelper.foodTable,
        where: 'id = ?',
        whereArgs: [food.id],
      );
      return true;
    } catch (e) {
      log(e);
      return false;
    }
  }
}
