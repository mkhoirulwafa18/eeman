import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';

class GetTimingsResponse {
  GetTimingsResponse({this.data, this.city, this.error = ''});
  final PrayerTime? data;
  final String? city;
  final String? error;
}
