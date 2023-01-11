import 'package:informat/feature/what_to_eat/domain/food_model.dart';

class FoodState {
  const FoodState();
  factory FoodState.initial() => const FoodState();
}

class FoodsLoading extends FoodState {}

class AllFoodsLoaded extends FoodState {
  final List<FoodModel>? foods;
  final String? error;
  AllFoodsLoaded({this.foods, this.error});
}

class CreateFoodLoaded extends FoodState {
  final bool status;
  final String? error;
  CreateFoodLoaded({
    required this.status,
     this.error,
  });
}
