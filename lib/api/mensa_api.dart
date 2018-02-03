import 'package:germanmealbrowser/models/canteen.dart';
import 'dart:async';

import 'package:germanmealbrowser/models/meal.dart';

abstract class MensaApi {
  Future<Map<int, Canteen>> getCanteens();
  Future<Map<int, Meal>> getMealsForCanteenByDate(int canteenId, DateTime date);
}