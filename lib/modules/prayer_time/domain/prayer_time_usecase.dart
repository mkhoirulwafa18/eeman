// ignore_for_file: one_member_abstracts
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/domain/pray.dart';
import 'package:quran_app/modules/prayer_time/domain/prayer_time_repository.dart';

abstract class PrayerTimeUseCase {
  Future<List<Pray>> getTimings(DateTime date, Location location);
}

// * Implementation of the PrayerTimeUseCase
class PrayerTimeUseCaseImpl implements PrayerTimeUseCase {
  PrayerTimeUseCaseImpl(this._prayerTimeRepository);
  final PrayerTimeRepository _prayerTimeRepository;

  /// Fecth Prayer Time Schedule based on [date] and [location] parameter
  @override
  Future<List<Pray>> getTimings(DateTime date, Location location) async {
    final timingList = await _prayerTimeRepository.getTimings(date, location); // Get timings using repository
    return timingList;
  }
}
