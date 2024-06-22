// ignore_for_file: one_member_abstracts
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/domain/pray.dart';
import 'package:quran_app/modules/home/data/domain/doa_daily.dart';
import 'package:quran_app/modules/home/domain/home_repository.dart';

abstract class HomeUseCase {
  Future<List<Pray>> getTiming(DateTime date, Location location);
  Future<List<DoaDaily>> getDoaDaily();
  Future<Location> getLocation();
  Future<String> getCity(Location location);
}

// * Implementation of the HomeUseCase
class HomeUseCaseImpl implements HomeUseCase {
  HomeUseCaseImpl(this._homeRepository);
  final HomeRepository _homeRepository;

  /// ---------------------------------
  /// Fecth Prayer Time Schedule based on [date] and [location] parameter
  /// ---------------------------------
  @override
  Future<List<Pray>> getTiming(DateTime date, Location location) async {
    final timingList = await _homeRepository.getTiming(date, location); // Get timings using repository
    return timingList;
  }

  /// ---------------------------------
  /// Fecth user [Location]
  /// ---------------------------------
  @override
  Future<Location> getLocation() async {
    return _homeRepository.getLocation();
  }

  /// ---------------------------------
  /// Fecth [DoaDaily] from JSON source
  /// ---------------------------------
  @override
  Future<List<DoaDaily>> getDoaDaily() {
    return _homeRepository.getDoaDaily();
  }

  @override
  Future<String> getCity(Location location) {
    return _homeRepository.getCity(location);
  }
}
