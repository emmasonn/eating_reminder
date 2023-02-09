import 'dart:async';
import 'package:flutter/material.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:informat/feature/what_to_eat/managers/food_state.dart';
import 'package:informat/feature/what_to_eat/repository/new_food_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:nb_utils/nb_utils.dart';

class FoodManager extends ChangeNotifier {
  FoodManager(
    FoodRepository foodRepository,
    ProfileRepository profileRepository,
  )   : _foodRepository = foodRepository,
        _profileRepository = profileRepository,
        super() {
    _firebaseAuth.userChanges().listen((firebaseUser) {
      initializeManager();
    });
  }

  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  final FoodRepository _foodRepository;
  final ProfileRepository _profileRepository;
  bool isUserExist = false;
  ProfileModel? profileModel;

  //Food State
  FoodState currentFoodState = FoodState.initial();

  // //foodschedule subscription
  // StreamSubscription? _foodScheduleSubscription;
  void createFood(FoodModel obj) async {
    // unSubscribeToFoodSchedule();
    updateFoodState(FoodsLoading());

    final result = await _foodRepository.createFood(obj);

    result.fold((failure) {
      updateFoodState(
        CreateFoodLoaded(status: false, error: failure.message),
      );
    }, (food) {
      updateFoodState(CreateFoodLoaded(
        status: true,
      ));
    });
  }

  void initializeManager() async {
    profileModel = await _profileRepository.getCachedProfile();
    isUserExist =
        profileModel == null ? false : await _foodRepository.isLoggedIn;
    notifyListeners();
  }

  void subscribeToFoodsSchedule(String scheduleId) async {
    _foodRepository.subscribeToSchedule(scheduleId);
  }

  Stream<Map<String, List<FoodModel>>> watchSpecificFoods(String scheduleId) =>
      _foodRepository
          .watchSpecificFoods(scheduleId)
          .map((foods) => mapFoods(scheduleId, foods));

  // Future<Map<String, List<FoodModel>>> getFoods(String scheduleId) async {
  //   final cachedFoods = (await _foodRepository.getCachedFoods())
  //       .where((food) => food.scheduleId == scheduleId)
  //       .toList();
  //   return cachedFoods.mapFoodsToDay();
  // }

  // Stream<Map<String, List<FoodModel>>> foodsStream(String scheduleId) {
  //   final foodsStream = _foodRepository.streamGetFoods();
  //   return foodsStream.map((foods) => mapFoods(scheduleId, foods));
  // }

  Map<String, List<FoodModel>> mapFoods(
      String scheduleId, List<FoodModel> foods) {
    final filteredFoods =
        foods.where((food) => food.scheduleId == scheduleId).toList();
    return filteredFoods.mapFoodsToDay();
  }

  void updateFoodState(FoodState newState){
    currentFoodState = newState;
    notifyListeners();
  }

  // void unSubscribeToFoodSchedule() {
  //   _foodScheduleSubscription?.cancel();
  // }
}
