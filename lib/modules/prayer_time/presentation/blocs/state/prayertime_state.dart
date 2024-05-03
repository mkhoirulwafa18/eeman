part of '../cubit/prayertime_cubit.dart';

abstract class PrayertimeState extends Equatable {
  const PrayertimeState();

  @override
  List<Object> get props => [];
}

class PrayertimeInitial extends PrayertimeState {}

class PrayertimeLoading extends PrayertimeInitial {}

class PrayertimeLoaded extends PrayertimeInitial {
  PrayertimeLoaded({required this.listOfTiming, this.city});
  final List<Pray> listOfTiming;
  final String? city;

  @override
  List<Object> get props => [listOfTiming, city ?? ''];
}

class PrayertimeError extends PrayertimeInitial {
  PrayertimeError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
