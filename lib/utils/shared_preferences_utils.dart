import 'dart:async';
import 'dart:convert';

import 'package:germanmealbrowser/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
TODO: convert to singleton
 */
class SharedPreferencesUtils {

  SharedPreferences prefs;

  Future<Map<int, bool>> getAllCanteenFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<int, bool> favoriteMap = JSON.decode(prefs.getString(CANTEEN_FAVORITE_PREFS));

    return new Future.value(favoriteMap);
  }

  Future<Null> setCanteenFavorite(int canteenId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<int, bool> favoriteMap = JSON.decode(prefs.getString(CANTEEN_FAVORITE_PREFS));

    favoriteMap.putIfAbsent(canteenId, () => true);

    prefs.setString(CANTEEN_FAVORITE_PREFS, JSON.encode(favoriteMap));
  }

  Future<Null> removeCanteenFavorite(int canteenId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<int, bool> favoriteMap = JSON.decode(prefs.getString(CANTEEN_FAVORITE_PREFS));

    if(favoriteMap.containsKey(canteenId)) {
      favoriteMap.remove(canteenId);
    }

    prefs.setString(CANTEEN_FAVORITE_PREFS, JSON.encode(favoriteMap));
  }
}