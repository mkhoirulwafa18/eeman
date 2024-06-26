// ignore_for_file: one_member_abstracts

import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/domain/pray.dart';

abstract class PrayerTimeRepository {
  Future<List<Pray>> getTiming(DateTime date, Location location);
  Future<Location> getLocation();
  Future<String> getCity(Location location);
}
