import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/common/local_data/last_read_ayah_local_data.dart';
import 'package:quran_app/common/services/local_data_service.dart';

void setupLocatorCommon() {
  // *LocalDataService
  locator
    ..registerLazySingleton(() => LocalDataServiceImpl(storage: locator<FlutterSecureStorage>()))
    // *LocalData
    ..registerLazySingleton(LastReadAyahLocalData.new);
}
