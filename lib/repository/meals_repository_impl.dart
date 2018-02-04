import 'dart:async';
import 'package:germanmealbrowser/models/meal.dart';
import 'package:germanmealbrowser/repository/meals_repository.dart';

import 'package:germanmealbrowser/api/mensa_api.dart';

class MealsRepositoryImpl extends MealsRepository {

  MensaApi api;
  Map<String, Map<int, Meal>> _cache = new Map();
  bool isDirty = true;

  MealsRepositoryImpl(this.api);

  @override
  Future<Map<int, Meal>> findAllForCanteenByDate(int canteenId, DateTime date) async {

    String cacheKey = "${canteenId}/${date.year}/${date.month}/${date.day}";

    if(!isDirty && _cache.containsKey(cacheKey)) {
      return new Future.value(_cache[cacheKey]);
    }

    Map<int, Meal> result = new Map();

    await api.getMealsForCanteenByDate(canteenId, date).then((meals) {
      isDirty = false;
      result = meals;
    });

    _cache[cacheKey] = result;

    return new Future.value(result);
  }
}