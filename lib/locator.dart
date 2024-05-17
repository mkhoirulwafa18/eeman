import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/common_locator.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/home/home_locator.dart';
import 'package:quran_app/modules/prayer_time/prayer_time_locator.dart';
import 'package:quran_app/modules/settings/settings_locator.dart';
import 'package:quran_app/modules/surah/surah_locator.dart';
import 'package:quran_app/modules/surah_list/surah_list_locator.dart';

void setupLocator() {
  locator
    ..registerFactoryParam<DatabaseHelper, String, dynamic>((name, _) => DatabaseHelper(databaseName: name))
    ..registerFactory(FlutterSecureStorage.new);
  setupLocatorSurahList();
  setupLocatorHome();
  setupLocatorSurah();
  setupLocatorPrayerTime();
  setupLocatorSettings();
  setupLocatorCommon();
}
