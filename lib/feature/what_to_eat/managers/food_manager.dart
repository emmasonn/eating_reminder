import 'package:flutter/material.dart';
import 'package:informat/feature/what_to_eat/repository/food_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FoodManager extends ChangeNotifier {
  FoodManager(
    FoodRepository foodRepository,
  )   : _foodRepository = foodRepository,
        super() {
    _firebaseAuth.userChanges().listen((firebaseUser) {
      if (firebaseUser != null) {
        updateStatus(status: true);
      } else {
        updateStatus(status: false);
      }
      notifyListeners();
    });
  }

  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  final FoodRepository _foodRepository;
  
  bool isUserExist = false;

  void updateStatus({bool? status}) async {
    if (status != null) {
      isUserExist = status;
    }
    isUserExist = await _foodRepository.isLoggedIn;
  }
}
