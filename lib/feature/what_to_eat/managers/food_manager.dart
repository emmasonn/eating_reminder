import 'package:flutter/material.dart';
import 'package:informat/feature/profile/domain/profile_model.dart';
import 'package:informat/feature/profile/repository/profile_repository.dart';
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

  void initializeManager() async {
    isUserExist = await _foodRepository.isLoggedIn;
    profileModel = await _profileRepository.getCachedProfile();
    notifyListeners();
  }
}
