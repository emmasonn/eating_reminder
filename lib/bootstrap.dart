import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_state.dart';
import 'package:informat/feature/profile/manager/profile_manager.dart';
import 'package:informat/feature/profile/manager/profile_state.dart';
import 'package:informat/feature/what_to_eat/managers/food_manager.dart';
import 'package:informat/injection_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:informat/injection_container.dart' as di;



late FoodManager foodManager;

late StateNotifierProvider<MealScheduleManager, MealScheduleState>
    mealScheduleProvider;

late StateNotifierProvider<ProfileManager, ProfileState> profileProvider;

Future<void> bootStrap() async {

  //Initialize Hive Database
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  //initialize di(service locator)
   await di.init();
  //initializing foodManager instance variable
  foodManager = sl<FoodManager>();

  //mealScheduleProvider
  mealScheduleProvider =
      StateNotifierProvider<MealScheduleManager, MealScheduleState>(
          (ref) => sl<MealScheduleManager>());

  //profileProvider
  profileProvider = StateNotifierProvider((ref) => sl<ProfileManager>());
  
}
