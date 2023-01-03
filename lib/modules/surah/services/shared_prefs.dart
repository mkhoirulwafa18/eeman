import 'package:shared_preferences/shared_preferences.dart';

class SurahStorage {
  static Future<dynamic> setInt(String key, int x) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, x);
  }

  static Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<void> setLastReadAyat(int index) async {
    await setInt('last_read_ayat', index);
  }

  static Future<void> setLastReadSurah(int index) async {
    await setInt('last_read_surah', index);
  }
}
