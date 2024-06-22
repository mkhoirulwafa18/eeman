import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/home/data/repositories/home_repository_impl.dart';
import 'package:quran_app/modules/home/domain/home_usecase.dart';

void setupLocatorHome() {
  // *Repository
  locator
    ..registerLazySingleton(HomeRepositoryImpl.new)
    // *UseCase
    ..registerLazySingleton(() => HomeUseCaseImpl(locator<HomeRepositoryImpl>()));
}
