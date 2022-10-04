import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';
import 'package:informat/feature/meal_schedule/managers/meal_schedule_state.dart';
import 'package:informat/feature/meal_schedule/repository/meal_schedule_repository.dart';

class MealScheduleManager extends StateNotifier<MealScheduleState> {
  final MealScheduleRepository _scheduleRepository;

  MealScheduleManager(MealScheduleRepository scheduleRepository)
      : _scheduleRepository = scheduleRepository,
        super(MealScheduleState.initial()) {
    isUserLoggedIn();
  }

  StreamSubscription? _scheduleSubscription;
  bool isUserExist = false;

  void isUserLoggedIn() async {
    isUserExist = await _scheduleRepository.isLoggedIn;
  }

  Future<void> createSchedule(MealScheduleModel mealSchedule) {
    return _scheduleRepository.createMealSchedule(mealSchedule);
  }

  void subscribeToSchedule() async {
    final cachedSchedules = await _scheduleRepository.getCachedMealSchedule();

    //update the ui with cached data
    updateMealScheduleUi(cachedSchedules);

    if (isUserExist) {
      _scheduleSubscription =
          (await _scheduleRepository.subscribeTo([])).listen((mealSchedules) {
        updateMealScheduleUi(mealSchedules);
      });
    }
  }

  void updateMealScheduleUi(List<MealScheduleModel> mealSchedules) {
    state = MealScheduleLoaded(
      status: true,
      mealSchedules: mealSchedules,
    );
  }

  void unSubscribeStream() {
    _scheduleSubscription?.cancel();
  }
}
