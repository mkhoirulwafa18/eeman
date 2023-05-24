import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';

List<Map<String, dynamic>> fromTimingToList(Timings x) {
  return [
    {'name': shalats[0], 'value': x.lastthird},
    {'name': shalats[1], 'value': x.imsak},
    {'name': shalats[2], 'value': x.fajr},
    {'name': shalats[3], 'value': x.sunrise},
    {'name': shalats[4], 'value': x.dhuhr},
    {'name': shalats[5], 'value': x.asr},
    {'name': shalats[7], 'value': x.maghrib},
    {'name': shalats[8], 'value': x.isha},
    {'name': shalats[10], 'value': x.firstthird},
  ];
}
