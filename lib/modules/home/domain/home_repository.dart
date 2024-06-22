// ignore_for_file: one_member_abstracts

import 'package:geocoding/geocoding.dart' show Location;
import 'package:quran_app/common/domain/pray.dart';
import 'package:quran_app/modules/home/data/domain/doa_daily.dart';

abstract class HomeRepository {
  Future<List<Pray>> getTiming(DateTime date, Location location);
  Future<List<DoaDaily>> getDoaDaily();
  Future<Location> getLocation();
  Future<String> getCity(Location location);
}
