import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/surah/data/repositories/surah_repository.dart';
import 'package:quran_app/modules/surah/domain/surah_usecase.dart';

void setupLocatorSurah() {
  // *Repository
  locator
    ..registerLazySingleton(SurahRepositoryImpl.new)
    // *UseCase
    ..registerLazySingleton(() => SurahUseCaseImpl(locator<SurahRepositoryImpl>()));
}
