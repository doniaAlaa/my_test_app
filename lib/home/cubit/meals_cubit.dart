import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/home/data/repo/meals_repo.dart';
import 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final MealsRepo repo;

  MealsCubit(this.repo) : super(MealsInitial());

  Future<void> loadMeals() async {
    emit(MealsLoading());
    await Future.delayed(const Duration(seconds: 2));

    try {
      final meals = await repo.getMeals();
      emit(MealsLoaded(meals));
    } catch (e) {
      emit(MealsError(e.toString()));
    }
  }
}