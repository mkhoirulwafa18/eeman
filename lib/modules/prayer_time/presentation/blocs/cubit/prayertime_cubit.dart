import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/prayer_time/domain/prayer_time_usecase.dart';
import 'package:quran_app/modules/prayer_time/presentation/blocs/state/prayertime_state.dart';

/// Cubit to manage prayer time data and interactions
class PrayerTimeCubit extends Cubit<PrayerTimeState> {
  /// Constructor initializes the cubit with the [PrayerTimeUseCase] instance
  PrayerTimeCubit(this._prayerTimeUseCase) : super(PrayerTimeInitial());

  /// Use case instance for prayer time data retrieval
  final PrayerTimeUseCase _prayerTimeUseCase;

  /// Initializes the cubit by retrieving prayer time data for the given date
  Future<void> init(DateTime date, Location? currentLocation, String? currentCity) async {
    emit(PrayerTimeLoading());
    try {
      final location = currentLocation ?? await _prayerTimeUseCase.getLocation();
      final city = currentCity ?? await _prayerTimeUseCase.getCity(location);
      final timing = await getTiming(date, location);

      if (timing.isEmpty) {
        emit(const PrayerTimeError('No Prayer Time Fetched'));
      } else {
        emit(
          PrayerTimeLoaded(
            currentLocation: location,
            currentLocationInCity: city,
            currentSelectedTiming: timing,
          ),
        );
      }
    } catch (error) {
      emit(const PrayerTimeError('An error occurred while fetching prayer times'));
    }
  }

  /// Retrieves prayer timings for the given date and location
  Future<List<Pray>> getTiming(DateTime date, Location location) async {
    final res = await _prayerTimeUseCase.getTiming(date, location);
    return res;
  }

  /// Updates the prayer timings and emits the new state
  Future<void> updateTimings(List<Pray> newList, String city) async {
    emit(
      PrayerTimeLoaded(
        currentLocation: locator<LocationService>().currentLocation ??
            Location(latitude: 0, longitude: 0, timestamp: DateTime.now()),
        currentLocationInCity: city,
        currentSelectedTiming: newList,
      ),
    );
  }
}
