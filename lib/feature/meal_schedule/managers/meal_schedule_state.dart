import 'package:informat/core/failure/failure.dart';
import 'package:informat/feature/meal_schedule/domain/meal_schedule_model.dart';

class MealScheduleState {
  const MealScheduleState();
  factory MealScheduleState.initial() => const MealScheduleState();
}

class ScheduleLoading extends MealScheduleState {}

class AllSchedulesLoaded extends MealScheduleState {
  final List<MealScheduleModel>? mealSchedules;
  final String? error;
  AllSchedulesLoaded({this.mealSchedules, this.error});
}

class CreateScheduleLoaded extends MealScheduleState {
  final bool status;
  final String? error;
  CreateScheduleLoaded({required this.status, this.error});
}

class CreateScheduleError extends MealScheduleState {
  final Failure failure;
  CreateScheduleError(this.failure);
}

// class CheckAuthLoaded extends MealScheduleState {
//   final bool status;
//   const CheckAuthLoaded(this.status);
// }
