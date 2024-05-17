import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/domain/pray.dart';

abstract class PrayerTimeState extends Equatable {
  const PrayerTimeState();
  @override
  List<Object?> get props => [];
}

class PrayerTimeInitial extends PrayerTimeState {}

class PrayerTimeLoading extends PrayerTimeState {}

class PrayerTimeError extends PrayerTimeState {
  const PrayerTimeError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class PrayerTimeLoaded extends PrayerTimeState {
  const PrayerTimeLoaded({
    required this.currentSelectedTiming,
    required this.currentLocation,
    required this.currentLocationInCity,
  });
  final List<Pray> currentSelectedTiming;
  final Location currentLocation;
  final String currentLocationInCity;

  @override
  List<Object> get props => [currentSelectedTiming, currentLocation, currentLocationInCity];
}
