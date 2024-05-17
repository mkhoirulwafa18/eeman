import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/common/common.dart';
import 'package:quran_app/common/global_variable.dart';
import 'package:quran_app/modules/home/data/domain/doa_daily.dart';
import 'package:quran_app/modules/home/domain/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<List<Pray>> getTiming(DateTime date, Location location) async {
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

  @override
  Future<Location> getLocation() async {
    final locationService = locator<LocationService>();
    final location = await locationService.getLocation();
    return location ?? Location(latitude: 0, longitude: 0, timestamp: DateTime.now());
  }

  @override
  Future<List<DoaDaily>> getDoaDaily() async {
    final doaResponse = await rootBundle.loadString('assets/sources/doa.json');
    final doaData = doaDailyFromJson(doaResponse);
    return doaData;
  }

  @override
  Future<String> getCity(Location location) async {
    final locationService = locator<LocationService>();
    final city = await locationService.getCity(location);
    log(city ?? 'gada');
    return city ?? '';
  }
}
