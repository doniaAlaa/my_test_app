import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/meal_model.dart';

class MealsLocalDataSource {
  Future<List<MealModel>> getMeals() async {
    final String response =
    await rootBundle.loadString('assets/data/meals.json');

    final List data = json.decode(response);

    return data.map((e) => MealModel.fromJson(e)).toList();
  }
}