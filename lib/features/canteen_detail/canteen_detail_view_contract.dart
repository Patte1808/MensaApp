import 'package:germanmealbrowser/models/meal.dart';

abstract class CanteenDetailViewContract {
  void onLoadMealsComplete(List<Meal> meals);

  void onLoadMealsError();
}