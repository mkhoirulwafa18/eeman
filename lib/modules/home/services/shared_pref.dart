import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:quran_app/modules/home/models/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const String randomSurah = 'noRandomSurah';
  static const String randomAyat = 'noRandomAyat';
  static Future<dynamic> setInt(String key, int x) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, x);
  }

  static Future<dynamic> setString(String key, String x) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, x);
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<dynamic> setAyatOfTheDay(List<Quran> data) async {
    debugPrint('SET AYAT OF THE DAY IN SHARED PREF');
    final surahNo = Random().nextInt(145);
    final maxAyat = data.isNotEmpty ? data[surahNo].numberOfAyah : 0;
    final ayatNo = Random().nextInt(maxAyat! + 1);
    await setInt(randomSurah, surahNo);
    await setInt(randomAyat, ayatNo);
    debugPrint('SELESAI SET AYAT OF THE DAY IN SHARED PREF');
  }

  static Future<List<int>> getAyatOfTheDay() async {
    final a = await getInt(randomSurah);
    final b = await getInt(randomAyat);
    return [a, b];
  }
}
