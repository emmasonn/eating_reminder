import 'package:get_it/get_it.dart';
import 'package:informat/feature/what_to_eat/managers/food_manager.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => FoodManager());
  
}
