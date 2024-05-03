import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/domain/pray.dart';
import 'package:quran_app/modules/home/data/domain/doa_daily.dart';
import 'package:quran_app/modules/home/domain/home_usecase.dart';
import 'package:quran_app/modules/home/presentation/blocs/state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeUseCase) : super(HomeInitial());
  final HomeUseCase _homeUseCase;

  Future<void> init(DateTime date) async {
    emit(HomeLoading());
    final location = await _homeUseCase.getLocation();
    final city = await _homeUseCase.getCity(location);
    final timing = await getTiming(date, location);
    final tomorrowTiming = await getTiming(date.add(const Duration(days: 1)), location);
    final doaDaily = await getDoaDaily();
    timing.isEmpty
        ? emit(const HomeError('No Prayer Time Fetched'))
        : emit(
            HomeLoaded(
              currentLocation: location,
              currentLocationInCity: city,
              todayTiming: timing,
              tomorrowTiming: tomorrowTiming,
              doaDaily: doaDaily,
            ),
          );
  }

  Future<List<Pray>> getTiming(DateTime date, Location location) async {
    final res = await _homeUseCase.getTiming(date, location);
    return res;
  }

  Future<List<DoaDaily>> getDoaDaily() async {
    final res = await _homeUseCase.getDoaDaily();
    return res;
  }
}
