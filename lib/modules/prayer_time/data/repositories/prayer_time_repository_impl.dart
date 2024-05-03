import 'package:adhan/adhan.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/modules/prayer_time/domain/prayer_time_repository.dart';

class PrayerTimeRepositoryImpl extends PrayerTimeRepository {
  @override
  Future<List<Pray>> getTimings(DateTime date, Location location) async {
    final myCoordinates = Coordinates(location.latitude, location.longitude);
    final params = CalculationMethod.singapore.getParameters()..madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes(myCoordinates, DateComponents.from(date), params);
    final list = [
      DateFormat('HH:mm').format(prayerTimes.fajr),
      DateFormat('HH:mm').format(prayerTimes.sunrise),
      DateFormat('HH:mm').format(prayerTimes.dhuhr),
      DateFormat('HH:mm').format(prayerTimes.asr),
      DateFormat('HH:mm').format(prayerTimes.maghrib),
      DateFormat('HH:mm').format(prayerTimes.isha),
    ];

    final timings = List<Pray>.generate(shalats.length, (index) => Pray(name: shalats[index], time: list[index]));
    return timings;
  }
}
