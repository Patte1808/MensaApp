import 'dart:async';

import 'package:germanmealbrowser/models/meal.dart';

abstract class MealsRepository {
  Future<Map<int, Meal>> findAllForCanteenByDate(int canteenId, DateTime date);
}