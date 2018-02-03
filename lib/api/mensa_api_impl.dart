import 'dart:async';
import 'mensa_api.dart';
import 'package:germanmealbrowser/models/canteen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class MensaApiImpl extends MensaApi {
  static const BASE_URL = "https://openmensa.org/api/v2/";

  var _canteenMap = new Map<int, Canteen>();

  @override
  Future<Map<int, Canteen>> getCanteens() async {
    await _requestCanteens();

    return _canteenMap;
  }

  _requestCanteens() async {
    var response = await http.read("$BASE_URL/canteens");
    var canteens = JSON.decode(response);

    for(var canteen in canteens) {
      _canteenMap[canteen['id']] = new Canteen(canteen['id'], canteen['name']);
    }
  }

}