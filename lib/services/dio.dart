// ignore_for_file: inference_failure_on_instance_creation

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';

class DioHelper {
  DioHelper() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://api.aladhan.com/v1/calendarByCity',
      ),
    );
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }
  double lat = 0;
  double long = 0;

  Future<PrayerTime> getTimings(String month, String year) async {
    try {
      await getCurrentLocation().then((value) async {
        lat = value.latitude;
        long = value.longitude;
      });

      final city = await getCityName();
      // ignore: inference_failure_on_function_invocation
      final response = await _dio.get(
        '?city=$city&country=Indonesia&method=11&month=$month&year=$year',
      );
      final result = PrayerTime.fromJson(response.data as Map<String, dynamic>);
      return result;
    } on DioError catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> getCityName() async {
    if (lat != 0 && long != 0) {
      final placemarks = await placemarkFromCoordinates(
        lat,
        long,
      );
      return placemarks[0].subAdministrativeArea.toString();
    }
    return 'Lokasi tidak ditemukan';
  }

  Future<Position> getCurrentLocation() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Future.error('Aktifkan Layanan Lokasi Anda.');
      await Geolocator.openLocationSettings();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        await Future.error('Akses Lokasi ditolak');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      await Future.error(
        'Lokasi tidak diizinkan selamanya, mohon izinkan akses lokasi untuk mengakses fitur ini.',
      );
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  late Dio _dio;
}
