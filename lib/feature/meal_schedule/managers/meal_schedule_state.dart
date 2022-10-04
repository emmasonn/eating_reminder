import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';

class MealScheduleState {
  const MealScheduleState();
  factory MealScheduleState.initial() => const MealScheduleState();
}

class MealScheduleLoaded extends MealScheduleState {
  final bool status;
  final List<MealScheduleModel> mealSchedules;
  final String? error;

  const MealScheduleLoaded({
    required this.status,
    this.mealSchedules = const [],
    this.error,
  }) : super();

  // MealScheduleState copyWith({
  //   required bool status,
  //   List<MealScheduleModel>? mealSchedules,
  //   String? error,
  // }) {
  //   return MealScheduleLoaded(
  //     status: status,
  //     mealSchedules: mealSchedules ?? this.mealSchedules,
  //     error: error ?? error,
  //   );
  // }
}

class CheckAuthLoaded extends MealScheduleState {
  final bool status;
  const CheckAuthLoaded(this.status);
}
