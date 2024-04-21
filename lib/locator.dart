import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/services/database_helper.dart';
import 'package:quran_app/modules/surah/locator.dart';
import 'package:quran_app/modules/surah_list/locator.dart';

void setupLocator() {
  locator.registerFactoryParam<DatabaseHelper, String, dynamic>((name, _) => DatabaseHelper(databaseName: name));
  setupLocatorSurahList();
  setupLocatorSurah();
}
