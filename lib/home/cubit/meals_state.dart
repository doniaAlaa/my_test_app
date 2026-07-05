import 'package:test_app/home/data/models/meal_model.dart';

abstract class MealsState {}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsLoaded extends MealsState {
  final List<MealModel> meals;

  MealsLoaded(this.meals);
}

class MealsError extends MealsState {
  final String message;

  MealsError(this.message);
}