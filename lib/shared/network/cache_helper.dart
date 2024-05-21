import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global/global.dart';
import '../../model/place/place_model.dart';
import '../../model/review_model/review_model.dart';
import '../../model/review_result/review_result.dart';
import '/resources/constant_maneger.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static late Box<dynamic>? box;

  static initHive() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(ReviewModelAdapter())
      ..registerAdapter(ReviewResultAdapter())
      ..registerAdapter(PlaceModelAdapter());

    // get data from cache
    box = await Hive.openBox('cache');

    // get data from hive
    final favList = box?.get(AppConstant.favPlacesCache);
    final recentList = box?.get(AppConstant.recentPlacesCache);
    final discoveryList = box?.get(AppConstant.discoveryPlaces);

    if (recentList != null) {
      Global.recentPlaces = recentList.cast<PlaceModel>();
    }
    if (discoveryList != null) {
      Global.discoveryPlaces = discoveryList.cast<PlaceModel>();
    }
    if (favList != null) {
      Global.favPlaces = favList.cast<PlaceModel>();
    }
  }

  static dynamic getDateFromHive({
    required String key,
  }) {
    return box?.get(key);
  }

  static Future<void> saveDataToHive({
    required String key,
    required dynamic value,
  }) async {
    await box?.put(key, value);
  }

  // remove data from hive
  static Future<void> removeDataFromHive({
    required String key,
  }) async {
    await box?.delete(key);
  }

  // remove all data from hive
  static Future<void> removeAllDataFromHive() async {
    await box?.clear();
  }

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getDate({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    @required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
