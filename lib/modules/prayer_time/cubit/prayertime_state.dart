part of 'prayertime_cubit.dart';

abstract class PrayertimeState extends Equatable {
  const PrayertimeState();

  @override
  List<Object> get props => [];
}

class PrayertimeInitial extends PrayertimeState {}

class PrayertimeLoading extends PrayertimeInitial {}

class PrayertimeLoaded extends PrayertimeInitial {
  PrayertimeLoaded({required this.data, required this.city});

  final PrayerTime data;
  final String city;
  @override
  List<Object> get props => [data, city];
}

class PrayertimeError extends PrayertimeInitial {
  PrayertimeError({required this.error});

  final String error;
}
