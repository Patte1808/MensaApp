import 'dart:async';
import 'dart:convert';

import 'package:germanmealbrowser/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
TODO: convert to singleton
 */
class SharedPreferencesUtils {

  SharedPreferences prefs;

  Future<List<String>> getAllCanteenFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favorites = prefs.getStringList(CANTEEN_FAVORITE_PREFS);

    if(favorites == null)
      favorites = [];

    return new Future.value(favorites);
  }

  Future<Null> setCanteenFavorite(int canteenId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(CANTEEN_FAVORITE_PREFS);

    if(favorites == null)
      favorites = [];

    if(!favorites.contains(canteenId.toString()))
      favorites.add(canteenId.toString());

    prefs.setStringList(CANTEEN_FAVORITE_PREFS, favorites);
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