import 'dart:math';

import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/surah_list/models/quran.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  Future<void> setStorage<T>(String key, T x) async {
    final prefs = await SharedPreferences.getInstance();
    if (x is String) {
      await prefs.setString(key, x);
    }
    if (x is int) {
      await prefs.setInt(key, x);
    }
    if (x is bool) {
      await prefs.setBool(key, x);
    }
    if (x is List<String>) {
      await prefs.setStringList(key, x);
    }
  }
}

class AOTD {
  static void setAyatOfTheDay(List<Quran> data) {
    final surahNo = Random().nextInt(145);
    AppStorage().setStorage(Constants().randomSurah, surahNo);
    final maxAyat = data.isNotEmpty ? data[surahNo].numberOfAyah : 0;
    AppStorage()
        .setStorage(Constants().randomAyat, Random().nextInt(maxAyat! + 1));
  }

  static void setLastHitAotd() {
    final surahNo = Random().nextInt(145);
    AppStorage().setStorage(Constants().lastHitAotd, surahNo);
  }
}
