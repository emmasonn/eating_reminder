import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:informat/feature/Auth/manager/auth_manager.dart';
import 'package:informat/feature/Auth/manager/auth_state.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_manager.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_state.dart';
import 'package:informat/feature/profile/manager/profile_manager.dart';
import 'package:informat/feature/profile/manager/profile_state.dart';
import 'package:informat/feature/settings/manager/settings_manager.dart';
import 'package:informat/feature/settings/manager/theme_manager.dart';
import 'package:informat/feature/settings/model/settings_model.dart';
import 'package:informat/feature/what_to_eat/managers/food_manager.dart';
import 'package:informat/injection_container.dart';
import 'package:path_provider/path_provider.dart';
import 'package:informat/injection_container.dart' as di;

//! Making all the stateNotifer Provider Global
late FoodManager foodManager;

late ChangeNotifierProvider<FoodManager> foodProvider;

late AutoDisposeStateNotifierProvider<AuthManager, AuthState> authProvider;

late StateNotifierProvider<MealScheduleManager, MealScheduleState>
    mealScheduleProvider;

late AutoDisposeStateNotifierProvider<ProfileManager, ProfileState>
    profileProvider;

late StateNotifierProvider<SettingsManager, SettingsModel> settingsProvider;

late StateNotifierProvider<ThemeManager, String> themeStateProvider;

//! This function initializes some external packages
Future<void> bootStrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize FirebaseApp
  await Firebase.initializeApp();

  //Initialize Hive Database
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  //initialize di(service locator)
  await di.init();

  //foodManager instance variable
  foodManager = sl<FoodManager>();

  //foodProvider
  foodProvider = ChangeNotifierProvider((ref) => foodManager);

  //themeProvider
  themeStateProvider = StateNotifierProvider((ref) => ThemeManager());

  //settingsProvider
  settingsProvider = StateNotifierProvider<SettingsManager, SettingsModel>(
      (ref) => SettingsManager());

  //authProvider
  authProvider = StateNotifierProvider.autoDispose<AuthManager, AuthState>(
      (ref) => sl<AuthManager>());

  //mealScheduleProvider
  mealScheduleProvider =
      StateNotifierProvider<MealScheduleManager, MealScheduleState>(
          (ref) => sl<MealScheduleManager>());

  //profileProvider
  profileProvider =
      StateNotifierProvider.autoDispose<ProfileManager, ProfileState>(
          (ref) => sl<ProfileManager>());
}
