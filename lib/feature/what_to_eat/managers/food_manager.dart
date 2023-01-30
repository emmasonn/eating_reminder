import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:informat/feature/what_to_eat/managers/food_state.dart';
import 'package:informat/feature/what_to_eat/repository/food_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:informat/injection_container.dart';

// final foodStreamProvide = StreamProvider((ref) {
// });

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

  //foodschedule subscription
  StreamSubscription? _foodScheduleSubscription;

  void createFood(FoodModel obj) async {
    unSubscribeToFoodSchedule();

    updateFoodState(FoodsLoading());
    final result = await _foodRepository.createMeal(obj);
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

  Future<Map<String, List<FoodModel>>> getFoods(String scheduleId) async {
    final cachedFoods = (await _foodRepository.getCachedFoods())
        .where((food) => food.scheduleId == scheduleId)
        .toList();
    return cachedFoods.mapFoodsToDay();
  }

  Stream<Map<String, List<FoodModel>>> foodsStream(String scheduleId) {
    final foodsStream = _foodRepository.streamGetFoods();
    return foodsStream.map((foods) => mapFoods(scheduleId, foods));
  }

  void initializeManager() async {
    isUserExist = await _foodRepository.isLoggedIn;
    profileModel = await _profileRepository.getCachedProfile();
    notifyListeners();
  }

  void subscribeToFoodSchedule(String scheduleId) async {
    // final cachedFoods = (await _foodRepository.getCachedFoods())
    //     .where(
    //       (food) => food.scheduleId == scheduleId,
    //     )
    //     .toList();

    //update the ui with cached data
    // updateFoodState(AllFoodsLoaded(foods: cachedFoods));

    //cached
    // log('cached-$cachedFoods');

    _foodScheduleSubscription = (await _foodRepository.subscribeToSchedule([
      WhereClause.equals(fieldName: 'scheduleId', value: scheduleId),
    ]))
        .listen((event) {});
    //     .listen((foods) {
    //   updateFoodState(AllFoodsLoaded(foods: foods));
    // });
  }

  Map<String, List<FoodModel>> mapFoods(
      String scheduleId, List<FoodModel> foods) {
    final filteredFoods =
        foods.where((food) => food.scheduleId == scheduleId).toList();
    return filteredFoods.mapFoodsToDay();
  }

  void updateFoodState(FoodState newState) {
    currentFoodState = newState;
    notifyListeners();
  }

  void unSubscribeToFoodSchedule() {
    _foodScheduleSubscription?.cancel();
  }
}
