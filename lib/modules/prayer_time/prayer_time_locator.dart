import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/prayer_time/data/repositories/prayer_time_repository_impl.dart';
import 'package:quran_app/modules/prayer_time/domain/prayer_time_usecase.dart';

void setupLocatorPrayerTime() {
  // *Repository
  locator
    ..registerLazySingleton(PrayerTimeRepositoryImpl.new)
    // *UseCase
    ..registerLazySingleton(() => PrayerTimeUseCaseImpl(locator<PrayerTimeRepositoryImpl>()));
}
