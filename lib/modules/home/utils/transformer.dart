import 'package:quran_app/common/constants/constant.dart';
import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';

List<Map<String, dynamic>> fromTimingToList(Timings x) {
  return [
    {'name': Constants().shalats[0], 'value': x.fajr},
    {'name': Constants().shalats[1], 'value': x.sunrise},
    {'name': Constants().shalats[2], 'value': x.dhuhr},
    {'name': Constants().shalats[3], 'value': x.asr},
    {'name': Constants().shalats[5], 'value': x.maghrib},
    {'name': Constants().shalats[6], 'value': x.isha},
    {'name': Constants().shalats[7], 'value': x.imsak},
    {'name': Constants().shalats[9], 'value': x.firstthird},
    {'name': Constants().shalats[10], 'value': x.lastthird},
  ];
}
