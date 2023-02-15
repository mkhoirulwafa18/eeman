import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';

List<Map<String, dynamic>> fromTimingToList(Timings x) {
  return [
    {'name': shalats[10], 'value': x.lastthird},
    {'name': shalats[7], 'value': x.imsak},
    {'name': shalats[0], 'value': x.fajr},
    {'name': shalats[1], 'value': x.sunrise},
    {'name': shalats[2], 'value': x.dhuhr},
    {'name': shalats[3], 'value': x.asr},
    {'name': shalats[5], 'value': x.maghrib},
    {'name': shalats[6], 'value': x.isha},
    {'name': shalats[9], 'value': x.firstthird},
  ];
}
