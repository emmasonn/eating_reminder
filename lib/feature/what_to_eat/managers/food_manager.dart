import 'dart:async';

import 'package:flutter/material.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:informat/feature/what_to_eat/managers/food_state.dart';
import 'package:informat/feature/what_to_eat/repository/food_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

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
    updateFoodState(FoodsLoading());
    final result = await _foodRepository.createMeal(obj);
    result.fold((failure) {
      updateFoodState(CreateFoodLoaded(status: false, error: failure.message));
    }, (food) {
      updateFoodState(CreateFoodLoaded(
        status: true,
      ));
    });
  }

  void initializeManager() async {
    isUserExist = await _foodRepository.isLoggedIn;
    profileModel = await _profileRepository.getCachedProfile();
    notifyListeners();
  }

  void subscribeToFoodSchedule(String scheduleId) async {
    final cachedFoods = await _foodRepository.getCachedFoods();

    //update the ui with cached data
    updateFoodState(AllFoodsLoaded(foods: cachedFoods));

    _foodScheduleSubscription = (await _foodRepository.subscribeTo([
      WhereClause.equals(fieldName: 'scheduleId', value: scheduleId),
    ]))
        .listen((foods) {
      updateFoodState(AllFoodsLoaded(foods: foods));
    });
  }

  void updateFoodState(FoodState newState) {
    currentFoodState = newState;
    notifyListeners();
  }

  void unSubscribeToFoodSchedule() {
    _foodScheduleSubscription?.cancel();
  }
}
