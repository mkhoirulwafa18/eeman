import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/domain/pray.dart';
import 'package:quran_app/modules/prayer_time/domain/prayer_time_usecase.dart';

part '../state/prayertime_state.dart';

class PrayertimeCubit extends Cubit<PrayertimeState> {
  PrayertimeCubit(this._prayerTimeUseCase) : super(PrayertimeInitial());
  final PrayerTimeUseCase _prayerTimeUseCase;

  Future<void> init(DateTime date, Location location, String city) async {
    emit(PrayertimeLoading());
    final timings = await getTimings(date, location);
    emit(PrayertimeLoaded(city: city, listOfTiming: timings));
  }

  Future<void> updateTimings(List<Pray> newList, String city) async {
    emit(PrayertimeLoaded(listOfTiming: newList, city: city));
  }

  Future<List<Pray>> getTimings(DateTime date, Location location) async {
    final response = await _prayerTimeUseCase.getTimings(date, location);
    return response;
  }
}
