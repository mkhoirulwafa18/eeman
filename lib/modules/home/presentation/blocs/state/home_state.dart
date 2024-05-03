import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:quran_app/common/domain/pray.dart';
import 'package:quran_app/modules/home/data/domain/doa_daily.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.todayTiming,
    required this.doaDaily,
    required this.currentLocation,
    required this.currentLocationInCity,
    this.tomorrowTiming,
  });
  final List<Pray> todayTiming;
  final List<Pray>? tomorrowTiming;
  final List<DoaDaily> doaDaily;
  final Location currentLocation;
  final String currentLocationInCity;

  @override
  List<Object> get props => [todayTiming, doaDaily, currentLocation];
}
