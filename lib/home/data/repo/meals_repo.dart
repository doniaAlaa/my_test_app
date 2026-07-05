import 'package:test_app/home/data/data_source/meals_data_source.dart';

import '../models/meal_model.dart';

class MealsRepo {
  final MealsLocalDataSource local;

  MealsRepo(this.local);

  Future<List<MealModel>> getMeals() async {
    return await local.getMeals();
  }
}