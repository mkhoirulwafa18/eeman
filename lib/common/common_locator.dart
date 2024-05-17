import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/global_variable.dart';

void setupLocatorCommon() {
  // *LocalDataService
  locator
    ..registerLazySingleton(() => LocalDataServiceImpl(storage: locator<FlutterSecureStorage>()))
    // *LocalData
    ..registerLazySingleton(LastReadAyahLocalData.new)
    // *LocalData
    ..registerLazySingleton(AlarmListLocalData.new)
    // *LocalData
    ..registerLazySingleton(PrayerTimeFilterListLocalData.new)
    // *LocalData
    ..registerLazySingleton(PreferencesLocalData.new)
    // *LocationService
    ..registerLazySingleton(LocationService.new)
    // *LocationService
    ..registerLazySingleton(HttpNetworkService.new);
}
