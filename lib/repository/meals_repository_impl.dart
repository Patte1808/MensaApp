import 'dart:async';
import 'package:germanmealbrowser/models/meal.dart';
import 'package:germanmealbrowser/repository/meals_repository.dart';

import 'package:germanmealbrowser/api/mensa_api.dart';

class MealsRepositoryImpl extends MealsRepository {

  MensaApi api;

  MealsRepositoryImpl(this.api);

  @override
  Future<Map<int, Meal>> findAllForCanteenByDate(int canteenId, DateTime date) {
    return api.getMealsForCanteenByDate(canteenId, date).then((meals) {
      return meals;
    });
  }
}