import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/modules/prayer_time/models/prayer_time.dart';
import 'package:quran_app/services/dio.dart';

part 'prayertime_state.dart';

class PrayertimeCubit extends Cubit<PrayertimeState> {
  PrayertimeCubit(this.dioHelper) : super(PrayertimeInitial());
  final DioHelper dioHelper;

  Future<void> getTimings(String month, String year) async {
    emit(PrayertimeLoading());
    final response = await dioHelper.getTimings(month, year);
    debugPrint('udah dapet timings');
    final city = await dioHelper.getCityName();
    debugPrint('udah dapet city: $city');
    debugPrint('response code: ${response.code}');
    response.code == 200
        ? emit(PrayertimeLoaded(data: response, city: city))
        : emit(PrayertimeError(error: response.toString()));
  }
}
