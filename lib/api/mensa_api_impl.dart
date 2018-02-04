import 'dart:async';
import 'package:germanmealbrowser/models/meal.dart';
import 'package:germanmealbrowser/utils/string_utils.dart';

import 'mensa_api.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MensaApiImpl extends MensaApi {
  static const BASE_URL = "https://openmensa.org/api/v2";

  var _canteenMap = new Map<int, Canteen>();
  var _mealMap = new Map<int, Meal>();

  @override
  Future<Map<int, Canteen>> getCanteens() async {
    await _requestCanteens();

    return _canteenMap;
  }

  @override
  Future<Map<int, Meal>> getMealsForCanteenByDate(int canteenId, DateTime date) async {
    await _requestMealsForCanteenById(canteenId, date);

    return _mealMap;
  }

  _requestCanteens() async {
    var response = await http.read("$BASE_URL/canteens");
    var canteens = JSON.decode(response);

    for(var canteen in canteens) {
      _canteenMap[canteen['id']] = new Canteen(canteen['id'], canteen['name'], canteen['city']);
    }
  }

  _requestMealsForCanteenById(int id, DateTime date) async {
    var formattedDate = StringUtils.formatDateToApiFormat(date);
    var response = await http.read("$BASE_URL/canteens/$id/days/$formattedDate/meals");
    var meals = JSON.decode(response);

    for(var meal in meals) {
      _mealMap[meal['id']] = new Meal(meal['id'], meal['name'], meal['prices'], meal['category'], meal['notes']);
    }
  }
}