import 'package:flutter/material.dart';
import 'package:informat/feature/what_to_eat/repository/food_repository.dart';

class FoodManager extends ChangeNotifier {
  FoodManager(
    FoodRepository foodRepository,
  )   : _foodRepository = foodRepository,
        super();

  final FoodRepository _foodRepository;
  bool isUserExist = false;

  void isUserLoggedIn() async {
    isUserExist = await _foodRepository.isLoggedIn;
  }

}
