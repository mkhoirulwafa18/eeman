part of '../cubit/surah_cubit.dart';

abstract class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object> get props => [];
}

class SurahInitial extends SurahState {
  const SurahInitial();
  @override
  List<Object> get props => [];
}

class SurahLoading extends SurahState {
  const SurahLoading();
  @override
  List<Object> get props => [];
}

class SurahLoaded extends SurahState {
  const SurahLoaded({required this.verses, required this.surahs});

  final List<Verse> verses;
  final List<Surah> surahs;

  @override
  List<Object> get props => [verses];
}

class SurahError extends SurahState {
  const SurahError(this.message);

  final String message;
  @override
  List<Object> get props => [message];
}
